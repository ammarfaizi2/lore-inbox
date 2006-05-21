Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWEUFvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWEUFvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 01:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWEUFvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 01:51:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:49668 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751465AbWEUFvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 01:51:12 -0400
Date: Sun, 21 May 2006 07:48:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cannot load *any* modules with 2.4 kernel
Message-ID: <20060521054826.GA14334@w.ods.org>
References: <446F3F6A.9060004@cmu.edu> <20060520162529.GT11191@w.ods.org> <446FAEE3.6060003@cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446FAEE3.6060003@cmu.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 08:05:55PM -0400, George Nychis wrote:
> Okay, so heres what I did.  I downloaded modutils version 2.4.27 and
> extracted it to /usr/local/modutils
> 
> Then in my 2.4.32 kernel's Makefile, I changed the DEPMOD variable to
> point to /usr/local/modutils/sbin/depmod
> 
> Then I build the kernel with:
> make dep && make bzImage modules modules_install && make install
> 
> So then my initrd gets generated, I reboot to the 2.4.32 kernel, and
> thats where i'm at now.
> 
> So then for instance I goto /lib/modules/2.4.32/net and do:
> /usr/local/modutils/sbin/insmod 8390.o
> 
> and I see all those unresolved symbols

Hmmm 8390.o needs crc32.o (or maybe you built it into your kernel).
Could you please :
  - grep 8390.o /lib/modules/2.4.32/modules.dep
  - post the exact list of unresolved symbols that insmod outputs
  - grep 2 or 3 of them in /proc/ksyms (eg: printk)
  - post your .config so that we can find a way to reproduce your problem.

> So maybe now that you have more info, we can figure something out.

By the time you do this, it would also be interesting to retry without
CONFIG_MODVERSIONS. Oh, and please report your gcc and binutils versions
so that we can be as close as possible to your conditions when trying
to reproduce.

> Thanks!
> George

Regards,
willy

