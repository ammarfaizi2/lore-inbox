Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTICQrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTICQrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:47:07 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:27281 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264055AbTICQqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:46:11 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <3F5617A9.4040603@pobox.com>
References: <20030902231812.03fae13f.akpm@osdl.org>
	 <20030903161200.GC23729@fs.tum.de>  <3F5617A9.4040603@pobox.com>
Message-Id: <1062607559.1785.50.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 18:46:00 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH] Re: 2.6.0-test4-mm5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As a tangent, gem_pcs_interrupt appears to call netif_carrier_xxx but 
> not set gem->lstate.  David/Ben, is that a bug?

Looks like it is, David, you are the one who knows the PCS stuff ...

BTW. David: Any reason why you wouldn't let me change all occurences
of spin_{lock,unlock}_irq into the ...{save,restore} versions ?

I don't like force re-enabling interrupts the way we do it now with
spin_unlock_irq() the way we do it now. Among other things, that
breaks SA_INTERRUPT semantics and that breaks some pet project of
mine which is to run the IRQ handler with interrupts off when the
kernel stack is below a given threshold (to limit interrupt depth)

Ben.


