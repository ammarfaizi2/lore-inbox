Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVGaVfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVGaVfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 17:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVGaVfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 17:35:51 -0400
Received: from sd291.sivit.org ([194.146.225.122]:51722 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261912AbVGaVft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 17:35:49 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Stelian Pop <stelian@popies.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <42EC9410.8080107@roarinelk.homelinux.net>
	 <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 31 Jul 2005 23:35:48 +0200
Message-Id: <1122845748.17880.36.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 31 juillet 2005 à 11:25 -0700, Linus Torvalds a écrit :

>  - The SonyPI driver just allocates IO regions in random areas.

Those are not really random, the list of IO regions available is given
in the ACPI SPIC device specification. The list is hardcoded here
because the driver does not (yet ?) use the ACPI services for
initializing the device, and experience has shown that the list does not
vary with different models.

> and I think the real bug here is the SonyPI driver.
> 
> It should either use an IO port in the legacy motherboard resource area
> (ie allocate itself somewhere in IO ports 0x100-0x3ff),

this cannot be done, because the regions are already defined, and are
not in the legacy area.

>  _or_ it should 
> play well as a PCI device, and actually try to work with the PCI IO port 
> allocation layer.

sure, but the SPIC device is not really tied to a specific PCI device
(it is for the 'type1' models, but not for the 'type2' ones). That's why
the sonypi driver is not a PCI driver but relies on a DMI ident to
detect each and every Vaio laptop out there.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

