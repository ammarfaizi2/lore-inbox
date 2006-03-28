Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWC1PHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWC1PHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWC1PHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:07:15 -0500
Received: from web30602.mail.mud.yahoo.com ([68.142.200.125]:37781 "HELO
	web30602.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750809AbWC1PHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:07:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4bkwdz/E40yhnYuOh7e0Af7w6Defo7mp82QuF5Cf6QbhMHx0Wl3ixsVyDsMHru2mQIn6+K3+dNFc9wHHYJfIm6brwoupAuHIYaYGcjGJtuxOnCeBjnhWQNtZotsctXjGdNQTntpHYqr6nqJYJg4zxIcTWrjJZxant5vtO7DMG6M=  ;
Message-ID: <20060328150712.85169.qmail@web30602.mail.mud.yahoo.com>
Date: Tue, 28 Mar 2006 17:07:12 +0200 (CEST)
From: zine el abidine Hamid <zine46@yahoo.fr>
Subject: Re: Detecting I/O error and Halting System
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143478556.4970.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thank you for your analysis.

I don't think that it's a HDD problem nor a cable
problem because the servers are new. We have tried
different HDD (seagate, maxtor) but it has not help
anyway.
It's perhaps a temperature problem but we make a lot
tests in hard condition (high temperature) 
successfuly...    

One thinks that the problem comes from the VIA chipset
VT82c686 (it's also the opinion of Dick Johnson
(linux-os) whom advised me to try UDMA33 instead of
UDMA66).

How can I determine the problem?

I want to add that the HDD seems to be disconnected
(the BIOS can't find any drive for boot) after a
simple reset. We must switch off the servers to get
them work again.
However, it takes a long time (4 mounths and more)
before the HDD fell down. I want to work around by
write a module which will supervise the HDD. I know
how to write a module (I used the lkmpg guide
(http://www.tldp.org/LDP/lkmpg/) but how can I
shutdown Linux from inside a module...? 

best regards.

Zine.


--- Alan Cox <alan@lxorguk.ukuu.org.uk> a écrit :

> On Llu, 2006-03-27 at 16:55 +0200, zine el abidine
> Hamid wrote:
> > hda: status timeout: status=0xd0 { Busy }     
> adapter
> > disque annonce un status busy du DMA
> 
> If I'm reading the translation right then your hard
> disk decided
> it was busy and then never came back
> 
> > Feb 12 04:46:23 porte_de_clignancourt_nds_b
> kernel:
> > ide0: reset: success             
> 
> So the IDE layer tried to reset it
> 
> > Feb 12 10:22:38 porte_de_clignancourt_nds_b
> kernel:
> > hda: timeout waiting for DMA
> 
> Which didnt help
> 
> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> kernel:
> > ide0: reset: success
> 
> Still trying
>       
> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> kernel:
> > hda: irq timeout: status=0xd0 { Busy }            
>    
> > 
> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> kernel:
> > hda: DMA disabled       
> 
> We gave up on DMA to see if PIO would help
> >                               
> >    
> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> kernel:
> > ide0: reset timed-out, status=0x80
> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> kernel:
> > hda: status timeout: status=0x80 { Busy }        
> > nouvel échec de reset
> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> kernel:
> > hda: drive not ready for command
> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> kernel:
> > ide0: reset: success                  
> 
> And reset.. 
> 
> 
> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> kernel:
> > hda: status timeout: status=0x80 { Busy }
> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> kernel:
> > hda: drive not ready for command
> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> kernel:
> > ide0: reset timed-out, status=0x80
> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> kernel:
> > end_request: I/O error, dev 03:02 (hda), sector
> 102263
> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> syslogd:
> > /var/log/maillog: Input/output error
> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> kernel:
> > end_request: I/O error, dev 03:02 (hda), sector
> 110720
> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> kernel:
> > end_request: I/O error, dev 03:02 (hda), sector
> 110728 
> 
> Eventually we give up.
> 
> 
> First thing to check would be the disk and the
> temperature, then the
> cabling. In particular make sure the *long* part of
> the cable is between
> the drive and the controller.
> 
> 




	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
