Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVLARCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVLARCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVLARB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:01:59 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:22416 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932334AbVLARB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:01:59 -0500
Date: Thu, 01 Dec 2005 12:01:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Gene's pcHDTV 3000 analog problem
In-reply-to: <438F1975.2090001@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: Perry Gilfillan <perrye@linuxmail.org>, Michael Krufky <mkrufky@m1k.net>,
       Don Koch <aardvark@krl.com>, kirk.lapray@gmail.com,
       video4linux-list@redhat.com, CityK@rogers.com
Message-id: <200512011201.30996.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <200512010959.05865.gene.heskett@verizon.net> <438F1975.2090001@linuxmail.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 10:40, Perry Gilfillan wrote:
>Gene Heskett wrote:
>>On Wednesday 30 November 2005 23:00, Michael Krufky wrote:

[...]
>
>I've been able to pin point the time of the fault to changes commited
> to v4l cvs at "2005-10-17 16:02."
>
>In summary:
>
>cvs as of 2005-10-17 16:01:
>Analog TV works, as well as composite and s-video.
>
>Changes made at 2005-10-17 16:02: bROKEN!!
>
>cvs as of 2005-10-17 16:10:
>Analog failes, s-video and composite work.
>
>
>To test this, fron v4l-dvb/ ( not v4l-dvb/v4l/ ):
>
>cvs up -D "2005-10-17 16:02"
>make distclean
>make
>make install
>
>Do a cold boot, and test.
>
>cvs up -D "2005-10-17 16:01"
>make distclean
>make
>make install
>
>Do a cold boot and test.
>
>Cheers,
>
>Perry

Unforch, it appears that Makefile is broken as its expecting to find a
link named linux in the /usr/src dir that points at the present kernels
tree.  Per Linus's instructions that link was removed what, 2 years ago?

Anywho, its exiting rather quickly with this message:

[root@coyote v4l-dvb]# make distclean
make -C /usr/src/v4l-dvb/v4l distclean
make[1]: Entering directory `/usr/src/v4l-dvb/v4l'
find . -name '*.c' -type l -exec rm '{}' \;
find . -name '*.h' -type l -exec rm '{}' \;
rm -f *~ *.o *.ko *.mod.c
rm -f .version .*.o.flags .*.o.d .*.o.cmd .*.ko.cmd
rm -rf .tmp_versions
make[1]: Leaving directory `/usr/src/v4l-dvb/v4l'

Which looks ok, so...

[root@coyote v4l-dvb]# make
make -C /usr/src/v4l-dvb/v4l
make[1]: Entering directory `/usr/src/v4l-dvb/v4l'
echo "No version yet."
No version yet.
uname -r|perl -ne 'if (/^([0-9]*)\.([0-9])*\.([0-9]*)(.*)$/) { printf
("VERSION=%s\nPATCHLEVEL:=%s\nSUBLEVEL:=%s\nKERNELRELEASE:=%s.%s.%s%s\n"
,$1,$2,$3,$1,$2,$3,$4); };' > ./.version
make[1]: Leaving directory `/usr/src/v4l-dvb/v4l'
make[1]: Entering directory `/usr/src/v4l-dvb/v4l'
creating symbolic links...
find: ../linux/drivers/usb/media: No such file or directory
make[1]: *** [links] Error 1
make[1]: Leaving directory `/usr/src/v4l-dvb/v4l'
make: *** [all] Error 2

The ./v4l/.version file:
VERSION=2
PATCHLEVEL:=6
SUBLEVEL:=14
KERNELRELEASE:=2.6.14.3

which appears correct to me.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

