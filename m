Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWESD7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWESD7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 23:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWESD7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 23:59:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8926 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932206AbWESD7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 23:59:34 -0400
Date: Thu, 18 May 2006 23:59:32 -0400
From: Dave Jones <davej@redhat.com>
To: Stephane Ouellette <ouellettes@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]   Compile warning because of an uninitialized variable
Message-ID: <20060519035932.GA30894@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stephane Ouellette <ouellettes@videotron.ca>,
	linux-kernel@vger.kernel.org
References: <446D4045.9090304@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446D4045.9090304@videotron.ca>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 11:49:25PM -0400, Stephane Ouellette wrote:
 > Folks,
 > 
 >    gcc generates a warning because of an uninitialized variable in 
 >    arch/i386/kernel/cpu/transmeta.c.
 > The variable "cpu_freq" is initialized by a call to cpuid(). The following 
 > patch fixes the warning.

This is a gcc bug. The variable is passed by reference
to a function where the assignment is made.
The second time it's used, if that > 80860002 condition
is satisfied, we *must* have satisfied the previous
check where we made the assignment, as 'max' hasn't changed
between the two checks.

		Dave

-- 
http://www.codemonkey.org.uk
