Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbRCMXll>; Tue, 13 Mar 2001 18:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131349AbRCMXlb>; Tue, 13 Mar 2001 18:41:31 -0500
Received: from gear.torque.net ([204.138.244.1]:1810 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S131341AbRCMXlT>;
	Tue, 13 Mar 2001 18:41:19 -0500
Message-ID: <3AAEB041.9C4AC923@torque.net>
Date: Tue, 13 Mar 2001 18:41:53 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac20
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Balazic wrote:
> > 
> > Nathan Walp (faceprint@faceprint.com) wrote :
> > 
> > > Also, sometime between ac7 and ac18 (spring break kept me from testing
> > > stuff inbetween), i assume during the new aic7xxx driver merge, the
> > > order of detection got changed, and now the ide-scsi virtual host is
> > > host0, and my 29160N is host1. Is this on purpose? It messed up a
> > > bunch of my stuff as far as /dev and such are concerned.
> > 
> > SCSI adapters are enumerated randomly(*) , relying on certain numbering
> > will get you into trouble, sooner or later.
> > There is no commonly accepted solution, AFAIK.
> > The same thing can happent to disk enumeration ( sdb becomes sdc )
> > or partition enumeration ( hda6 becomes hda5 ).
> > 
> > * - theoreticaly no, but practicaly yes ( most of the time )
> 
> SCSI adapters are given host numbers in a random order?  Even with no
> hardware changes?  Does this make less than sense to anyone else?  Every
> kernel EVER up till now has had the real scsi cards (in some particular
> order) then ide-scsi.  Have I just been lucky???

Built in scsi adapter drivers are probed in the order in
which they appear in drivers/scsi/Makefile (in the lk 2.4
series). Adapters can be assigned to host numbers using
the "scsihosts" kernel boot option (but this will not
differentiate between 2 adapters controlled by the same 
driver (e.g. 2 29160 cards)). Scsi buses are scanned for
devices in ascending order.

If you have lots of SCSI devices then devfs is your friend.

Doug Gilbert
