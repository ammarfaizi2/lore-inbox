Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272001AbTHMWZR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 18:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272000AbTHMWZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 18:25:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:24850 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S272001AbTHMWZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 18:25:12 -0400
Date: Thu, 14 Aug 2003 00:24:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <willy@debian.org>,
       Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@redhat.com>, <rddunlap@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>,
       <kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: C99 Initialisers
In-Reply-To: <20030813210531.GA15148@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0308140018170.24676-100000@serv>
References: <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com>
 <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com>
 <20030813180245.GC3317@kroah.com> <3F3A82C3.5060006@pobox.com>
 <20030813193855.E20676@flint.arm.linux.org.uk> <3F3A952C.4050708@pobox.com>
 <20030813195412.GE10015@parcelfarce.linux.theplanet.co.uk> <3F3A9FA1.8000708@pobox.com>
 <20030813210531.GA15148@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 13 Aug 2003, Sam Ravnborg wrote:

> driver MAXTOR_SATA "SATA for Maxtor IDE"
> 	depends on LIB_SATA
> 	kbuild
> 	  obj-$(MAXTOR_SATA)  := maxtorsata.o
> 	  maxtorsata-y := libsata.o smaxtor.o
> 	  maxtorsata-$(VERBOSE_LOGGING) += maxtorlog.o
> 	data
> 	  PCIDEVICE(X,Y)

Something I really want to avoid is Makefile specific syntax in Kconfig.
IMO it should somehow like this:

module maxtorsata MAXTOR_SATA
	{tristate|prompt} "SATA for Maxtor IDE"
	depends on LIB_SATA
	source smaxtor.c
	source maxtorlog.c if MAXTOR_VERBOSE
	...

bye, Roman

