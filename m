Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318289AbSHUOCL>; Wed, 21 Aug 2002 10:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318293AbSHUOCL>; Wed, 21 Aug 2002 10:02:11 -0400
Received: from codepoet.org ([166.70.99.138]:28375 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318289AbSHUOCK>;
	Wed, 21 Aug 2002 10:02:10 -0400
Date: Wed, 21 Aug 2002 08:06:15 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.20-pre[234] hosed /proc/partitions fix
Message-ID: <20020821140615.GA20137@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020821022732.GA11503@codepoet.org> <20020821030430.GA11994@codepoet.org> <1029937506.26411.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029937506.26411.29.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 21, 2002 at 02:45:06PM +0100, Alan Cox wrote:
> On Wed, 2002-08-21 at 04:04, Erik Andersen wrote:
> > On Tue Aug 20, 2002 at 08:27:32PM -0600, Erik wrote:
> > > Try compiling CONFIG_BLK_DEV_LVM into 2.4.20-pre4 and then run
> > > 'cat /proc/partitions' for some amusement. I really like the way
> > 
> > It also seems to occur for md and ataraid.
> 
> Fixed in -ac for a while - not had time to do another sync with Marcelo
> though

Sigh.  I wished I'd known an hour ago, since it would have
saved me the bother of figuring it out myself.

Marcello,
Please apply the following patch to 2.4.20-pre5.  The
patch that went into -pre2 had a nasty bug in it that
causes /proc/partitions to behave very badly.  This
patch restores it to sanity.

 
--- drivers/block/genhd.c.orig	Wed Aug 21 07:51:21 2002
+++ drivers/block/genhd.c	Wed Aug 21 08:03:48 2002
@@ -194,9 +194,7 @@
 
 	/* show the full disk and all non-0 size partitions of it */
 	for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
-		int mask = (1<<gp->minor_shift) - 1;
-
-		if (!(n & mask) || gp->part[n].nr_sects) {
+		if (gp->part[n].nr_sects) {
 #ifdef CONFIG_BLK_STATS
 			struct hd_struct *hd = &gp->part[n];
 

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
