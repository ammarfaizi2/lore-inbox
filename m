Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVHKRcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVHKRcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVHKRcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:32:17 -0400
Received: from are.twiddle.net ([64.81.246.98]:24467 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S932273AbVHKRcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:32:16 -0400
Date: Thu, 11 Aug 2005 10:32:03 -0700
From: Richard Henderson <rth@twiddle.net>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050811173203.GA31610@twiddle.net>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20050810080057.GA5295@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810080057.GA5295@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 10:00:57AM +0200, Christoph Hellwig wrote:
> The sys_ptrace boilerplate code (everything outside the big switch
> statement for the arch-specific requests) is shared by most
> architectures.  This patch moves it to kernel/ptrace.c and leaves the
> arch-specific code as arch_ptrace.

The signature of arch_ptrace needs to return long, and not int.
The PTRACE_PEEK{TEXT,DATA,USR} requests return a "word", which 
on 64-bit arches needs to be a 64-bit type.


r~
