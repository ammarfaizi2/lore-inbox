Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263863AbUDPV7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbUDPV6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:58:32 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:17824 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263863AbUDPVyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:54:37 -0400
Date: Fri, 16 Apr 2004 22:53:19 +0100
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: baycom_par dereference before check.
Message-ID: <20040416215319.GW20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040416212004.GO20937@redhat.com> <20040416212541.GH24997@parcelfarce.linux.theplanet.co.uk> <20040416212738.GQ20937@redhat.com> <408054C9.5070202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408054C9.5070202@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 05:48:57PM -0400, Jeff Garzik wrote:

 > >Good point. Still doesn't strike me as particularly nice though.
 > I would rather just remove the checks completely.  The success of any of 
 > those checks is a BUG() condition that should never occur.

That works for me too. How about this?

		Dave

--- linux-2.6.5/drivers/net/hamradio/baycom_par.c~	2004-04-16 22:52:35.000000000 +0100
+++ linux-2.6.5/drivers/net/hamradio/baycom_par.c	2004-04-16 22:52:53.000000000 +0100
@@ -274,8 +274,8 @@
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct baycom_state *bc = netdev_priv(dev);
 
-	if (!dev || !bc || bc->hdrv.magic != HDLCDRV_MAGIC)
-		return;
+	BUG_ON(!bc);
+	BUG_ON(bc->hdrv.magic != HDLCDRV_MAGIC);
 
 	baycom_int_freq(bc);
 	/*
