Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293578AbSBZLi2>; Tue, 26 Feb 2002 06:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293579AbSBZLiS>; Tue, 26 Feb 2002 06:38:18 -0500
Received: from mtao1.east.cox.net ([68.1.17.244]:36508 "EHLO
	lakemtao01.cox.net") by vger.kernel.org with ESMTP
	id <S293578AbSBZLiC>; Tue, 26 Feb 2002 06:38:02 -0500
Message-ID: <006001c1beb9$ea412690$a7eb0544@CX535256D>
From: "Barubary" <barubary@cox.net>
To: <linux-kernel@vger.kernel.org>
Subject: ISO9660 bug and loopback driver bug
Date: Tue, 26 Feb 2002 03:37:04 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, the ISO9660 bug.  The ISO file system driver in Linux doesn't handle
leap years correctly.  It assumes all years divisible by 4 are leap years,
which is incorrect.  For those that don't know the right algorithm, all
years that (are divisible by 4) and ((not divisible by 100), or (divisible
by 400)) are leap years.  ISO file dates on or after March 1, 2100 will be 1
day off when viewed under Linux as a result.  The bug is in fs/isofs/util.c,
function iso_date().  This is a very low priority bug, because a) nobody
cares about ISO file date accuracy including me; and b) it shouldn't matter
until 2100.  Anyone bored enough to fix this? :)  I guess I could do it...

Now the loopback bug.  Files whose size is greater than 2^31-1 don't work
with the loopback driver.  It fails with strange errors, like "device not
found".  This bug prevents DVD-ROM .iso files from being mounted as either
UDF or ISO file systems - the particular use I encountered it with.  It's a
bit higher of a priority than the ISO9660 date bug, because it prevents
useful features from working.  Still not too important though.

The above were encountered on 2.4.17, and are both in 2.4.18.

-- Barubary

