Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSJVSeb>; Tue, 22 Oct 2002 14:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264861AbSJVSeb>; Tue, 22 Oct 2002 14:34:31 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:16125 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S264863AbSJVSe3>;
	Tue, 22 Oct 2002 14:34:29 -0400
Date: Tue, 22 Oct 2002 20:40:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, marcelo@conectiva.com.br
Subject: Re: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021022184034.GA26585@win.tue.nl>
References: <20021022161957.N26402@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021022161957.N26402@fi.muni.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 04:19:57PM +0200, Jan Kasprzak wrote:

> 	I.e. if you read the /proc/partitions in single read() call,
> it gets read OK. However, if you read() with smaller-sized blocks,
> you get the truncated contents.

Having statistics in /proc/partitions leads to such problems.
Make sure you do not ask for them.

--- Documentation/Configure.help~       Mon Oct 14 01:12:13 2002
+++ Documentation/Configure.help        Tue Oct 22 20:30:39 2002
@@ -561,6 +561,8 @@
 
   This is required for the full functionality of sar(8) and interesting
   if you want to do performance tuning, by tweaking the elevator, e.g.
+  On the other hand, it will cause random and mysterious failures for
+  fdisk, mount and other programs reading /proc/partitions.
 
   If unsure, say N.


(this is about CONFIG_BLK_STATS).

Andries


[I still do not understand how hch can want to add this cruft to
/proc/partitions, and how marcelo can accept it.
If some vendor made this mistake, why force it on the rest of
the world? It is bad for RedHat users, and worse for all others.]
