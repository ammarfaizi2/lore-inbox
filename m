Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbUKVMq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUKVMq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 07:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUKVMq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 07:46:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4359 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262049AbUKVMqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 07:46:20 -0500
Date: Mon, 22 Nov 2004 13:46:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] Use -ffreestanding? (fwd)
Message-ID: <20041122124618.GJ3007@stusta.de>
References: <20041122054959.GI3007@stusta.de> <Pine.LNX.4.58.0411212208200.20993@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411212208200.20993@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 10:10:28PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 22 Nov 2004, Adrian Bunk wrote:
> > 
> > for the kernel, it would be logical to use -ffreestanding. The kernel is 
> > not a hosted environment with a standard C library.
> > 
> > Linus agreed that it would make sense.
> 
> Note that while I agree that it sounds sensible, it would be good to have 
> somebody specify exactly what changes from the use of "-ffreestanding".
> 
> I _assume_ that all the things that gcc takes for granted are things that 
> Linux already has its own definitions for, and that -ffreestanding doesn't 
> actually change anything for at least the regular architectures. But if 
> there is any object code changes, can you check those out and explain 
> them?

Andi Kleen reported:
  Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str) transparently.

This is only true with unit-at-a-time (disabled on i386 but enabled
on x86_64). The Linux kernel doesn't offer a standard C library, and 
such transparent replacements of kernel functions with builtins are 
quite fragile.

Even with -ffreestanding, it's still possilble to explicitely use a gcc 
builtin if desired.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

