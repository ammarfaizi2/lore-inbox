Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132651AbRDBJ31>; Mon, 2 Apr 2001 05:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132652AbRDBJ3R>; Mon, 2 Apr 2001 05:29:17 -0400
Received: from zeus.kernel.org ([209.10.41.242]:45013 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132651AbRDBJ3D>;
	Mon, 2 Apr 2001 05:29:03 -0400
Date: Mon, 2 Apr 2001 13:25:08 +0400
From: Oleg Drokin <green@ixcelerator.com>
To: kuznet@ms2.inr.ac.ru
Cc: Oleg Drokin <green@dredd.crimea.edu>, linux-kernel@vger.kernel.org,
   davem@redhat.com, david-b@pacbell.net
Subject: Re: IP layer bug?
Message-ID: <20010402132508.A13238@iXcelerator.com>
In-Reply-To: <20010331190314.A27130@dredd.crimea.edu> <200103311532.TAA20809@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200103311532.TAA20809@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sat, Mar 31, 2001 at 07:32:48PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Mar 31, 2001 at 07:32:48PM +0400, kuznet@ms2.inr.ac.ru wrote:

> General rule is minimization redundant clearings of the area.
> > Why not document it somewhere, so that others will not fall into the same trap?
> Indeed. 8) You got the experience, which you expect to be useful
> for people, it is time to prepare some note recording this. 8)
I cannot think of something better that piece below, so I think
you may want to change it, anyway ;)


--- include/linux/skbuff.h.orig	Mon Apr  2 13:13:46 2001
+++ include/linux/skbuff.h	Mon Apr  2 13:24:18 2001
@@ -102,7 +102,10 @@
 	 * This is the control buffer. It is free to use for every
 	 * layer. Please put your private variables there. If you
 	 * want to keep them across layers you have to do a skb_clone()
-	 * first. This is owned by whoever has the skb queued ATM.
+	 * first (which is a must, anyway). This is owned by whoever
+	 * has the skb queued ATM. 
+	 * Driver writers: notice you should zero cb before netif_rx()
+	 * if you used it.
 	 */ 
 	char		cb[48];	 
 

Bye,
    Oleg
