Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUL1XQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUL1XQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUL1XQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:16:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:20383 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261159AbUL1XQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:16:35 -0500
Subject: Re: PATCH: 2.6.10 - Incorrect return from PCI ide controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20041228205553.GA18525@electric-eye.fr.zoreil.com>
References: <1104158258.20952.44.camel@localhost.localdomain>
	 <20041228205553.GA18525@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104271949.26109.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 22:12:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-12-28 at 20:55, Francois Romieu wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> :
> > This fixes the IT8172 driver. There are other drivers with this bug (eg
> > generic) but the -ac IDE is sufficiently diverged from base that someone
> > else needs to generate/test the more divergent cases.
> 
> ide_setup_pci_device{s} will always claim that everything is fine even
> though do_ide_setup_pci_device() has some opportunity to fail.
> 
> Should it matter as well ?

Probably. It's less pressing because the bad cases are those where
->init_one() errors with a positive return and we steal the device. The
nasty one only showed up in -ac because it has a generic driver that can
be told to capture all other IDE devices that are unknown, and it ran
off with all the SATA devices until the bug was fixed 8)


