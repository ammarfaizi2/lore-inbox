Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTILOZX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 10:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTILOZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 10:25:23 -0400
Received: from vlugnet.org ([217.160.107.28]:62119 "EHLO vlugnet.org")
	by vger.kernel.org with ESMTP id S261651AbTILOZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:25:18 -0400
From: Ronny Buchmann <ronny-lkml@vlugnet.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [OOPS] 2.4.22 / HPT372N
Date: Fri, 12 Sep 2003 16:24:41 +0200
User-Agent: KMail/1.5.3
Cc: Marko Kreen <marko@l-t.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200309091406.56334.ronny-lkml@vlugnet.org> <1063363684.5409.8.camel@dhcp23.swansea.linux.org.uk> <200309121458.25327.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200309121458.25327.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309121624.41989.ronny-lkml@vlugnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag 12 September 2003 14:58 schrieb Bartlomiej Zolnierkiewicz:
> On Friday 12 of September 2003 12:48, Alan Cox wrote:
> > On Gwe, 2003-09-12 at 10:41, Ronny Buchmann wrote:
> > > -	d->channels = 1;
> > > +	d->channels = 2;
> >
> > Need to work out which 372N and others are dual channel but yes
>
> No, "d->channels = 1" is only executed for orginal HPT366 which has
> separate PCI configurations for first and second channel.  For HPT372N you
> have correct value in hpt366.h - ".channels = 2".
so it should be something like this?

switch(class_rev) {
	case 5:
 	case 4:
  	case 3: ide_setup_pci_device(dev, d);
		return;
	case 1: d->channels = 1;
	default:        break;
}

-- 
ronny


