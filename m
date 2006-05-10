Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWEJPri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWEJPri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 11:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWEJPri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 11:47:38 -0400
Received: from are.twiddle.net ([64.81.246.98]:39570 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S1751465AbWEJPrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 11:47:37 -0400
Date: Wed, 10 May 2006 08:47:13 -0700
From: Richard Henderson <rth@twiddle.net>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060510154702.GA28938@twiddle.net>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linuxppc-dev@ozlabs.org
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 02:03:59PM +1000, Paul Mackerras wrote:
> With this patch, 64-bit powerpc uses __thread for per-cpu variables.

How do you plan to address the compiler optimizing

	__thread int foo;
	{
	  use(foo);
	  schedule();
	  use(foo);
	}

into

	{
	  int *tmp = &foo;	// tls arithmetic here
	  use(*tmp);
	  schedule();
	  use(*tmp);
	}

Across the schedule, we may have changed cpus, making the cached
address invalid.


r~
