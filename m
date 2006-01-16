Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWAPIIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWAPIIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 03:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWAPIIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 03:08:15 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:11649 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S932243AbWAPIIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 03:08:14 -0500
Message-ID: <43CB4C03.7070304@wolfmountaingroup.com>
Date: Mon, 16 Jan 2006 00:32:19 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk>
In-Reply-To: <43CB4CC3.4030904@fastmail.co.uk>
Content-Type: multipart/mixed;
 boundary="------------020908010604050004060206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020908010604050004060206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Max Waterman wrote:

> Hi,
>
> I've been referred to this list from the linux-raid list.
>
> I've been playing with a RAID system, trying to obtain best bandwidth
> from it.
>
> I've noticed that I consistently get better (read) numbers from kernel 
> 2.6.8
> than from later kernels.


To open the bottlenecks, the following works well.  Jens will shoot me 
for recommending this,
but it works well.  2.6.9 so far has the highest numbers with this fix.  
You can manually putz
around with these numbers, but they are an artificial constraint if you 
are using RAID technology
that caches ad elevators requests and consolidates them.


Jeff



--------------020908010604050004060206
Content-Type: text/x-patch;
 name="blkdev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blkdev.patch"


diff -Naur ./include/linux/blkdev.h ../linux-2.6.9/./include/linux/blkdev.h
--- ./include/linux/blkdev.h	2004-10-18 15:53:43.000000000 -0600
+++ ../linux-2.6.9/./include/linux/blkdev.h	2005-12-06 09:54:46.000000000 -0700
@@ -23,8 +23,10 @@
 typedef struct elevator_s elevator_t;
 struct request_pm_state;
 
-#define BLKDEV_MIN_RQ	4
-#define BLKDEV_MAX_RQ	128	/* Default maximum */
+//#define BLKDEV_MIN_RQ	4
+//#define BLKDEV_MAX_RQ	128	/* Default maximum */
+#define BLKDEV_MIN_RQ	4096
+#define BLKDEV_MAX_RQ	8192	/* Default maximum */
 

--------------020908010604050004060206--
