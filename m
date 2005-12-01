Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVLAPee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVLAPee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 10:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVLAPee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 10:34:34 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:29507 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932272AbVLAPed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 10:34:33 -0500
Date: Thu, 01 Dec 2005 10:24:45 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Gene's pcHDTV 3000 analog problem
In-reply-to: <438E7552.5050505@m1k.net>
To: linux-kernel@vger.kernel.org
Cc: Michael Krufky <mkrufky@m1k.net>, Don Koch <aardvark@krl.com>,
       kirk.lapray@gmail.com, video4linux-list@redhat.com, CityK@rogers.com,
       perrye@linuxmail.org
Message-id: <200512011024.45852.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <200512010320.jB13KoH4009443@p-chan.krl.com> <438E7552.5050505@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 November 2005 23:00, Michael Krufky wrote:
>Don Koch wrote:
>>On Wed, 30 Nov 2005 00:29:23 -0500
>>
>>Michael Krufky wrote:
>>>Gene Heskett wrote:
>>>>On Tuesday 29 November 2005 20:26, Michael Krufky wrote:
>>>>
>>>>[...]
>>>>
>>>>>ll I can think of doing next is to have Gene, Don or Perry do a
>>>>>bisection test on our cvs repo.... checking out different cvs
>>>>> revisions until we can narrow it down to the day the problem patch
>>>>> was applied.
>>>>>
>>>>>::sigh::
>>>>
>>>>A sigh?  More like an 'oh fudge' or whatever your fav expletive
>>>> deleted is...
>>>>
>>>>>Who wants to do it?  I'll give you detailed instructions if you're
>>>>>willing.
>>>>
>>>>Can you farm it out, one set of patches to each of us?  Or do you
>>>> want to setup a seperate cvs tree based on the v4l code in
>>>> 2.6.14.3, and incrementally patch it as we each report its still
>>>> ok, until it breaks again?  I think I'd prefer the latter so we are
>>>> all near the same page even if it takes 3x longer to arrive at the
>>>> answer.  How many actual patches in terms of dependency groups are
>>>> there?  I know, I coulda went all week without asking that :(
>>>
>>>Actually, cvs has a parameter that lets you specify cutoff dates...
>>>
>>>This is what I am suggesting that you do... Base this on my previous
>>> cvs instructions....
>>>
>>>reminder: http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS
>>>
>>>so....
>>>
>>>1st:
>>>
>>>cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux login
>>>cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux co v4l-dvb
>>>cd v4l-dvb
>>>make clean
>>>make
>>>make install
>>>
>>>test
>>>
>>>(you already did this - you said doesnt work)
>>
>>[...]
>>
>>>cvs up -D 2005-10-15
>>>make clean
>>>make
>>>make install
>>>
>>>doesnt work?  1 week earlier:
>>>
>>>cvs up -D 2005-10-07
>>>make clean
>>>make
>>>make install
>>
>>Let's put it this way: for me, 2005-10-10 doesn't work and anything
>> earlier doesn't build.  I've tried building against 2.6.15-rc3,
>> 2.6.14 and 2.6.13.  The card doesn't work against the built-in 2.6.13
>> code, but the tuner is sending bizarre stuff to it (channel 2 is
>> *not* at 97.25 MHz).  2.6.14 kept spewing:
>>
>>CORE IOCTL: 0xc054561d
>>cx88[0]: ioctl 0xc054561d (v4l2, rw, VIDIOC_G_TUNER)
>>
>>all over the syslog.
>>
>>Build issues include broken Makefiles (around 10-08) and missing
>> header files.
>>
>>>Cheers,
>>>
>>>Mike
>
>hmm... would those be unresolved symbols in relation to dvb frontends?
>
>This would be because we only recently merged the cvs trees, and the
>older builds dont include the dvb frontends in the v4l build.  You can
>fix it by doing the following:
>
>Be sure to "make clean" before and after each checkout -- it's
> necessary because of what the scripts below do to the build
> configuration.
>
>Before running make (EACH TIME) do this:
>
>1- edit v4l-dvb/v4l/scripts/merge-trees.sh   ... delete everything
>BETWEEN these two lines... being sure to leave both of them intact.:
>
>#!/bin/sh
>
>...
>
>patch -p2 <<'DIFF'
>
>
>
>
>...do the same thing to v4l-dvb/v4l/scripts/unmerge-trees.sh
>
>You will have to do it for each checkout, unfortunately.  If you are
>using a more recent checkout (past few days) then you do not have to
>edit these files, as they have been deleted when the build was updated
>for the merger of v4l+dvb cvs.
>
>
>2) make merge-trees
>
>3) make
>
>4) make install
>
>...because of the "merge-trees" command, you'll have to run "make
> clean" each time before you cvs check out  (cvs co) again.
>
>I hope this works........

Nope, see previous post, I can't get past this for say 2005-11-1:
>[root@coyote scripts]# vim merge-trees.sh
[root@coyote scripts]# vim unmerge-trees.sh
[root@coyote scripts]# cd ..
[root@coyote v4l]# make clean
.version:1: *** missing separator.  Stop.
[root@coyote v4l]# make
.version:1: *** missing separator.  Stop.
[root@coyote v4l]# make merge-trees
.version:1: *** missing separator.  Stop.

So let me go back to 2005-10-1 & try that.  But that ends the cvs up -D
2005-10-1 with:
Merging differences between 1.47 and 1.25 into merge-trees.sh
rcsmerge: warning: conflicts during merge
cvs update: conflicts found in v4l/scripts/merge-trees.sh
C v4l/scripts/merge-trees.sh
P v4l/scripts/prepare-ChangeLog.pl
P v4l/scripts/strip-trailing-whitespaces.sh
RCS file: /cvs/video4linux/v4l-dvb/v4l/scripts/Attic/unmerge-trees.sh,v
retrieving revision 1.44
retrieving revision 1.23
Merging differences between 1.44 and 1.23 into unmerge-trees.sh
rcsmerge: warning: conflicts during merge
cvs update: conflicts found in v4l/scripts/unmerge-trees.sh
C v4l/scripts/unmerge-trees.sh

& that bails out with the message:
[root@coyote v4l-dvb]# cd v4l/scripts
[root@coyote scripts]# vim unmerge-trees.sh
[root@coyote scripts]# vim merge-trees.sh
[root@coyote scripts]# cd ..
[root@coyote v4l]# make merge-trees
make: *** No rule to make target `merge-trees'.  Stop.
[root@coyote v4l]# make clean
rm -f *~ *.o *.ko *.mod.c
rm -f .version .*.o.flags .*.o.d .*.o.cmd .*.ko.cmd
[root@coyote v4l]# make merge-trees
make: *** No rule to make target `merge-trees'.  Stop.
[root@coyote v4l]# make
make -C /lib/modules/2.6.14.3/build SUBDIRS=/usr/src/v4l-dvb/v4l modules
make[1]: Entering directory `/usr/src/linux-2.6.14.3'
make[2]: *** No rule to make target `/usr/src/v4l-dvb/v4l/video-buf.c',
needed by `/usr/src/v4l-dvb/v4l/video-buf.o'.  Stop.
make[1]: *** [_module_/usr/src/v4l-dvb/v4l] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.14.3'
make: *** [default] Error 2

So this doesn't seem to be a productive effort at all, Michael.  Or I'm
doing things out of order as usual & need to start from scratch with a
fresh checkout each time.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

