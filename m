Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbTCKWUg>; Tue, 11 Mar 2003 17:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbTCKWUg>; Tue, 11 Mar 2003 17:20:36 -0500
Received: from fmr02.intel.com ([192.55.52.25]:64212 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261639AbTCKWUf>; Tue, 11 Mar 2003 17:20:35 -0500
Date: Tue, 11 Mar 2003 14:31:37 -0800 (PST)
From: Scott Feldman <scott.feldman@intel.com>
X-X-Sender: scott.feldman@localhost.localdomain
To: Adam Scislowicz <adams@fourelle.com>
cc: linux-kernel@vger.kernel.org, <adams@fourelle.com>
Subject: Re: [2.4.20] system freezes Intel e1000(included & 4.4.19) &
 bonding(20030207, active-backup mode)
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E01C81525@orsmsx402.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0303111415120.3497-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003, Adam Scislowicz wrote:

> Is anyone else using 2.4.20 bonding in combination w/ the e1000 or
> better yet the Tyan S2723?

It's almost like dev_close was called without dev_open?  Not sure.

Can you try this patch against e1000 in 2.4.20:

--- linux-2.4.20/drivers/net/e1000/e1000_main.c.orig	2003-03-11 13:45:26.000000000 -0800
+++ linux-2.4.20/drivers/net/e1000/e1000_main.c	2003-03-11 14:12:12.000000000 -0800
@@ -977,6 +977,9 @@
 	unsigned long size;
 	int i;
 
+	if(!adapter->tx_ring.buffer_info)
+		return;
+
 	/* Free all the Tx ring sk_buffs */
 
 	for(i = 0; i < adapter->tx_ring.count; i++) {
@@ -1042,6 +1045,9 @@
 	unsigned long size;
 	int i;
 
+	if(!adapter->rx_ring.buffer_info)
+		return;
+
 	/* Free all the Rx ring sk_buffs */
 
 	for(i = 0; i < adapter->rx_ring.count; i++) {

