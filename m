Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWIYL4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWIYL4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWIYL4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:56:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24781 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751489AbWIYL43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:56:29 -0400
Subject: Re: [PATCH] restore libata build on frv
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <5578.1159183668@warthog.cambridge.redhat.com>
References: <1159183568.11049.51.camel@localhost.localdomain>
	 <20060924223925.GU29920@ftp.linux.org.uk>
	 <22314.1159181060@warthog.cambridge.redhat.com>
	 <5578.1159183668@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 13:19:31 +0100
Message-Id: <1159186771.11049.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-25 am 12:27 +0100, ysgrifennodd David Howells:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> These are all legacy ISA settings, and not applicable to FRV:
> 
> 	#define ATA_PRIMARY_CMD		0x1F0
> 	#define ATA_PRIMARY_CTL		0x3F6
> 	#define ATA_PRIMARY_IRQ		14
> 
> 	#define ATA_SECONDARY_CMD	0x170
> 	#define ATA_SECONDARY_CTL	0x376
> 	#define ATA_SECONDARY_IRQ	15

Wrong these are PCI settings. Please read the PCI specifications. In
particular the handling of non-native mode IDE storage class devices on
a PCI bus. For the IRQ mapping of the non-native ports consult your
bridge documentation.

> Note that the ata_pci_init_legacy_port() explicitly states the IRQ numbers as
> 14 and 15 without reference to the macros and so is bad, eg:
> 
> 		probe_ent->irq = 14;

That is indeed a bug

> Make FRV build with libata enabled.  This is done by making the legacy ISA
> interface support conditional on the definition of the legacy ISA port
> settings.  If there's no ISA bus, we shouldn't even attempt to pretend that
> there is.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

Nacked-by: Alan Cox <alan@redhat.com>


