Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSGNMA3>; Sun, 14 Jul 2002 08:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSGNMA2>; Sun, 14 Jul 2002 08:00:28 -0400
Received: from AMarseille-201-1-1-60.abo.wanadoo.fr ([193.252.38.60]:2928 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S316047AbSGNMA1>;
	Sun, 14 Jul 2002 08:00:27 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>, <alan@lxorguk.ukuu.org.uk>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Removal of pci_find_* in 2.5
Date: Sat, 13 Jul 2002 15:45:53 +0200
Message-Id: <20020713134553.4483@192.168.4.1>
In-Reply-To: <20020713.135235.83621938.davem@redhat.com>
References: <20020713.135235.83621938.davem@redhat.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In particular things like "if on PCI host controller DEV/ID, enable hw
>bug workaround foo".  I'm going to need to do crap like this even in
>the TG3 driver, it has to be worked around in the TG3 driver code
>itself so this isn't a PCI black-list type thing where we swizzle bits
>in the PCI host controller registers.

That case shouldn't be a problem, since when your device get discovered,
hopefully, the host controller is already there. Though in some cases,
host controllers just appear as a sibling device, and in this specific
case, it may be not have been "discovered" yet.

There can be other bad dependencies between "sibling" devices (especially
functions of the same physical devices), which is why I would make sure
that all devices on a given level have been probed (that is their
pci_dev structure created) before the various drivers get notified.

Ben.


