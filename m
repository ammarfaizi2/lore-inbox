Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267591AbUHXLlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267591AbUHXLlM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267532AbUHXLku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:40:50 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:55006 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S267549AbUHXLhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:37:51 -0400
Message-ID: <00f301c489ce$c2cd01a0$1225a8c0@kittycat>
From: "jdow" <jdow@earthlink.net>
To: <linux-kernel@vger.kernel.org>
Subject: Amiga partition reading patch
Date: Tue, 24 Aug 2004 04:37:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch known good against Mandrake 2.6.3-7mdk. I suspect it will
apply to later versions equally well since the file affected appears to
be unchanged as late as 2.6.9-rc1.

I have a large archive of files stored on Amiga volumes. Many of these
volumes are on Fujitsu magneto-optical disks with 2k sector size. The
existing partitioning code cannot properly read them since it appears
the OS automatically deblocks the large sectors into logical 512 byte
sectors, something AmigaDOS never did. I arranged the partitioning code
to handle this situation.

Second I have some rather strange test case disks, including my largest
storage partition, that have somewhat unusual partition values. As such
I needed additional information in addition to the first and last block
number information. AmigaDOS reserves N blocks, with N greater than or
equal to 1 and less than the size of the partition, for some boot time
information and signatures. I have some partitions that use other than
the usual value of 2.

There is one more "fix" that could be put in if someone needs it. Another
value in the "Rigid Disk Blocks" description of a partition is a "PreAlloc"
value. It defines a number of blocks at the end of the disk that are not
considered to be a real part of the partition. This was "important" in
the days of 20 meg and 40 meg hard disks. It is hardly important and not
used on modern drives without special user intervention.

This partitioning information is known correct. I wrote the low level
portion of the hard disk partitioning code for AmigaDOS 3.5 and 3.9. I
am also responsible for one of the more frequently used partitioning
tools, RDPrepX, before that.

Please consider adding this to the build tree as a completeness item.

Thank you.
{^_^}   Joanne Dow, jdow@earthlink.net
        (I tried submitting this to Roland a couple times now and
        nothing happened so I am submitting it to the list.)

