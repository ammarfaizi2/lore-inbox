Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129702AbQKTXfo>; Mon, 20 Nov 2000 18:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQKTXff>; Mon, 20 Nov 2000 18:35:35 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:34311 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129837AbQKTXfZ>; Mon, 20 Nov 2000 18:35:25 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Brian Kress <kressb@fsc-usa.com>, linux-kernel@vger.kernel.org,
        Oliver Poths <oliver.poths@linsoft.de>,
        Tigran Aivazian <tigran@veritas.com>
Date: Tue, 21 Nov 2000 10:05:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14873.44574.812991.517258@notabene.cse.unsw.edu.au>
Subject: Re: 2.4.0-test11 crashes on boot with RAID5
In-Reply-To: message from Neil Brown on Tuesday November 21
In-Reply-To: <3A199124.DE66EA0B@fsc-usa.com>
	<14873.43714.765769.268823@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday November 21, neilb@cse.unsw.edu.au wrote:
> On Monday November 20, kressb@fsc-usa.com wrote:
> >         Hi all.  2.4.0-test11 is crashing during bootup while
> > detecting my raid5 array.  According to the EIP printed (assuming
> > I did it right), that's in the function xor_block().
> >         2.4.0-test10 works fine with the same .config.  One of the
> > things in the change file for test11 is "make raid 5 work in himem
> > configs".  Maybe that broke non himem configs?
> >         My .config is attached.  If anyone needs anymore information,
> > let me know.
> 
> To fix:
> 
> 
> - in drivers/md/Makefile
> 
> - find line that contains:
>     raid5.o xor.o
> 
> - swap the .o files to:
>     xor.o raid5.o
> 
> - recompile
> - reboot
> - be happy
> 
> NeilBrown

Opp. No. I take that back.
It is a bit more complicated.
You have to get "xor.o" before "md.o", not before "raid5.o".

try:

--- drivers/md/Makefile	2000/11/20 23:04:31	1.1
+++ drivers/md/Makefile	2000/11/20 23:04:36
@@ -16,11 +16,11 @@
 obj-n		:=
 obj-		:=
 
-obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_MD_LINEAR)		+= linear.o
 obj-$(CONFIG_MD_RAID0)		+= raid0.o
 obj-$(CONFIG_MD_RAID1)		+= raid1.o
 obj-$(CONFIG_MD_RAID5)		+= raid5.o xor.o
+obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_BLK_DEV_LVM)	+= lvm-mod.o
 
 # Translate to Rules.make lists.


NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
