Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbUK2WD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUK2WD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUK2WD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:03:26 -0500
Received: from smtp07.auna.com ([62.81.186.17]:18334 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261816AbUK2WDJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:03:09 -0500
Date: Mon, 29 Nov 2004 21:59:15 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1101763996l.13519l.0l@werewolf.able.es>
	<Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr> (from
	jengelh@linux01.gwdg.de on Mon Nov 29 22:50:11 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101765555l.13519l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.11.29, Jan Engelhardt wrote:
> >Hi all...
> >
> >I'm trying to get out of the mess that cd burning looks like nowadays in
> >linux...
> >
> >As I use a 2.6.x kernel, I folowed this hints:
> >- no suid cdrecord, it uses capabilities
> >- make the burner owned by console user (pam)
> >
> >cdrecord burns ok using dev=/dev/burner, but I can't get GUI tools to
> >burn using the /dev interface. All of them try to load ide-scsi, and
> >do a scan based on ATAPI:.
> >Some tools try to scan with dev=ATA:x:y:z, but that does not work as
> >normal user.
> 
> Maybe because it should have been dev=ATAPI: ?
> 
> >How can I make 'cdrecord dev=ATA -scanbus' work as non-root ?
> 
> Weird, works for me:
> 
> 22:49 io:~ > cdrecord -dev=ATAPI: -scanbus

dev=ATAPI uses ide-scsi interface, through /dev/sgX. And:

> scsibus: -1 target: -1 lun: -1
> Warning: Using ATA Packet interface.
> Warning: The related Linux kernel interface code seems to be unmaintained.
> Warning: There is absolutely NO DMA, operations thus are slow.

dev=ATA uses direct IDE burning. Try that as root. In my box, as root:

werewolf:~# cdrecord dev=ATAPI -scanbus
scsibus0:
        0,0,0     0) *
        0,1,0     1) 'TOSHIBA ' 'DVD-ROM SD-M1712' '1004' Removable CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
scsibus1:
        1,0,0   100) 'HL-DT-ST' 'DVDRAM GSA-4120B' 'A102' Removable CD-ROM
        1,1,0   101) *
        1,2,0   102) *
        1,3,0   103) *
        1,4,0   104) *
        1,5,0   105) *
        1,6,0   106) *
        1,7,0   107) *

werewolf:~# cdrecord dev=ATA -scanbus
scsidev: 'ATA'
devname: 'ATA'
scsibus: -2 target: -2 lun: -2
#########################################################################################
#
#  Warning: Using ATAPI via /dev/hd* interface. Use dev=ATA:X,Y,Z or dev=/dev/hdX
#
#########################################################################################

scsibus0:
        0,0,0     0) *
        0,1,0     1) 'TOSHIBA ' 'DVD-ROM SD-M1712' '1004' Removable CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
scsibus1:
        1,0,0   100) 'HL-DT-ST' 'DVDRAM GSA-4120B' 'A102' Removable CD-ROM
        1,1,0   101) *
        1,2,0   102) *
        1,3,0   103) *
        1,4,0   104) *
        1,5,0   105) *
        1,6,0   106) *
        1,7,0   107) *

The scan through ATA lasts much less than with ATAPI, and you can burn with
dev=ATA:1,0,0 or dev=/dev/burner, which is the new recommended way.

But as I said, scanning through ATA is not avaliable to normal users, so
it is someway useless.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


