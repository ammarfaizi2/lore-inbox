Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWBKDkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWBKDkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 22:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWBKDkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 22:40:14 -0500
Received: from smtp.enter.net ([216.193.128.24]:60175 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932177AbWBKDkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 22:40:12 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: dtor_core@ameritech.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Thu, 9 Feb 2006 22:36:26 -0500
User-Agent: KMail/1.8.1
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, peter.read@gmail.com,
       mj@ucw.cz, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <43EC8F22.nailISDL17DJF@burner> <d120d5000602100525w752b6df8t6c72a9a4164bdbcf@mail.gmail.com>
In-Reply-To: <d120d5000602100525w752b6df8t6c72a9a4164bdbcf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602092236.27379.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 08:25, Dmitry Torokhov wrote:
> On 2/10/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > "D. Hazelton" <dhazelton@enter.net> wrote:
> > > And does cdrecord even need libscg anymore? From having actually gone
> > > through your code, Joerg, I can tell you that it does serve a larger
> > > purpose. But at this point I have to ask - besides cdrecord and a few
> > > other _COMPACT_ _DISC_ writing programs, does _ANYONE_ use libscg? Is
> > > it ever used to access any other devices that are either SCSI or use a
> > > SCSI command protocol (like ATAPI)?  My point there is that you have a
> > > wonderful library, but despite your wishes, there is no proof that it
> > > is ever used for anything except writing/ripping CD's.
> >
> > Name a single program (not using libscg) that implements user space SCSI
> > and runs on as many platforms as cdrecord/libscg does.
>
> Joerg,
>
> Please name a single program/package besides cdrtools that is using
> libscg. Face it, you created and maintained a very decent CD writing
> program but world domination is a bit out of reach.

Exactly.

He has done exactly that, but since then the world has moved on and he refuses 
to see the truth.

Joerg - Lieber gott in himmel! You probably missed 90% of my argument anyway. 
So here it is encapsulated:

Userspace does not define kernel semantics or facilities. Standards do that, 
and where standards are lacking, the kernel has to provide what it can.

Now before you go off and start screaming about the SCSI spec, be aware that I 
_HAVE_ _READ_ _THEM_ and nowhere do I see it stated that the kernel has to 
export the SCSI transport layers internal numbering to userspace. All I have 
seen is that the SCSI system uses a "Host/Bus/Target/Lun" identification 
system internally. As someone else pointed out, /dev/sr* can be used for 
writing CD's with the SG_IO system since the same transport code sits under 
said device as all other block devices. This means that if a program wants to 
write to the device identified by /dev/sr0 or /dev/hda the kernel knows which 
HOST/BUS/TARGET/LUN is meant by it. No need to artificially provide those 
identifiers.

As someone else also pointed out, your code doesn't map devices in a sane 
manner. BTL mapping can change with hotplug, and all your arguments about 
st_dev are bullshit. From reading the spec you pointed at it seems that 
st_dev points to the _underlying_ _device_ - which will be stable despite 
everything.

Understood?

And before I go, let me reiterate a true statement someone else said:
libscg is not the problem - it is the backend. If you _need_ said BTL 
mappings, why can't cdrecord take the provide /dev/hd* or /dev/sr* and 
translate it internally into the BTL mapping you need?

DRH
