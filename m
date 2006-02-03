Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945911AbWBCTWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945911AbWBCTWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945910AbWBCTWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:22:45 -0500
Received: from mail.gmx.net ([213.165.64.21]:20680 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1945911AbWBCTWo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:22:44 -0500
X-Authenticated: #428038
Date: Fri, 3 Feb 2006 20:22:39 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203192239.GB18533@merlin.emma.line.org>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <43DDFBFF.nail16Z3N3C0M@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch> <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <43E374CF.nail5CAMKAKEV@burner> <43E38084.9040200@cfl.rr.com> <43E38B51.nail5CAZ1GYRE@burner> <Pine.LNX.4.61.0602032005550.19459@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.61.0602032005550.19459@yvahk01.tjqt.qr>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt schrieb am 2006-02-03:

> >
> >> You CAN'T have multiple cdrecord processes burning the same disc at the 
> >> same time; the very idea makes no sense.  The O_EXCL just prevents you 
> >> from trying such foolishness and creating a coaster. 
> >
> >It does not prevent you from creatig a coaster in case you connect e.g.
> >two ATAPI writers to the same ATA cable.
> >
> Apart from transfer speed issues and potential buffer underruns coming 
> along with that, is there anything technically impossible with writing to 
> two ATAPI drives at the same time?

Bus locking while waiting for command completion. If you start a
long-lasting operation on one device, the other device on the same cable
is blocked so you cannot feed the other.

Same holds for SCSI if one of the devices involved doesn't disconnect
from the bus for that long-lasting command.

Try for instance "eject /dev/hdc" while writing to /dev/hdd, or same
stuff with sr0 and sr1. Been there, done that, got a coaster.

-- 
Matthias Andree
