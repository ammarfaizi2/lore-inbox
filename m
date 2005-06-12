Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVFLUvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFLUvR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 16:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVFLUvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 16:51:17 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:44556 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261203AbVFLUvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 16:51:13 -0400
Date: Sun, 12 Jun 2005 22:49:55 +0200
From: Willy Tarreau <willy@w.ods.org>
To: DJ.CnX@phreaker.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: execve-bug ...
Message-ID: <20050612204955.GC8907@alpha.home.local>
References: <20050612212306.7383a6bd.DJ.CnX@phreaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612212306.7383a6bd.DJ.CnX@phreaker.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 09:23:06PM +0200, DJ.CnX@phreaker.net wrote:
 
> shell# nasm -f elf -o new.o new.asm 
> shell# ld -o new new.o
> shell# ./new
> Segmentation Fault.
> 
> 
> 
> i even tried to execute the binary i've compiled on 2.6.5.x but it didnt
> work : Segmentation Fault. So i think its a bug in the "execve"-function. 

well, fortunately this is not the case or you would have some difficulties
executing your tools. You should find litterature about all the options
you have to pass to 'ld' to use it this way, or simpler : use gcc as the
linker and keep 'main' as your program's entry point, it WILL work.

You should have tried 'strace -i ./new', it would have showed you that
the program pointer is invalid (I see b7f63fae here), while on older
kernels it was still 8048080. This does not necessarily mean there's a
bug in execve(), but most probably that this code would have worked
before because of a side effect and that this side effect has been
closed now.

For instance, you can check asmutils which still works. But please,
don't post newbie asm problems here, this definitely is not the right
list.

Regards,
Willy

