Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSLQArp>; Mon, 16 Dec 2002 19:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSLQArp>; Mon, 16 Dec 2002 19:47:45 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:7329 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S263899AbSLQAro>;
	Mon, 16 Dec 2002 19:47:44 -0500
Date: Tue, 17 Dec 2002 01:55:39 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: jiri.wichern@hccnet.nl
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: PROBLEM: kernel 2.4.20 option CONFIG_BLK_STATS breaks /proc/partitons so "mount" can't mount devices by UUID.
Message-ID: <20021217005539.GA11900@win.tue.nl>
References: <3DFE6ED2.7174.1395ABF@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFE6ED2.7174.1395ABF@localhost>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 12:24:50AM +0100, jiri.wichern@hccnet.nl wrote:

> Short description of the problem: You can't mount hard drive 
> volumes by using their UUID number when also using extra 
> statistics for your block devices by the CONFIG_BLK_STATS 
> kernel option.

Yes, we know.
You use an old version of mount, and the mount will always fail.

Two solutions:
(i) Do not use CONFIG_BLK_STATS.
(ii) Upgrade mount to a recent version (mount is part of util-linux,
recent is for example 2.11y).

Note that solution (ii) gives you a situation where mount and fdisk
fail sporadically instead of always, maybe not precisely what one
had hoped. Thus, (i) is the preferred solution.

It was really bad that CONFIG_BLK_STATS went into 2.4.20,
but you need not use it.

Andries


Two months ago I sent the below Doc patch. It is still needed.


--- Documentation/Configure.help~ Mon Oct 14 01:12:13 2002 
+++ Documentation/Configure.help Tue Oct 22 20:30:39 2002 
@@ -561,6 +561,8 @@ 
  
   This is required for the full functionality of sar(8) and interesting 
   if you want to do performance tuning, by tweaking the elevator, e.g. 
+  On the other hand, it will cause random and mysterious failures for 
+  fdisk, mount and other programs reading /proc/partitions. 
  
   If unsure, say N. 

(this is about CONFIG_BLK_STATS). 
