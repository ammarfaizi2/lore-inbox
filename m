Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWCTG36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWCTG36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWCTG36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:29:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932087AbWCTG35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:29:57 -0500
Date: Sun, 19 Mar 2006 22:26:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Willy Tarreau <willy@w.ods.org>
cc: Andrew Morton <akpm@osdl.org>, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com, viro@ftp.linux.org.uk
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <20060320061212.GG21493@w.ods.org>
Message-ID: <Pine.LNX.4.64.0603192223530.3622@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
 <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
 <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org> <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
 <20060320061212.GG21493@w.ods.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Mar 2006, Willy Tarreau wrote:
> 
> Now, does removing the macro completely change the output code ?
> I think that if something written like this produces the same
> code, it would be easier to read :
> 
> #define for_each_cpu_mask(cpu, mask)			\
> 	for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++) {	\
> 		unsigned long __bits = (mask).bits[0] >> (cpu); \
> 		if (!__bits)				\
> 			break;				\
> 		if (!__bits & 1)			\
> 			continue;			\
> 		else

Absolutely, but now it has a dangling "{" that didn't get closed. So the 
above would definitely be more readable, it just doesn't actually work.

Unless you'd do the "end_for_each_cpu" define (to close the statement), 
and update the 300+ places that use this. Which might well be worth it.

So the subtle "break from the middle of a statement expression" was just a 
rather hacky way to avoid having to change all the users of this macro.

			Linus
