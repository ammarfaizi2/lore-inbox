Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422930AbWBAVHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422930AbWBAVHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWBAVHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:07:52 -0500
Received: from mail.topfen.net ([212.24.114.150]:39090 "EHLO mail.topfen.net")
	by vger.kernel.org with ESMTP id S932463AbWBAVHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:07:51 -0500
Date: Wed, 1 Feb 2006 22:07:52 +0100
From: JG <jg@cms.ac>
To: linux-kernel@vger.kernel.org
Subject: 100% cpu usage (kjournald, pdflush) with encrypted disks (dm-crypt)
Message-ID: <20060201220752.382b1927@x90.0x4a47.net>
X-Mailer: Sylpheed-Claws 2.0.0-rc4 (GTK+ 2.8.8; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i've also posted this to dm-crypt mailing list, but here is some
additional info.

i've encrypted my hard disks (whole root, and other disks)
with "cryptsetup luksFormat --cipher aes-cbc-essiv:sha256 --key-size
256" and formatted them with ext3 (-j -m0 -O dir_index).

i'm using 2.6.15.1 kernel on an athlon xp 2400+ with 1GB RAM, VIA
KT400A/VT8237 chipset.

/proc/crypto for aes:
name         : aes
module       : kernel
type         : cipher
blocksize    : 16
min keysize  : 16
max keysize  : 32

i searched for the aes-i586 optimization (that should be in the
kernel?) but i found no other reference to it than
CONFIG_CRYPTO_AES_586=y. guess i'm using the asm optimized code as
there is no other AES option in the kernel.


if i copy files from one encrypted disk to another my cpu usage goes up
to 100% and stays there for the whole copy process. renicing cp itself
doesn't help. 

hdparm settings are the same for all disks except the SATA ones.
 multcount    = 16 (on)
 IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)


kjournald and pdflush use all the cpu time, where kjournald is usually
at about 40-70% and pdflush goes up to 50-60%. this is while copying
large files. the cpu usage of kcryptd is negligible.

if i copy many small files, kcryptd will eat much more cpu, about
30-40% and the rest will be pdflush and kjournald.

all disks are mounted with -o defaults,noatime.

doing a 'mke2fs -j -m0 -O dir_index /dev/mapper/name' will also rise the
cpu usage to its maximum where pdflush takes about 60-70%.
(mke2fs 1.38 (30-Jun-2005) Using EXT2FS Library version 1.38)


is anyone else seeing this and is there a solution (besides using a
non-journalling fs) or do i have to live with it that encryption eats
all my cpu?

tx,
JG
