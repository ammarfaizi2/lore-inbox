Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbSKMMd1>; Wed, 13 Nov 2002 07:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267192AbSKMMd1>; Wed, 13 Nov 2002 07:33:27 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:37563 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267178AbSKMMd0>; Wed, 13 Nov 2002 07:33:26 -0500
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Greg KH <greg@kroah.com>, Miles Bader <miles@gnu.org>,
       "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
References: <20021109060342.GA7798@kroah.com>
	<200211091533.gA9FXuW02017@localhost.localdomain>
	<20021113061310.GD2106@kroah.com>
	<buon0odsyh9.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20021113075223.GZ2106@kroah.com>
	<20021113145902.A1245@jurassic.park.msu.ru>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 13 Nov 2002 13:36:14 +0100
Message-ID: <wrpvg31pry9.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20021113145902.A1245@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ivan" == Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

Ivan> It seems that two things are fundamentally missing in generic
Ivan> device model:
Ivan> 1. clean way to detect the type of container structure from arbitrary
Ivan>    struct device *;

Indeed.

I'm using the following stuff in some EISA drivers :

#ifdef CONFIG_EISA
#define DEVICE_EISA(dev) (((dev)->bus == &eisa_bus_type) ? to_eisa_device((dev)) : NULL)
#else
#define DEVICE_EISA(dev) NULL
#endif

and frankly, it's really awful. On drivers which are both EISA and
PCI (3c59x, aic7xxx), this is a major pain.

        M.
-- 
Places change, faces change. Life is so very strange.
