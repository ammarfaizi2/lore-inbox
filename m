Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274509AbRIYMau>; Tue, 25 Sep 2001 08:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274981AbRIYMak>; Tue, 25 Sep 2001 08:30:40 -0400
Received: from ns.exp-math.uni-essen.de ([132.252.150.18]:57360 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S274509AbRIYMaf>; Tue, 25 Sep 2001 08:30:35 -0400
Date: Tue, 25 Sep 2001 14:30:55 +0200 (MESZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: "[A]ndy80" <andy80@ptlug.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Burning a CD image slow down my connection
In-Reply-To: <1001420696.1316.8.camel@piccoli>
Message-Id: <Pine.A32.3.95.1010925142032.20872C-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Sep 2001, [A]ndy80 wrote:

> Hi
> 
> > Hmm, /dev/cdrom would typically be a link. You might try to apply hdparm
> > to where the link points to, but I cannot really believe hdparm doesn't
> > follow links.
> 
> yes it's a link to /dev/scd0 and I CAN mount it, because my IDE cdrom is
> seen as scsi. In lilo.conf I've this line: append="hdd=ide-scsi
> hdc=ide-scsi" (read CD-WRITING HOWTO for more information)

Ok, so you should run hdparm on /dev/hdc in your case (master on second
bus). You can not expect (well, actually, why not?). hdparm to realite
this is no real scsi device and figure out the right ide device to
configure the drive interface accordingly. 

BTW, with regards to your last mesg: I'm well aware you need the ide-scsi
layer and generic scsi devices for ide burners.

However, you can mount /dev/hdc directly for ide cdroms.

So, I was wondering if all (well, most) ide cdroms are atapi and the
kernel cleverly realizes you address a cdrom as /dev/hdc and just uses
those atapi commands and that means, as far as cdroms go, the ide-scsi
part is always embedded in the /dev/hd driver.

OR

if, as I assumed up to now, ide cdroms have a specific CDROM commandset,
maybe just support disk drive style read commands to access the cd data,
such that using ide-scsi and accessing as /dev/scd0 will not always work. 
And if so, ide burners might be special since the are used to be addressed
through an aspi driver anyway. 

Michael.

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.

