Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWEOPGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWEOPGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWEOPGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:06:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:31903 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964940AbWEOPGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:06:30 -0400
Date: Mon, 15 May 2006 17:06:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: "Eddie C. Dost" <ecd@skynet.be>
Subject: openpromfs issue
Message-ID: <Pine.LNX.4.61.0605151657510.19978@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


on a machine with 2 X UltraSPARC-II, doing ls -l in the openpromfs tree 
shows both CPUs, but not quite correctly:

/proc/openprom# ls -l
...
 88 dr-xr-xr-x  2 root root 0 May 12 11:04 SUNW,UltraSPARC-II@1c,0
 88 dr-xr-xr-x  2 root root 0 May 12 11:04 SUNW,UltraSPARC-II@1c,0
...

What's wrong is obviously that there cannot be two directories with the 
same name (and on top, the same inode number).

# uname -a
Linux mason 2.6.13-1.1603sp13smp #1 SMP Mon Apr 10 12:38:32 EDT 2006 
sparc64 sparc64 sparc64 GNU/Linux
(Aurora Linux 2.0)

# prtconf -pv
...
    Node 0xf0085030
        :  00000017
        :  00000011
        :  000000a0
        :  00000009
        :  00000001
        :  00000040
        :  00200000
        :  00000040
        :  00000001
        :  00000020
        :  00004000
        :  00000040
        :  00000002
        :  00000020
        :  00004000
        :  00000000
        :  17d78400
        :  000001c0.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'
    Node 0xf008539c
        :  00000017
        :  00000011
        :  000000a0
        :  00000009
        :  00000001
        :  00000040
        :  00200000
        :  00000040
        :  00000001
        :  00000020
        :  00004000
        :  00000040
        :  00000002
        :  00000020
        :  00004000
        :  00000001
        :  17d78400
        :  000001c2.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'
...


Jan Engelhardt
-- 
