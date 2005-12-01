Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVLAPlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVLAPlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 10:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVLAPlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 10:41:02 -0500
Received: from wsip-68-15-117-99.ok.ok.cox.net ([68.15.117.99]:29837 "EHLO
	mail.gilfillan.org") by vger.kernel.org with ESMTP id S932284AbVLAPkr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 10:40:47 -0500
Message-ID: <438F1975.2090001@linuxmail.org>
Date: Thu, 01 Dec 2005 09:40:37 -0600
From: Perry Gilfillan <perrye@linuxmail.org>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Michael Krufky <mkrufky@m1k.net>,
       Don Koch <aardvark@krl.com>, kirk.lapray@gmail.com,
       video4linux-list@redhat.com, CityK@rogers.com
Subject: Re: Gene's pcHDTV 3000 analog problem
References: <200511282205.jASM5YUI018061@p-chan.krl.com> <200512010320.jB13KoH4009443@p-chan.krl.com> <438E7552.5050505@m1k.net> <200512010959.05865.gene.heskett@verizon.net>
In-Reply-To: <200512010959.05865.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Wednesday 30 November 2005 23:00, Michael Krufky wrote:
>cvs up -D 2005-10-15
>was done inside the checkouts v4l-dvb dir
>make (in the v4l subdir) clean, ok
>make then blows up with:
>root@coyote v4l]# make
>make -C /lib/modules/2.6.14.3/build SUBDIRS=/usr/src/v4l-dvb/v4l modules
>make[1]: Entering directory `/usr/src/linux-2.6.14.3'
>make[2]: *** No rule to make target `/usr/src/v4l-dvb/v4l/video-buf.c',
>needed by `/usr/src/v4l-dvb/v4l/video-buf.o'.  Stop.
>make[1]: *** [_module_/usr/src/v4l-dvb/v4l] Error 2
>make[1]: Leaving directory `/usr/src/linux-2.6.14.3'
>make: *** [default] Error 2
>
>So what I figured to be a good starting point isn't.
>  
>So I stepped back to the parent v4l-dvb dir, and did a 
>cvs up -D 2005-11-1, which updated a whole bunch of stuff, and then I
>get this:
>[root@coyote v4l-dvb]# cd v4l
>[root@coyote v4l]# make clean
>.version:1: *** missing separator.  Stop.
>[root@coyote v4l]# make
>.version:1: *** missing separator.  Stop.
>
>So it looks as if I don't know what I'm doing (and I obviously don't)
>Where am I losing it here?
>
>  
>
I've been able to pin point the time of the fault to changes commited to 
v4l cvs at "2005-10-17 16:02."

In summary:

cvs as of 2005-10-17 16:01:
Analog TV works, as well as composite and s-video.

Changes made at 2005-10-17 16:02: bROKEN!!

cvs as of 2005-10-17 16:10:
Analog failes, s-video and composite work.


To test this, fron v4l-dvb/ ( not v4l-dvb/v4l/ ):

cvs up -D "2005-10-17 16:02"
make distclean
make
make install

Do a cold boot, and test.

cvs up -D "2005-10-17 16:01"
make distclean
make
make install

Do a cold boot and test.

Cheers,

Perry
