Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWDOHza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWDOHza (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 03:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWDOHza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 03:55:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:39849 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750974AbWDOHz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 03:55:29 -0400
X-Authenticated: #2277123
Message-ID: <4440A6EA.7040606@gmx.de>
Date: Sat, 15 Apr 2006 09:55:22 +0200
From: Christian Heimanns <ch.heimanns@gmx.de>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavel@suse.cz
Subject: Re: Suspend to disk
References: <443C0C2D.1020207@gmx.de> <200604112238.07166.rjw@sisk.pl> <443F86EB.8060903@gmx.de> <200604141611.50740.rjw@sisk.pl>
In-Reply-To: <200604141611.50740.rjw@sisk.pl>
X-Enigmail-Version: 0.93.2.0
OpenPGP: id=94079F4C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rafael J. Wysocki wrote:
> On Friday 14 April 2006 13:26, Christian Heimanns wrote:
>> Sorry for the delay, I was on the road...
>>
>> Rafael J. Wysocki wrote:
>>> [update]

> You can try to do something like this: change the runlevel to 3 (eg. init 3),
> the start the X server manually (ie. "X" as root), switch to a text terminal
> and try to suspend.  Then, after resume, see if the X server is still running
> and if not, look into its log.
> 
Thank you Rafael,
I think I've found a solution: Not the kernel or ACPI is guilty, just my
Notebook :-) I changed my acpi scripts a little and now it's working
again. I had to play around with vbetool and 915resolution called in
proper order.
You pointed me to this solution and I already signed off from the
mailing lists. Thanks again,

Christian

My new suspend/resume part:
/sbin/hwclock --systohc
/usr/bin/chvt 1
/usr/local/sbin/vbetool vbestate save > /tmp/vbestate-save
/usr/bin/sync
echo shutdown > /sys/power/disk
echo disk > /sys/power/state
/sbin/hwclock --hctosys
/usr/local/sbin/vbetool vbestate restore < /tmp/vbestate-save
/usr/sbin/915resolution 3c 1400 1050
/usr/bin/chvt 2 #my X vt

The old one was just:
echo shutdown > /sys/power/disk
echo disk > /sys/power/state
/usr/sbin/915resolution 3c 1400 1050

- --
- ---
Christian Heimanns
ch.heimanns<at>gmx<dot>de

### Pinguine können nicht fliegen
- - Pinguine stürzen auch nicht ab! ###
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQKbmABNhR5QHn0wRAm6XAJ9+E9rQRdfYy3h6E+D01puulN85zQCeL+nA
EuHA1Q6ojlv7KRu+/j5XeBU=
=cCwH
-----END PGP SIGNATURE-----
