Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266701AbUGQLv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266701AbUGQLv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUGQLv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 07:51:57 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:4005 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266701AbUGQLvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 07:51:55 -0400
Date: Sat, 17 Jul 2004 13:45:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: David Gibson <hermes@gibson.dropbear.id.au>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Slowly update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040717134531.A9600@electric-eye.fr.zoreil.com>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <40F57D78.9080609@pobox.com> <20040715010137.GB3697@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040715010137.GB3697@zax>; from hermes@gibson.dropbear.id.au on Thu, Jul 15, 2004 at 11:01:37AM +1000
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <hermes@gibson.dropbear.id.au> :
[...]
> I've started to have a look at the patches.  Unfortunately, they're
> still not really as logically separated as they should be.  Which I

Point taken. Thanks for the review/comment.

> guess means I wasn't sufficiently disciplined putting them into CVS in
> the first place.

Not at all. It is simply due to the fact that
- I started working on the giant diff;
- patch-scripts (TM) is not too bad to rework (insert/split) patches so
  I do not try to make the patches perfect from the start.

If there is a specfic tag in the cvs tree which is supposed to be synced
with the kernel tree at a given time, it could make my life easier though.

> I've started working on my own series of logical patches, starting
> with, as you say the "content free" ones first.  Initial set with
> series file at
>        http://www.ozlabs.org/people/dgibson/orinoco-patches

orinoco-rearrange apart, they look nice.

Minor nit:
--- working-2.6.orig/drivers/net/wireless/orinoco.c
+++ working-2.6/drivers/net/wireless/orinoco.c
@@ -2327,7 +2327,7 @@
        priv = netdev_priv(dev);
        priv->ndev = dev;
        if (sizeof_card)
-               priv->card = (void *)((unsigned long)dev->priv + sizeof(struct orinoco_private));
+               priv->card = (void *)((unsigned long)netdev_priv(dev) + sizeof(struct orinoco_private));

-> I'd simply turn 'dev->priv' into 'priv'.

--
Ueimor
