Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbUATWQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265852AbUATWQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:16:28 -0500
Received: from email-out1.iomega.com ([147.178.1.82]:26347 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265856AbUATWPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:15:11 -0500
Subject: [PATCH] fix blockdev --getro for sr, sd, ide-floppy devs
From: John McKell <mckellj@iomega.com>
To: Paul Bristow <paul@paulbristow.net>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Iomega Corp.
Message-Id: <1074636909.3078.3.camel@lintest.iomegacorp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Jan 2004 15:15:10 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2004 22:15:10.0552 (UTC) FILETIME=[DE676580:01C3DFA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This 2.6.1 patch works by setting gendisk->policy to the correct value
during initialization as the various drivers decide whether or not the
disk is writeable.  This patch persuades "blockdev --getro ..." to
correctly report the read-only state of a newly inserted disk.  This
patch applies to sr.c, sd.c and ide-floppy.c.  ide-cd.c already has
this functionality built into it.

Using an Iomega Zip drive as the test case...

Without the patch, I always see: 

$ sudo blockdev --getro /dev/sda 
0
$

That's only correct for writeable disks though.  Only when the patch
is applied do I see a write-protected disk described correctly:

$ sudo blockdev --getro /dev/sda 
1
$

--John McKell





