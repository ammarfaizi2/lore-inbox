Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbTDOOL4 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbTDOOL4 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:11:56 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:37321 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261493AbTDOOLy (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 10:11:54 -0400
Date: Tue, 15 Apr 2003 10:30:24 -0400
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: BUGed to death
Message-ID: <20030415143024.GA10117@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below eliminates 4 BUG() calls that clearly 
cannot happen based on the context.

--- linux-2.5.67-mm2/fs/reiserfs/hashes.c.orig	2003-04-15 10:11:44.000000000 -0400
+++ linux-2.5.67-mm2/fs/reiserfs/hashes.c	2003-04-15 10:13:43.000000000 -0400
@@ -90,10 +90,6 @@
 
 	if (len >= 12)
 	{
-	    	//assert(len < 16);
-		if (len >= 16)
-		    BUG();
-
 		a = (u32)msg[ 0]      |
 		    (u32)msg[ 1] << 8 |
 		    (u32)msg[ 2] << 16|
@@ -116,9 +112,6 @@
 	}
 	else if (len >= 8)
 	{
-	    	//assert(len < 12);
-		if (len >= 12)
-		    BUG();
 		a = (u32)msg[ 0]      |
 		    (u32)msg[ 1] << 8 |
 		    (u32)msg[ 2] << 16|
@@ -137,9 +130,6 @@
 	}
 	else if (len >= 4)
 	{
-	    	//assert(len < 8);
-		if (len >= 8)
-		    BUG();
 		a = (u32)msg[ 0]      |
 		    (u32)msg[ 1] << 8 |
 		    (u32)msg[ 2] << 16|
@@ -154,9 +144,6 @@
 	}
 	else
 	{
-	    	//assert(len < 4);
-		if (len >= 4)
-		    BUG();
 		a = b = c = d = pad;
 		for(i = 0; i < len; i++)
 		{
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

