Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288485AbSBDFII>; Mon, 4 Feb 2002 00:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288484AbSBDFH6>; Mon, 4 Feb 2002 00:07:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4878 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288477AbSBDFHu>; Mon, 4 Feb 2002 00:07:50 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Asynchronous CDROM Events in Userland
Date: 3 Feb 2002 21:07:24 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3l4uc$laf$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu>
By author:    "Calin A. Culianu" <calin@ajvar.org>
In newsgroup: linux.dev.kernel
>
> 
> Is there any way, other than by polling, to have a user process be
> notified of a change in status on a cdrom drive?  (Such as if the drive
> opens, closes, gets new media, etc)?
> 
> Also, come think of it, other types of asynchronous events would be nice
> too, like when a cdrom usb device gets hot-plugged into the system, etc.
> 
> The current ioctls are inadequate for this type of thing (they are
> synchronous in nature). One nice thing would be if we can register SIGUSR
> or other types of signals with the cdrom driver(s) so that it can notify a
> user process of (cdrom) events it may be interested in.
> 
> The reason I ask this is that the current autorun program that comes with
> kde is very inefficient because it polls the cdrom drives.  Also, this
> program is completely unable to determine that a usb device has come
> online, because it basically can't differentiate between bogus /etc/fstab
> entries and offline usb devices.
> 
> At any rate, if anyone can suggest a way to asynchronously receive cdrom
> events in userland, it would be appreciated.
> 
> If not what do you guys think about extensions to the cdrom drivers to
> handle these types of things?
> 

Rather than a signal, it should be a file descriptor of some sort, so
one can select() etc on it.  Personally I can't imagine polling would
take any appreciable amount of resources, though.

A more important issue is probably to get notification when the eject
button is pushed and the device is locked, so that it can try to
umount and eject it, unless busy.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
