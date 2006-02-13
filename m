Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWBMA5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWBMA5p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWBMA5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:57:45 -0500
Received: from ns.suse.de ([195.135.220.2]:54743 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751496AbWBMA5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:57:44 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] trap int3 problem while porting a user space application and small cleanup patch
Date: Mon, 13 Feb 2006 01:57:35 +0100
User-Agent: KMail/1.8.2
Cc: Roberto Nibali <ratz@drugphish.ch>, linux-kernel@vger.kernel.org
References: <43EF6B7D.5080607@drugphish.ch>
In-Reply-To: <43EF6B7D.5080607@drugphish.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602130157.36084.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 February 2006 18:08, Roberto Nibali wrote:
> Hello,
> 
> For a while I've been working on a little tool called mpt-status to be 
> able to monitor LSI based controllers. The source can be found here:
> 
>      http://www.drugphish.ch/~ratz/mpt-status/
> 
> The issue I'm trying to track down now is why I cannot get it to work on 
> a x86_64 kernel (Sun Fire V20z with AMD Opteron(tm) Processor 252 on 
> SLES 9 PL3). I suspect 32/64 bit issues between in my ioctl message 
> passing between user space and kernel space.

Quite possible. The mpt ioctls would need a ioctl conversion handler
to allow a 32bit program to use the 64bit ioctls. Or just use a 64bit
executable.

> Unfortunately when I strace  
> the kernel spits out tons of following entries:

Some kernel versions printed that with strace. I think I fixed it in
mainline, but I can't remember if it was fixed in SLES9 too (apparently not)
It's fairly harmless, just ignore it. If it really bothers you you can
turn it off with echo 0 > /proc/sys/debug/exception-trace


> 
> Attached is a small code style cleanup patch that resulted from my 
> skimming through the arch/x86_64/kernel/traps.c code to figure out what 
> went haywire. If Andi is ok with it, please consider applying.

Hmm, ok applied.
-Andi
