Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275568AbTHMVFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275572AbTHMVFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:05:38 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:49425 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S275568AbTHMVFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:05:34 -0400
Date: Wed, 13 Aug 2003 23:05:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Wilcox <willy@debian.org>, Russell King <rmk@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       rddunlap@osdl.org, davej@redhat.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813210531.GA15148@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Matthew Wilcox <willy@debian.org>,
	Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@redhat.com>, rddunlap@osdl.org,
	davej@redhat.com, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com> <20030813180245.GC3317@kroah.com> <3F3A82C3.5060006@pobox.com> <20030813193855.E20676@flint.arm.linux.org.uk> <3F3A952C.4050708@pobox.com> <20030813195412.GE10015@parcelfarce.linux.theplanet.co.uk> <3F3A9FA1.8000708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3A9FA1.8000708@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 04:29:21PM -0400, Jeff Garzik wrote:
> pci_device_tables are (and must be) at per-driver granularity.  Sure the 
> same card can have multiple drivers, but that doesn't really matter in 
> this context, simply because I/we cannot break that per-driver 
> granularity.  Any solution must maintain per-driver granularity.

So you are still advocating for a KConfig enhancement?

Could you try to describe the layout of a KConfig file that you
have in mind.

I gave it a shot:

It must specify - 
a) Objects file used for the driver
b) module name of the driver
c) optional object files used by that driver
d) data used by the driver, for example PCI Data?
e) other stuff?

driver MAXTOR_SATA "SATA for Maxtor IDE"
	depends on LIB_SATA
	kbuild
	  obj-$(MAXTOR_SATA)  := maxtorsata.o
	  maxtorsata-y := libsata.o smaxtor.o
	  maxtorsata-$(VERBOSE_LOGGING) += maxtorlog.o
	data
	  PCIDEVICE(X,Y)

Not complete - and no dought with some missing pieces.
Primarly to try to find out what you have in mind.

	Sam
