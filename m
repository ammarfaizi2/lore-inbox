Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbUANWrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUANWrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:47:23 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:14529 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S264899AbUANWqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:46:30 -0500
Date: Thu, 15 Jan 2004 00:46:16 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Something corrupts raid5 disks slightly during reboot
Message-ID: <20040114224616.GW11115822@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net> <20031101082745.GF4640@niksula.cs.hut.fi> <20031101155604.GB530@alpha.home.local> <20031101182518.GL4640@niksula.cs.hut.fi> <20031101190114.GA936@alpha.home.local> <20040102194200.GA11115091@niksula.cs.hut.fi> <20040114144646.GS11115091@niksula.cs.hut.fi> <20040114222214.GA26930@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114222214.GA26930@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 11:22:14PM +0100, you [Willy Tarreau] wrote:
> Hi Ville,
> 
> On Wed, Jan 14, 2004 at 04:46:46PM +0200, Ville Herva wrote:
>  
> >   - I tried booting from 2.6.1 single user mode to 2.6.1 single user
> >     mode (booting with sysrq-b to avoid shutdown process):
> >        ->  The corruption on /dev/hdg happens like with 2.2 and 2.4
> > 
> >   - I booted from 2.6.1 single user mode to 2.6.1 single user
> >     mode with kexec patch to avoid entering BIOS in between
> >        ->  The corruption DOES NOT happen
> > 
> > I'm pretty much out of ideas.
> 
> To me, it proves that the bios triggers the problem. 

Or lilo. Abit BIOS, Adaptec SCSI BIOS, Highpoint HPT370 BIOS and lilo are
the only pieces of code that get executed between power on and the kernel.

Unfortunately, I was unable to rule that (unlikely) alternative out just
yet, because I found out that the box doesn't have a working floppy either
(cdrom is not plugged because of lack of cables - I guess I miswired the
floppy drive too when I last messed with the power cables.) This is also why
I didn't try your DOS disk on the box. It seems its diskedit can recognize
at least scsi disks, so it could well handle the disk on Highpoint
controller, too. Anyway, thanks for that (and reminding me how rusty my
French is - and has always been :). I plan to try booting from floppy
without lilo and the dos editor, when I next open the box and can fix the
floppy wiring. It's a server so I don't take it down all the time...

> It could also be in the device enumeration functions or device
> initialization that it does this thing. Perhaps even a more nasty thing
> such as a pending DMA write which completes during a device reset. 

Something like that crossed my mind initially, but waiting >10min between
the write and boot didn't help, nor did "hdparm -W 0"...

> That's very odd anyway. I don't quite remember well all your setup. 

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=MMYt.4B2.1%40gated-at.bofh.it&rnum=1&prev=/groups%3Fnum%3D50%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26q%3DSomething%2Bcorrupts%2Braid5%2Bdisks%2Bslightly%2Bduring%2Breboot%26sa%3DN%26tab%3Dwg

gives some details. Basicly it's a Abit ST6R mobo (i815 and HPT370 IDEs),
and three Maxtor 250GB disk (root and first data fs), 3 Samsung 80GB's
(second data fs). One of the Samsungs on the HPT370 is the one that exhibits
the corruption.

> Have you tried enabling/disabling shadow ram/caching on bios regions to
> check if a faster/slower code execution in the bios changes something ?

No. I could try that.

> Also do it on additionnal ROMs if you have an onboard bios on your
> secondary controller.

Ok, if only I can manage to find such options from the BIOS.
 
> I'm also getting stuck without any other idea :-/

No wonder. So far you have been most helpful - bug thanks for that.

PS: Again, the next round of results will only be in after some time - as I
said, I'll need to wait for a suitable reboot time for the box... Sorry for
the trickle.


-- v --

v@iki.fi
