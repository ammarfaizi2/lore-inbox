Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSGMCYN>; Fri, 12 Jul 2002 22:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318029AbSGMCYM>; Fri, 12 Jul 2002 22:24:12 -0400
Received: from pD952ACB5.dip.t-dialin.net ([217.82.172.181]:61320 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318020AbSGMCYL>; Fri, 12 Jul 2002 22:24:11 -0400
Date: Fri, 12 Jul 2002 20:26:49 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: ultralinux@vger.kernel.org
Subject: Lots of outdated LVM stuff in the kernel...
Message-ID: <Pine.LNX.4.44.0207122023240.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In arch/sparc64/kernel/ioctl32.c (and some other 64-bit architectures), we 
find lots of old and broken LVM code, for example:

static void put_lv_t(lv_t *l)
{
        if (l->lv_current_pe) vfree(l->lv_current_pe);
        if (l->lv_block_exception) vfree(l->lv_block_exception);
        kfree(l);
}

lv_t doesn't have lv_current_pe and lv_block_exception any more for ages. 
The code should either be updated or removed completely.

Wondering why I'm hitting this all? I'm currently doing make allmodconfig 
(kbuild-2.5) on a sparc64...

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

