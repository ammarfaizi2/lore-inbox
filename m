Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWCGTAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWCGTAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWCGTAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:00:52 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:39851
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S932167AbWCGTAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:00:52 -0500
Date: Tue, 7 Mar 2006 11:59:51 -0600
From: Matt Mackall <mpm@selenic.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, "Anders K. Pedersen" <akp@cohaesio.com>
Subject: Re: [PATCH] Let DAC960 supply entropy to random pool]
Message-ID: <20060307175951.GH14549@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add disk entropy in DAC960 request completions.

Signed-off-by: Matt Mackall <mpm@selenic.com>
Tested-by: Anders K. Pedersen <akp@cohaesio.com>

Index: 2.6/drivers/block/DAC960.c
===================================================================
--- 2.6.orig/drivers/block/DAC960.c	2006-03-01 23:32:32.000000000 -0600
+++ 2.6/drivers/block/DAC960.c	2006-03-06 11:41:45.000000000 -0600
@@ -41,6 +41,7 @@
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/random.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include "DAC960.h"
@@ -3463,7 +3464,7 @@ static inline boolean DAC960_ProcessComp
 		Command->SegmentCount, Command->DmaDirection);
 
 	 if (!end_that_request_first(Request, UpToDate, Command->BlockCount)) {
-
+		add_disk_randomness(Request->rq_disk);
  	 	end_that_request_last(Request, UpToDate);
 
 		if (Command->Completion) {


-- 
Mathematics is the supreme nostalgia of our time.

