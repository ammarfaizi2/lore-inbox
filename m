Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310211AbSCKQwB>; Mon, 11 Mar 2002 11:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310209AbSCKQvn>; Mon, 11 Mar 2002 11:51:43 -0500
Received: from host194.steeleye.com ([216.33.1.194]:15884 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S310208AbSCKQvf>; Mon, 11 Mar 2002 11:51:35 -0500
Message-Id: <200203111651.g2BGpUF06663@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@steeleye.com
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Mar 2002 11:51:29 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resend: vger ate the email with the diffs inline]

I've done a first pass at the separation Dave Jones Suggested.

The patches are here (diff is 250k, BK patch 25k):

http://www.hansenpartnership.com/voyager/files/split-2.4.6.diff
http://www.hansenpartnership.com/voyager/files/split-2.4.6.BK

(The bitkeeper patch is much smaller because a lot of files are only moved).

This split introduces new generic and visw directories and pulls all of the 
visw specific defines out of kernel (except for some tiny cases inside 
smpboot.c which were rather difficult to hook out).  It also contains 
preparatory abstraction work for me doing the same split for my voyager patch.

The basics of the patch are:

- creating a set of hooks which all archs must supply (asm-i386/arch_hooks.h)
- adding some arch specific includes for inline functions (currently only for 
hooks in the timer interrupt).
- using more fine grained CONFIG_X86_* options to turn on and off other pieces 
of the compile.

Please provide feedback; I'm going to continue on now and try to place voyager 
in this abstraction (so I'll probably be adding more hooks and things).

James


