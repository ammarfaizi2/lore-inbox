Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUDBWjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbUDBWjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:39:31 -0500
Received: from lbo.net1.nerim.net ([62.212.103.219]:32743 "EHLO
	gyver.homeip.net") by vger.kernel.org with ESMTP id S261204AbUDBWjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:39:19 -0500
Message-ID: <406DEB92.2020400@inet6.fr>
Date: Sat, 03 Apr 2004 00:39:14 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Mas <roland.mas@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Drivers *dropped* between releases? (sis5513.c)
References: <87n05uw1zb.fsf@mirexpress.internal.placard.fr.eu.org>
In-Reply-To: <87n05uw1zb.fsf@mirexpress.internal.placard.fr.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Mas wrote the following on 04/02/04 22:37 :

>Hi,
>
>Just got myself a new El Cheapo PC, motherboard is an "ASRock K7S8X".
>IDE chipset is SiS746FX.  Tried installing Debian (latest beta3 of the
>installer, based on kernel 2.4.25) on it, but I couldn't: the IDE
>detection code would load the sis5513 module,
>

Good.

> then sort of hand for
>various amounts of time (during which the loggers complained about
>"hda: lost interrupt" and "hdc: lost interrupt").  Eventually, a
>timeout would be reached, but the hard drive (hda) woud still not be
>usable, and the CD-ROM drive (hdc) wouldn't be usable anymore (after
>having been used as a source for loading the modules).
>
>  
>

Less good.

>  I've looked around a bit, and it seems that sis5513.c has seen a
>change between 2.4.21 and 2.4.22 removing support for the SiS746
>chipset.  Well, removing lines mentionint it, at least, but I'm not
>enough of a guru to see what it should change.
>
>  
>

The driver uses 2 ways of finding SiS Ide chips :
- by northbridge PCI ids, which is what was always used historically 
(and so you had to manually add each known SiS northbridge to a table),
- by probing the controller directly (avoids depending on a lazy coder 
to add entries in a table to make your chip work).

When the last was added, some PCI ids were removed from the table (being 
superfluous).

The very fact that the sis5513.c outputs something in your log means 
that it has found something to handle, so the detection routine 
(whichever it is) works.

I think there's a common problem with SiS chips : interrupt handling. I 
believe it is the source of your problem. I may find time to hack on this.

You could try to remove PCI cards and/or disable VGA IRQ in the bios. On 
one of my SiS-based systems for example adding a PCI card can make it 
unbootable.

Regards,

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 

