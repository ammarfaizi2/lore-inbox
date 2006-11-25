Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967267AbWKYWVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967267AbWKYWVW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 17:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967268AbWKYWVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 17:21:22 -0500
Received: from mailfe05.tele2.fr ([212.247.154.140]:63443 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S967267AbWKYWVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 17:21:20 -0500
X-T2-Posting-ID: J1KNHSW+/rFocqmlXGhaxtmj/1u4l7ZyBcvNTfjRdVU=
X-Cloudmark-Score: 0.000000 []
Date: Sat, 25 Nov 2006 23:21:23 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: tori@unhappy.mine.nu, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sebastien.hinderer@loria.fr
Subject: Re: Tulip dmfe carrier detection
Message-ID: <20061125222123.GA9167@implementation.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	tori@unhappy.mine.nu, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	sebastien.hinderer@loria.fr
References: <20061110144919.GI3411@implementation.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061110144919.GI3411@implementation.labri.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Samuel Thibault, le Fri 10 Nov 2006 15:49:19 +0100, a écrit :
> The dmfe module lacks netif stuff for carrier detection, while the board
> does report carrier status. Here is a patch.

Just an additional fixup: the default state should be carrier off.
This fixes boot carrier detection.

Samuel

--- drivers/net/tulip/dmfe-orig.c	2006-10-01 16:09:49.000000000 +0200
+++ drivers/net/tulip/dmfe.c	2006-11-25 21:23:52.000000000 +0100
@@ -426,6 +426,7 @@
 	dev->poll_controller = &poll_dmfe;
 #endif
 	dev->ethtool_ops = &netdev_ethtool_ops;
+	netif_carrier_off(db->dev);
 	spin_lock_init(&db->lock);
 
 	pci_read_config_dword(pdev, 0x50, &pci_pmr);
