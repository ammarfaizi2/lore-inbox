Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130455AbQKVDvi>; Tue, 21 Nov 2000 22:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130892AbQKVDv3>; Tue, 21 Nov 2000 22:51:29 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:44560 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S130455AbQKVDvQ>; Tue, 21 Nov 2000 22:51:16 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDD6B@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, maillist@chello.nl
Cc: linux-kernel@vger.kernel.org
Subject: RE: 53c400 driver
Date: Tue, 21 Nov 2000 15:51:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JE's UHCI driver (drivers/usb/uhci.[hc]) uses
nested_lock() and nested_unlock() for this.
Maybe it could help.

~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Tuesday, November 21, 2000 3:48 PM
> To: maillist@chello.nl
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 53c400 driver
> 
> 
> > 53c400a non-PNP still lock this system hard. It starts 
> barking about a
> > busy SCSI bus, and then I can fsck again.
> > 
> > To Alan : How hard is it to get thing beast (53c400 and 
> family) to be SMP
> > safe ?? Or is it better to start over again ?
> 
> The problem is that the code takes spinlocks recursively. The original
> code (see 2.0's 5380 generic C code) uses cli/sti. It was converted to
> use spin_lock() but not allowing for the recursive locking 
> cases. I tried
> to untangle the code paths but they are so ugly and some of 
> the code is
> sufficiently messy and unmaintained (for about 6 years) that I gave up
> trying to decode it.
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
