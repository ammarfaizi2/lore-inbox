Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWFIT3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWFIT3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWFIT3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:29:32 -0400
Received: from terminus.zytor.com ([192.83.249.54]:8322 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030251AbWFIT3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:29:31 -0400
Message-ID: <4489CC04.10506@zytor.com>
Date: Fri, 09 Jun 2006 12:29:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
References: <44869397.4000907@tls.msk.ru> <Pine.LNX.4.64.0606080036250.17704@scrub.home> <e69fu3$5ch$1@terminus.zytor.com> <Pine.LNX.4.64.0606091409220.17704@scrub.home> <e6cgjv$b8t$1@terminus.zytor.com> <4489C83F.40307@tls.msk.ru>
In-Reply-To: <4489C83F.40307@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> 
> You *do* need mdadm to boot from RAID.  Unless you rely on broken,
> obsolete, "don't use" in-kernel raid autodetection code (which, in
> this case, will be moved from kernel space into kinit).  There are
> many reasons why raid autodetection in its current form is not a good
> idea, all goes to simple "unreliable" definition - there where many
> discussions about this already.
> 
> Well ok, mdadm/Assemble.c can be merged into kinit instead of current
> stuff present there, and adopted somehow.  Until when, mdadm IS
> necessary.
> 
> Ok, the next question may be 'and what about lvm?', or dm, or whatever
> else..  Md autodetection code has been in kernel for a long time,
> while lvm/dm/etc stuff wasn't.  So there IS a difference... ;)
> 
> But I see a reason for kinit *now*, in its current form - it's
> compatibility.  Later on, maybe the whole stuff can be removed entirely,
> to rely on external tools for booting.  Existing mkinitrd/mkinitramfs/
> etc solutions works, they're being improved all the time, and they
> don't use kinit.
> 
> Did I get it all right?  :)
> 

Pretty much.  :)

However, this also is a good basis to point out that one of the big advantages with klibc 
is that you *can* share code with standalone userspace tools with relative ease.  For 
example, porting mdadm/Assemble.c to be a tool -- be it standalone or integrated into 
kinit -- is a pretty trivial project, whereas trying to integrate code like that into the 
kernel proper is a major task.

As you can also notice, a number of modules of kinit are also available as standalone 
programs (and, in fact, I have already gotten requests to break out additional modules in 
the same way.)  This means that that code is available to distributions to use in their 
initramfs solutions, without having to take the kinit package.  Finally, unlike the 
current code, kinit can be wrapped, as is, from a script.

	-hpa

