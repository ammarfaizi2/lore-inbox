Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbTDVJrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 05:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbTDVJrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 05:47:45 -0400
Received: from [80.190.48.67] ([80.190.48.67]:50692 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263032AbTDVJrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 05:47:42 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "Michael B Allen" <mba2000@ioplex.com>
Subject: Re: What's the deal McNeil? Bad interactive behavior in X w/ RH's      2.4.18
Date: Tue, 22 Apr 2003 11:59:39 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030422034821.6a57acc0.mba2000@ioplex.com> <200304221006.09601.m.c.p@wolk-project.de> <38291.207.172.171.44.1051004102.squirrel@miallen.com>
In-Reply-To: <38291.207.172.171.44.1051004102.squirrel@miallen.com>
MIME-Version: 1.0
Message-Id: <200304221155.56841.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LKRp+w4/E3a5wYo"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_LKRp+w4/E3a5wYo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 22 April 2003 11:35, Michael B Allen wrote:

Hi Michael,

> Ok, I searched a little using the Googler at indiana.edu's archives but
> nothing jumped up and bit me. I'm not too excited about applying a patch
Then you are not able to search archives.

http://marc.theaimsgroup.com/?l=linux-kernel&m=105092498721316&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=105060066815681&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103835185429978&w=2

The 3rd url has a config option. Same attached w/o config option.

> snarfed out of an e-mail anywat. I'm surprised no one else has not
> complained about this enough to the point where you guys don't have a
> canned answer with a link. Is this problem not considered important?
there were some complaints. Anyway, if it's important or not depends on the 
point of view. For me, it is _mega_ important, for mainline 2.4, I don't 
think it is important ;)

> Does anyone know which RH patch in the 2.4.18-10 RPM adds this elevator
> throughput "improvement"? What identifiers would such a patch have in it?
Look for a patch that adds "2.4.19-pre*".

> PS: Why are there only "hacks"? Is this not considered important?
Well, the attached one is really a hack. It drops throughput ~20-30 % but gets 
rid of all the annyoing pauses/stops while disk i/o. The 2 other approaches 
are no real hacks though they also drop throughput.

You can also try "elvtune -r 0 -w 8192 /dev/bla" and see if it makes any 
difference if you don't want to patch anything.

ciao, Marc
--Boundary-00=_LKRp+w4/E3a5wYo
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="lowlat-elevator-hack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lowlat-elevator-hack.patch"

--- old/drivers/block/ll_rw_blk.c	2002-12-18 01:03:50.000000000 +0100
+++ new/drivers/block/ll_rw_blk.c	2003-04-22 11:49:36.000000000 +0200
@@ -432,9 +432,7 @@ static void blk_init_free_list(request_q
 
 	si_meminfo(&si);
 	megs = si.totalram >> (20 - PAGE_SHIFT);
-	nr_requests = 128;
-	if (megs < 32)
-		nr_requests /= 2;
+	nr_requests = 4;
 	blk_grow_request_list(q, nr_requests);
 
 	init_waitqueue_head(&q->wait_for_requests[0]);
--- old/include/linux/elevator.h	2002-12-18 01:03:59.000000000 +0100
+++ new/include/linux/elevator.h	2003-04-22 11:49:58.000000000 +0200
@@ -93,8 +93,8 @@ static inline int elevator_request_laten
 
 #define ELEVATOR_LINUS							\
 ((elevator_t) {								\
-	2048,				/* read passovers */		\
-	8192,				/* write passovers */		\
+	0,				/* read passovers */		\
+	0,				/* write passovers */		\
 									\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\

--Boundary-00=_LKRp+w4/E3a5wYo--

