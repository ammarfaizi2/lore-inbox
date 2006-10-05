Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWJERWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWJERWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWJERWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:22:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750984AbWJERWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:22:03 -0400
Date: Thu, 5 Oct 2006 10:21:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Please pull x86-64 bug fixes
In-Reply-To: <200610051910.25418.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0610051014550.3952@g5.osdl.org>
References: <200610051910.25418.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Oct 2006, Andi Kleen wrote:
> 
> Please pull 'for-linus' from 
> 
>   git://one.firstfloor.org/home/andi/git/linux-2.6

Please write that as

   Please pull 'for-linus' from

   git://one.firstfloor.org/home/andi/git/linux-2.6 for-linus

ie so that I can't miss the branch-name by mistake. I also cut-and-paste 
the repo address (trying to re-type it would be just stupid), and to avoid 
mistakes, it's _much_ easier if I can just triple-click and cut the whole 
line, and then just do

	"git pull <paste>"

without having to be careful about cutting at just the right character and 
then having to write the branch-name separately.

Also, I think these two are totally bogus:

> Andi Kleen:
>       x86-64: Ignore alignment checks in kernel
>       i386: Ignore alignment checks in kernel

Have you actually ever seen an alignment check in the kernel? As far as I 
know, the AC flag is only effective in user space, and anything else would 
be in violation of the whole definition of the AC flag. The i486 manual 
explicitly states that AC events are _only_ handled in ring3.

So I think these both are (a) misleading and (b) wrong.

Please don't do this.

The problem with the AC flag was that it leaked through to user space 
because task switching didn't save/restore eflags properly. We already 
fixed that (same bug as with the NT flag).

			Linus
