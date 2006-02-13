Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWBMMBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWBMMBV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWBMMBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:01:21 -0500
Received: from mail.gmx.net ([213.165.64.21]:60049 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932100AbWBMMBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:01:21 -0500
X-Authenticated: #428038
Date: Mon, 13 Feb 2006 13:01:16 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213120116.GA9294@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com> <43ECA8BC.nailJHD157VRM@burner> <43ECADA8.9030609@nortel.com> <43F05FB2.nailKUS3MR1N9@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F05FB2.nailKUS3MR1N9@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-13:

> Well it is obvious that this is a requirement.
> 
> If Linux does device name mapping at high level but leaves the low level part
> unstable, then the following coul happen:
> 
> Just think about a program that checks a file that is on a removable media.
> 
> This media is mounted via a vold service and someone removes the USB cable
> and reinserts it a second later. The filesystem on the device will be mounted
> on the same mount point but the device ID inside the system did change.
> 
> As a result, the file unique identification st_ino/st_dev is not retained 
> and the program is confused.

How does $OS know the storage device wasn't plugged into another system
during that second and changed in that time? This doesn't even seem
far-fetched, just think of USB-capable KVM switches.

Changing st_dev and returning I/O error or stale FS error or whatever is
adequate makes perfect sense. Once the device is unplugged, the mount is
dead. st_dev stability (that is not demanded by POSIX) doesn't help a
iota in making it usable again.

You're barking up the wrong tree anyways. You're holding on to a
non-workable b,t,l approach because it's convenient on BSD and some
other systems, but it cannot be stable. The only stable identifiers I
conceive are brand,model,serial - and this is the way to get rid of the
ugly race between cdrecord -scanbus and cdrecord dev=b,t,l.

Yes, it requires you to change the interface. It doesn't even matter you
need to do that, because hotplug was probably not an issue when libscg
saw the first light on SunOS. Changes in the environment require some
lifeforms to adjust to the new conditions. If they don't change, they'll
die out. This is just natural.

And to make the brand,model,serial approach bullet-proof, the kernel
should detect if this triple is duplicated at some time and refuse to
talk to ANY of these until all but one have been unplugged, just in case
no serial number is provided by a particular device of which two
specimen are plugged.

-- 
Matthias Andree
