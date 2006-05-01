Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWEAPRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWEAPRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 11:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWEAPRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 11:17:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932134AbWEAPRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 11:17:39 -0400
Date: Mon, 1 May 2006 08:17:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Neil Brown <neilb@suse.de>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 004 of 11] md: Increase the delay before marking metadata
 clean, and make it configurable.
In-Reply-To: <20060430231303.6b2bce82.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605010814410.2557@g5.osdl.org>
References: <20060501152229.18367.patches@notabene> <1060501053019.22949@suse.de>
 <20060430224404.1060d29a.akpm@osdl.org> <17493.42109.153523.381980@cse.unsw.edu.au>
 <20060430231303.6b2bce82.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Apr 2006, Andrew Morton wrote:
> 
> Generally I don't think we should be teaching the kernel to accept
> pretend-floating-point numbers like this, especially when a) "delay in
> milliseconds" is such a simple concept and b) it's so easy to go from float
> to milliseconds in userspace.
> 
> Do you really expect that humans (really dumb ones ;)) will be echoing
> numbers into this file?  Or will it mainly be a thing for mdadm to fiddle
> with?

I generally hate interfaces that have some "random base".

So "delay in seconds" is not a random base, because "seconds" is a good SI 
base unit, and there's not a lot of question about it. But once you start 
talking milliseconds on microseconds, I'd actually much rather have a 
"fake floating point number" over having different files have different 
(magic) base constants. How do you remember which are milliseconds, which 
are microseconds, and which are just seconds?

It should be easy to have a helper function or two that takes a "struct 
timeval" and reads/writes a "float".

		Linus
