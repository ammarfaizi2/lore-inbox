Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbUK2Vuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbUK2Vuc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 16:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUK2Vub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 16:50:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:29359 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261810AbUK2VuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 16:50:18 -0500
Date: Mon, 29 Nov 2004 22:50:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
In-Reply-To: <1101763996l.13519l.0l@werewolf.able.es>
Message-ID: <Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr>
References: <1101763996l.13519l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi all...
>
>I'm trying to get out of the mess that cd burning looks like nowadays in
>linux...
>
>As I use a 2.6.x kernel, I folowed this hints:
>- no suid cdrecord, it uses capabilities
>- make the burner owned by console user (pam)
>
>cdrecord burns ok using dev=/dev/burner, but I can't get GUI tools to
>burn using the /dev interface. All of them try to load ide-scsi, and
>do a scan based on ATAPI:.
>Some tools try to scan with dev=ATA:x:y:z, but that does not work as
>normal user.

Maybe because it should have been dev=ATAPI: ?

>How can I make 'cdrecord dev=ATA -scanbus' work as non-root ?

Weird, works for me:

22:49 io:~ > cdrecord -dev=ATAPI: -scanbus
Cdrecord-Clone 2.01 (i686-suse-linux) Copyright (C) 1995-2004 Jˆrg Schilling
Note: This version is an unofficial (modified) version
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to
http://www.suse.de/feedbackNote: The author of cdrecord should not be bothered
with problems in this version.
scsidev: 'ATAPI:'
devname: 'ATAPI'
scsibus: -1 target: -1 lun: -1
Warning: Using ATA Packet interface.
Warning: The related Linux kernel interface code seems to be unmaintained.
Warning: There is absolutely NO DMA, operations thus are slow.
cdrecord: No such file or directory. Cannot open SCSI driver.
cdrecord: For possible targets try 'cdrecord -scanbus'. Make sure you are root.
cdrecord: For possible transport specifiers try 'cdrecord dev=help'.
22:50 io:/dev # chmod 666 /dev/hdd
22:50 io:~ > cdrecord -dev=ATAPI: -scanbus
Cdrecord-Clone 2.01 (i686-suse-linux) Copyright (C) 1995-2004 Jˆrg Schilling
[...]
Warning: The related Linux kernel interface code seems to be unmaintained.
Warning: There is absolutely NO DMA, operations thus are slow.
Using libscg version 'schily-0.8'.
scsibus0:
        0,0,0     0) *
        0,1,0     1) 'AOPEN   ' 'CD-RW CRW1232PRO' '1.00' Removable CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

And further (in addition to above):
22:50 io:/dev # chmod 666 /dev/hdb
22:50 io:~ > cdrecord -dev=ATAPI: -scanbus
scsibus0:
        0,0,0     0) *
cdrecord: Warning: controller returns wrong size for CD capabilities page.
        0,1,0     1) '        ' 'ATAPI CDROM     ' '100H' Removable CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
scsibus1:
        1,0,0   100) *
        1,1,0   101) 'AOPEN   ' 'CD-RW CRW1232PRO' '1.00' Removable CD-ROM
        1,2,0   102) *
        1,3,0   103) *
        1,4,0   104) *
        1,5,0   105) *
        1,6,0   106) *
        1,7,0   107) *

Apart from the fact that scsibus shifts up by one, Works For Me(TM)


Jan Engelhardt
-- 
Gesellschaft f√ºr Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 G√∂ttingen, www.gwdg.de
