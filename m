Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbTBUFO2>; Fri, 21 Feb 2003 00:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTBUFO0>; Fri, 21 Feb 2003 00:14:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:35515 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267154AbTBUFOQ>;
	Fri, 21 Feb 2003 00:14:16 -0500
Date: Thu, 20 Feb 2003 21:25:54 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: iosched: time to copy many small files
Message-Id: <20030220212554.3e99ec3e.akpm@digeo.com>
In-Reply-To: <20030220212304.4712fee9.akpm@digeo.com>
References: <20030220212304.4712fee9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 05:24:16.0565 (UTC) FILETIME=[7A40B650:01C2D969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This test simply measures how long it takes to copy a large number of files
within the same filesystem.  It creates a lot of small, competing read and
write I/O's.  Changes which were made to the VFS dirty memory handling early
in the 2.5 cycle tends to make 2.5 a bit slower at this.

Three copies of the 2.4.19 kernel tree were placed on an ext2 filesystem. 
Measure the time it takes to copy them all to the same filesystem, and to
then sync the system.  This is just

	cp -a ./dir-with-three-kernel-trees/ ./new-dir
	sync

The anticipatory scheduler doesn't help here.  It could, but we haven't got
there yet, and it may need VFS help.

2.4.21-pre4:	70 seconds
2.5.61+hacks:	72 seconds
2.5.61+CFQ:	69 seconds
2.5.61+AS:	66 seconds



