Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVAROFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVAROFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 09:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVAROFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 09:05:19 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:8132 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261300AbVAROFI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:05:08 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-7.tower-45.messagelabs.com!1106057106!9481838!1
X-StarScan-Version: 5.4.5; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.4: "access beyond end of device" after ext2 mount
Date: Tue, 18 Jan 2005 09:05:05 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC42B1@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4: "access beyond end of device" after ext2 mount
thread-index: AcT9ZnSvCOVCrAWyQda/Z3QzbcyAYAAADNyA
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Mario Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Andries Brouwer" <aebr@win.tue.nl>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay but what hard drive model and IDE Chipset/Controller are you using?

Thanks!

-----Original Message-----
From: Mario Holbe [mailto:Mario.Holbe@TU-Ilmenau.DE] 
Sent: Tuesday, January 18, 2005 9:02 AM
To: Piszcz, Justin Michael
Cc: Marcelo Tosatti; Andries Brouwer; linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount

On Tue, Jan 18, 2005 at 08:42:08AM -0500, Piszcz, Justin Michael wrote:
> Normally, this problem associated with drives over 32GB or 127GB on a
> controller that cannot support it.  It was not discussed here, I was
> wondering if that is the problem, if it is not, what type of Hard
Drive
> is giving you these problems?

This does not depend on the type of the hard disk for sure.

root@darkside:/dev/shm# dd if=/dev/zero of=foo bs=1024 count=10001
10001+0 records in
10001+0 records out
10241024 bytes transferred in 0,062195 seconds (164659895 bytes/sec)
root@darkside:/dev/shm# losetup /dev/loop0 foo
loop: loaded (max 8 devices)
root@darkside:/dev/shm# mke2fs -b 4096 /dev/loop0
...
root@darkside:/dev/shm# blockdev --getbsz /dev/loop0
1024
root@darkside:/dev/shm# dd if=/dev/loop0 of=/dev/null
20002+0 records in
20002+0 records out
10241024 bytes transferred in 0,248255 seconds (41252031 bytes/sec)
root@darkside:/dev/shm# mount -o ro /dev/loop0 /mnt
root@darkside:/dev/shm# umount /dev/loop0
root@darkside:/dev/shm# blockdev --getbsz /dev/loop0
4096
root@darkside:/dev/shm# dd if=/dev/loop0 of=/dev/null
attempt to access beyond end of device
07:00: rw=0, want=10004, limit=10001
dd: reading `/dev/loop0': Input/output error
20000+0 records in
20000+0 records out
10240000 bytes transferred in 0,185949 seconds (55068833 bytes/sec)

Of course you could reproduce it much more simple without all
the ext2 stuff using blockdev --setbsz :)


Mario
-- 
() Ascii Ribbon Campaign
/\ Support plain text e-mail
