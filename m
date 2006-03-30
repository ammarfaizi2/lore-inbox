Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWC3IOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWC3IOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWC3IOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:14:55 -0500
Received: from web30612.mail.mud.yahoo.com ([68.142.201.245]:13756 "HELO
	web30612.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932096AbWC3IOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:14:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GvvYfBmYjN7issKUL6knAVOrxkOkYasOYgbIWl7XSgwSF2sF+cMqwOIkAC8nD3FL48w0MGoxhOlN8Y05rZtk/MCRFB3rIVXb0sWQtrBzOd3TcIvm1xVSuoX3lBrmjiWQ4jTG2VlpRnPui/nJHMg4KWBvIHbQyt9FU9mm6qnnX+k=  ;
Message-ID: <20060330081451.86861.qmail@web30612.mail.mud.yahoo.com>
Date: Thu, 30 Mar 2006 10:14:51 +0200 (CEST)
From: zine el abidine Hamid <zine46@yahoo.fr>
Subject: Re: Detecting I/O error and Halting System
To: gene.heskett@verizononline.net, linux-kernel@vger.kernel.org
In-Reply-To: <200603281255.42705.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I know about smartd, but the HDD are ok.   When the
problem happen's, we have to switch off/on the servers
and then go on without any errors; The servers work's 
after that like nothing happen's...



--- Gene Heskett <gene.heskett@verizon.net> a écrit :

> On Tuesday 28 March 2006 10:07, zine el abidine
> Hamid wrote:
> >First of all, thank you for your analysis.
> >
> >I don't think that it's a HDD problem nor a cable
> >problem because the servers are new. We have tried
> >different HDD (seagate, maxtor) but it has not help
> >anyway.
> >It's perhaps a temperature problem but we make a
> lot
> >tests in hard condition (high temperature)
> >successfuly...
> >
> >One thinks that the problem comes from the VIA
> chipset
> >VT82c686 (it's also the opinion of Dick Johnson
> >(linux-os) whom advised me to try UDMA33 instead of
> >UDMA66).
> >
> >How can I determine the problem?
> >
> >I want to add that the HDD seems to be disconnected
> >(the BIOS can't find any drive for boot) after a
> >simple reset. We must switch off the servers to get
> >them work again.
> >However, it takes a long time (4 mounths and more)
> >before the HDD fell down. I want to work around by
> >write a module which will supervise the HDD. I know
> >how to write a module (I used the lkmpg guide
> >(http://www.tldp.org/LDP/lkmpg/) but how can I
> >shutdown Linux from inside a module...?
> >
> >best regards.
> >
> >Zine.
> 
> I take it that you are aware of a drive monitoring
> utility called 
> smartd?  By querying the drive after a new powerup,
> you may be able to 
> extract usefull information about its health.
> 
> >--- Alan Cox <alan@lxorguk.ukuu.org.uk> a écrit :
> >> On Llu, 2006-03-27 at 16:55 +0200, zine el
> abidine
> >>
> >> Hamid wrote:
> >> > hda: status timeout: status=0xd0 { Busy }
> >>
> >> adapter
> >>
> >> > disque annonce un status busy du DMA
> >>
> >> If I'm reading the translation right then your
> hard
> >> disk decided
> >> it was busy and then never came back
> >>
> >> > Feb 12 04:46:23 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > ide0: reset: success
> >>
> >> So the IDE layer tried to reset it
> >>
> >> > Feb 12 10:22:38 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > hda: timeout waiting for DMA
> >>
> >> Which didnt help
> >>
> >> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > ide0: reset: success
> >>
> >> Still trying
> >>
> >> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > hda: irq timeout: status=0xd0 { Busy }
> >> >
> >> >
> >> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > hda: DMA disabled
> >>
> >> We gave up on DMA to see if PIO would help
> >>
> >> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > ide0: reset timed-out, status=0x80
> >> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > hda: status timeout: status=0x80 { Busy }
> >> > nouvel échec de reset
> >> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > hda: drive not ready for command
> >> > Feb 12 10:24:47 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > ide0: reset: success
> >>
> >> And reset..
> >>
> >> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > hda: status timeout: status=0x80 { Busy }
> >> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > hda: drive not ready for command
> >> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > ide0: reset timed-out, status=0x80
> >> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > end_request: I/O error, dev 03:02 (hda), sector
> >>
> >> 102263
> >>
> >> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> >>
> >> syslogd:
> >> > /var/log/maillog: Input/output error
> >> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > end_request: I/O error, dev 03:02 (hda), sector
> >>
> >> 110720
> >>
> >> > Feb 12 13:45:38 porte_de_clignancourt_nds_b
> >>
> >> kernel:
> >> > end_request: I/O error, dev 03:02 (hda), sector
> >>
> >> 110728
> >>
> >> Eventually we give up.
> >>
> >>
> >> First thing to check would be the disk and the
> >> temperature, then the
> >> cabling. In particular make sure the *long* part
> of
> >> the cable is between
> >> the drive and the controller.
> 
> -- 
> Cheers, Gene
> People having trouble with vz bouncing email to me
> should add the word
> 'online' between the 'verizon', and the dot which
> bypasses vz's
> stupid bounce rules.  I do use spamassassin too. :-)
> Yahoo.com and AOL/TW attorneys please note,
> additions to the above
> message by Gene Heskett are:
> Copyright 2006 by Maurice Eugene Heskett, all rights
> reserved.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
