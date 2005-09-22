Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbVIVJku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVIVJku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbVIVJkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:40:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:43223 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030266AbVIVJko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:40:44 -0400
Subject: Re: [RFC/BUG?] ide_cs's removable status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Richard Purdie <rpurdie@rpsys.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
In-Reply-To: <20050921192932.GB13246@flint.arm.linux.org.uk>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
	 <1127327243.18840.34.camel@localhost.localdomain>
	 <20050921192932.GB13246@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 01:10:44 +0100
Message-Id: <1127347845.18840.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-21 at 20:29 +0100, Russell King wrote:
> Last time I checked, with CF cards the media was an inherent part of
> the CF card and is not changable without removing the card, opening
> it, getting out the soldering iron... or alternatively plugging in
> a different CF card.

Last time I checked the spinning platter on my hard disk wasn't
removable without an axe either. What is your point ?

> Of course, PCMCIA will detect removal of the CF card provided the
> PCMCIA hardware is working.  PCMCIA will also detect a CF card which
> has been changed while the system has been suspended _provided_ the
> CIS does not match the previous cards CIS.  It'll even do this if
> you use cardctl suspend/cardctl resume.

Most adapters do not do this. It works solely because we set
drive->removable so we force a new partition scan.

> It sounds like you know of a case where this isn't true - maybe a bug
> report.  Can you expand on it?

With drive->removable = 0 if I insert a card I get partition tables, it
will then not rescan that in future even if the card changed, because
there is no "media change detect" line, unlike on a floppy.

If I pull the CF adapter out it is fine because you get pcmcia level
hotplug but that is not neccessary for card changing on better designed
adapters or when the CF adapter is on the board itself with a CF slot
exposed to the user.

SCSI also treats CF cards as removable for the same reason.


Alan

