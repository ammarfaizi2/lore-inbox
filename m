Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285025AbRLZXdc>; Wed, 26 Dec 2001 18:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285031AbRLZXdX>; Wed, 26 Dec 2001 18:33:23 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:24866 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S285025AbRLZXdQ> convert rfc822-to-8bit; Wed, 26 Dec 2001 18:33:16 -0500
Date: Thu, 27 Dec 2001 01:35:27 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Arturas V <arturasv@hotmail.com>
cc: <linux-kernel@vger.kernel.org>, <avaitaitis@bloomberg.net>
Subject: Re: Proliant hangs with 2.4 but works with 2.2. 
In-Reply-To: <F105uevz176RbFGIUUJ0000fff8@hotmail.com>
Message-ID: <20011227011424.P1028-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Dec 2001, Arturas V wrote:

> lafanga lafanga wrote:
> >I have a Compaq Proliant 1600 server which can be hung on demand with >all
> >the 2.4 series kernels I have tried (2.4, 2.4.1 & 2.4.2-pre3). >Kernel
> >2.2.16 runs perfectly (from a default RH7.0).
>
> >I have ensured that the server meets the necessary requirements for >the
> >2.4 kernels (modutils etc) and I have tried kgcc and various gcc versions.
> > >When compiling I have tried default configs and also minimalist configs
> >(with only cpqarray and tlan). I have also ensured that I have the latest
> > >current SmartStart CD (4.9) and have setup the firmware for installing
> >Linux.
>
> I had similar problem with 2.4.5 Kernel. I managed to solve the problem by
> configuring a working verion of kernel with
> NCR53C8XX SCSI support as well as SYM53C8XX. As far as I understood
> SYM53C8xx support covers 53C8xx chips better than NCR53C8xx and that makes
> all the difference. Anyone understands why?

- NCR53C8XX supports all chips except the 53C1010 (33MHz and 66MHz
  PCI) Ultra-160 controllers.

- SYM53C8XX supports chips that implement LOAD/STORE scripts
  instructions. As a result the 53C1010 Ultra-160 controllers are
  supported (+810A,860,875,895,895A,896).

- SYM53C8XX_2 (aka sym-2) supports all chips from earliest 810 rev.1 to
  latest 53C1010-66. Hopefully will replace SYM53C8XX/NCR53C8XX bundle.

(In fact, NCR53C8XX was only useful for 810 and 815 controllers)

For chips that support LOAD/STORE, the SYM53C8XX and SYM53C8XX_2 drivers
care about the chips not mastering themselves over the PCI, as required by
PCI 2.2 specifications.

NCR53C8XX and SYM53C8XX interface with scsi layer using the scsi-obsolete
interface. SYM53C8XX_2 uses the EH interface.

You are encouraged to use SYM53C8XX_2 (aka sym-2, aka SYM53C8XX version
2). The driver is available in latest 2.4 and 2.5 kernels and can also be
used on 2.2 kernel.

  Gérard.

