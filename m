Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTEBQRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 12:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTEBQRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 12:17:09 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:63950 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262016AbTEBQRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 12:17:06 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Jeff Muizelaar" <muizelaar@rogers.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] NE2000 driver updates
Date: Fri, 2 May 2003 17:29:37 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAKEBKCKAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1051884070.23249.4.camel@dhcp22.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

 >> Are we stuck with Space.c forever? Anyone have any plans for
 >> replacing it with something more driver-model friendly?
 > 
 > Is it worth the effort. Why not just let the old ISA stuff live
 > out its life in peace ? There is certainly no reason we couldn't
 > make it more driver model like by splitting probe and activity
 >
 > i.e. ne2000 probing would do
 >
 >	poke around for ISA device
 >	Found one ?
 >		Alloc ISA device
 >		Fill in ports/range/IRQ
 >		Fill in vendor/product with invented idents
 >		Announce it
 >
 > Then have ne2000 driver model code do the actual setup

Is the vendor ID 015A allocated to anything? If not, we could use
that to indicate ISA devices - it resembles ISA as a number, and
would thus be easier to identify. We could then use the product
number to identify the particular product. For example..

	015A:2000	NE 2000 clone card.
	015A:3509	3COM 3C509

...with other numbers allocated in a similar way. There may be some
duplication as the above allows 65,536 discrete ISA Bus products,
but that shouldn't matter providing we allocate unique product ID's
for each product actually installed on a particular system.

Alternatively, if it's free, we could use 15Ay:xxxx to allow for up
to 1,048,576 products, with ID's like the following...

	15Ay:2000	NE 2000 clone card.
	15Ay:3509	3COM 3C509

...with the 'y' digit used to allow up to 16 different products with
any given product ID, incremented by the kernel as required.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.476 / Virus Database: 273 - Release Date: 24-Apr-2003

