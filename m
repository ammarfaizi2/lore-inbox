Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWFIPzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWFIPzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWFIPzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:55:54 -0400
Received: from web26907.mail.ukl.yahoo.com ([217.146.176.96]:31323 "HELO
	web26907.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030248AbWFIPzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:55:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Qo1IH4GXlyzMsuowgzoh0aVAZyRYtEt+SueoCbqHBOfVCkHItGOxGVw0IMOsptvAXpJ/9XDb5H0sS6hKgPnx8p7tb2CCYNlp5bfL2IzLA7loI2AwZFrBSclFDqlW0IYPDSxftPjXENHkUId3Gtnts+qha8UaPWacebgMB4AvFXI=  ;
Message-ID: <20060609155550.69188.qmail@web26907.mail.ukl.yahoo.com>
Date: Fri, 9 Jun 2006 17:55:50 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: RE : Re: [RFC] ATA host-protected area (HPA) device mapper?
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <44898A52.2010008@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jeff Garzik wrote:
> >   Your hard disk is a lot more powerfull than what you think, only very old
> 
> No, it's not.  I am well aware of what's in the ATA spec.
>
> >  hard disks only have ATA set max command. Nowadays, you can not only set the
> 
> Not true.

  If you want more info without reading the spec, here is some more:
http://www.heise.de/ct/english/05/08/172/

> >  Gujin also do the absolutely needed setup of the IDE hard disk which is to freeze
> >  the password system _and_ the config system of all the IDE hard disks present, so
> >  that no virus can put a random password and send you an E-mail with the address
> >  where to send the money to get the password to unlock the hard disk and so access
> >  again your data. Again, freezing means no more modifiable until next power cycle,
> >  so IMO it is the job of the bootloader to setup the hard disk, before running
> >  anything like Linux, a commercial OS, a bootable CDROM...
> 
> This is totally broken, and I am going to strongly recommend that no one 
> use this software.

  But that is the recommended way to do in the ATA specification, since ATA4:

http://www.t13.org/project/d1153r18-ATA-ATAPI-4.pdf
and read "6.10 Security Mode feature set" around page 30 / page 46.
Pay attentiong to the last sentense of "6.10.4 Frozen mode".

  And some BIOS correctly implement it - most BIOS don't.

> It is the OS responsibility to do this.  As a simple example, when the 
> libata ACPI patches are merged (soon), libata will send BIOS-specified 
> taskfiles to the device -- including the hard drive password, if any. 
> Then it will freeze the settings.

  Which setting are you talking about: freezing the HPA, the configuration
 or the password - that is different ATA commands.
 Gujin can run a kernel (or some other software) without freezing each of
 them independantly but the user has to explicitely request it - and should
 not try to boot a random CDROM with the password unfrozen.

> Gujin's behavior will prevent the user from accessing their data, if 
> they have protected it via BIOS.

  Some BIOS have support for password, but Gujin is not using BIOS
 services for "protection" because BIOS is not providing such services
 with a documented interface.

> >  Gujin is assuming that your hard disk are accessible by the documented ATA ide
> >  system, and some (or all?) IDE SATA interface have (volumtary?) broken
> >  implementation: they are not IDE register compatible.
> 
> More evidence that Gujin is completely broken.
> 
> Host controller programming interfaces have _always_ been variable.  PCI 
> IDE standard was never a requirement for all host controllers, indeed 
> such a requirement would be stupid, and widely ignored.
> 
> Modern SATA controllers are all FIS-based, and are not (and should not 
> be) limited by the legacy IDE register programming interface.

  The complete ATA specification is describing a register interface since ATA1,
 SATA chipsets should be software compatible, even if they add commands/interfaces:
http://www.sata-io.org/interopfaq.asp    say:
    Are there any known interoperability issues with SATA?
    One of the primary requirements of the SATA 1.0 specification was to
    maintain backward compatibility with existing operating system drivers
    to eliminate incompatibility issues.


  Etienne.


__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection possible contre les messages non sollicités 
http://mail.yahoo.fr Yahoo! Mail 
