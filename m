Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVK2EXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVK2EXa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 23:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVK2EXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 23:23:30 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:37543 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750767AbVK2EX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 23:23:29 -0500
Date: Mon, 28 Nov 2005 23:23:26 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: cx88 totally fried in 2.6.15-rcX -was- Re: HD3000 - no NTSC via
 tuner
In-reply-to: <438BCCF9.1000606@m1k.net>
To: linux-kernel@vger.kernel.org
Cc: Michael Krufky <mkrufky@m1k.net>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Don Koch <aardvark@krl.com>, Perry Gilfillan <perrye@linuxmail.org>
Message-id: <200511282323.26723.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <200511282125.52997.gene.heskett@verizon.net> <438BCCF9.1000606@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 November 2005 22:37, Michael Krufky wrote:
>Gene Heskett wrote:
>>On Monday 28 November 2005 20:17, Michael Krufky wrote:
>>>Gene Heskett wrote:
>>>>Well, based on the note about -rc2-git6 having the v4l stuff
>>>> reverted, I just built it.  Same song, same verse.  The tuner acts
>>>> as if the antenna has been disconnected and held a fraction of an
>>>> inch away. The video is all digital noise (in VSB), and the audio
>>>> has a fraction of a word now and then, buried in white noise.  As
>>>> my dish receiver has about a 65,000 u-volt output, I find that sort
>>>> of signal loss almost unbelievable.
>>>>
>>>>It still takes a cold reboot back to 2.6.14.3 or I think any earlier
>>>>kernel (that worked ok) in order to restore the cards normal
>>>>operation, I'm watching cnn on it right now after having done so.
>>>>
>>>>So to me, there is little difference between git3 and git6.  Neither
>>>>works, failing in the same manner exactly, and matching the
>>>>performance of 15-rc2 as issued.  I didn't build -rc1, so I can't
>>>> say exactly where the hose got cut.
>>>>
>>>>I'd suggest just blowing the v4l directory in the -rc2 kernel away,
>>>>and replacing it with that from 2.6.14.3 just to get back to a
>>>>working sitiuation that you can then start from scratch on.  But
>>>>whatdoIknow? :)Gene Heskett <gene.heskett@verizon.net>
>>>
>>>EEK!  This is not the problem that I'm having at all.....  Then
>>> again, I have a different board.
>>>
>>>Gene, telling someone to revert all the v4l changes in 2.6.15 doesn't
>>>help us to fix the actual problem at all, nor will it help them use
>>>their hardware.
>>>
>>>Gene, I believe that I asked you to install the cvs modules against
>>>2.6.14, and you told me that doing that works.
>>
>>No, I never did get it to work Michael, and I believe I said so,
>> mainly because it wouldn't even compile.  ISTR I sent a message with
>> the compiler exit messages at the time.
>>
>>Now I'd be willing to try it again, but I'd need exactly the
>> proceedure as it would apply to a working 2.6.14.x kernel.  I don't
>> think I did it right the last time.  My script, fwiw, renames one
>> generation back so that a bad kernel can be reverted easily by
>> renameing the vmlinuz and /lib/modules/version-number trees.  Its
>> kind of a swiss army knife in that I comment/uncomment stuff in the
>> buildit (thats another script I use to apply then patches etc), but
>> the makeit script only needs the version number updated to match the
>> Makefile and from there its a 'time ./makeit' till I'm done editing
>> grub.conf & ready to reboot.  I've taken note that the recent
>> makefiles apparently does its own depmod operation when doing the
>> modules_install but haven't taken my command out of it yet so that
>> gets done twice..
>>
>>>The code in cvs
>>>contains all the patches that we have sent to 2.6.15 and THEN some.
>>>Can you please confirm that installing the cvs modules from v4l-dvb
>>>cvs (v4l and dvb have merged cvs repo's) against 2.6.14 is NOT
>>>broken??  This would rule out any possibility of the v4l changes in
>>>2.6.15 being the cause of your problems.
>>
>>See above.
>>
>>>It is WELL established that there are memory errors in 2.6.15
>>>(although I thought they were all fixed -- guess not).  I understand
>>>that you are using some MakeIt script to build your kernel -- have
>>> you tried the standard method?
>>
>>My script does it essentially the same as one would do it by hand. 
>> The exception being that I understand the Makefile now has an install
>> target for the kernel, but my script does the copying rather than
>> calling that, and *I* do the grub.conf editing.
>>
>>>[...a few minutes go by...]
>>>
>>>OKAY, I concur -- When I did my testing for 2.6.15-rc2-git6, that was
>>>with my saa7134-based card, using nxt200x ... success!
>>>
>>>However, when I tried using my FusionHDTV3 Gold-T (cx88 card using
>>>lgdt3302), neither analog nor digital works in 2.6.15-rc2-git6....
>>>Under 2.6.13 (and 2.6.14, i think), however, digital DOES work. 
>>> Analog still doesnt work, but i believe that my hardware is damaged.
>>
>>He should do a full shutdown and cold boot to a kernel he knows works,
>>and I expect the analog will work again.  Warm reboots DO NOT DO IT!
>>
>>>SO, looks like we have a regression somewhere in the kernel that
>>> breaks the cx88 driver :-(
>>>
>>>I don't even know where to begin.
>>>
>>>...One idea... We also know that upstream changes created some
>>> compile warnings in tuner-core...  Hans has fixed that in cvs --
>>> maybe Hans' patch in v4l-dvb cvs could fix it?  Gene, try installing
>>> v4l-dvb cvs against 2.6.15-rc2-git6 (or later) and see if that might
>>> fix NTSC. Somehow, I doubt it -- but it is certainly worth a try.
>>
>>Like I said, complete instructions please so that we are on the same
>>page.  I still have the rc2-git6 tree that didn't work, so as my
>> script does a make clean, it should be easy enough to do with the
>> right instructions.  Like what dir in the kernel tree am I supposed
>> to be in when I issue the cvs checkout command etc.
>
>Gene-
>
>Let's go a slightly different route... First off, I must say:
>
>I think that I over-reacted in my previous email.  To test, I have
>installed v4l-dvb cvs over kernels 2.6.13, 2.6.14, and 2.6.15-rc2-git6,
>and all three worked fine with my FusionHDTV3 Gold-T in ATSC mode.  It
>was the vanilla 2.6.15-rc2-git6 that didnt work for me.  With the cvs
>modules installed, however, it is working well.
>
>Right now, I am in the process of recompiling my vanilla
> 2.6.15-rc2-git6 kernel, to confirm that this actually is a new
> regression.  If it is in fact a regression in 2.6.15, then it is
> likely to be a v4l regression. Luckily, Mauro and I have prepared some
> patchsets to fix some 2.6.15 bugs and compile warnings.  It seems that
> this might be one of the bugs that is now fixed in cvs.
>
>Anyhow, would you like to give cvs a whirl under your 2.6.15-rc2-git6
>kernel?
>
>There is a wiki-howto, located at:
>http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS
>
>... but I will include instructions in this email for your convenience.
>
>Here's how:
>
>1) Please start with vanilla 2.6.15-rc2-git6 ... Have the kernel
> already installed and running.
>
>2) Check-out the newly merged v4l-dvb cvs repository:
>
>   cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux login
>   cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux co
> v4l-dvb
>
>3) Change into the v4l-dvb directory:
>
>   cd v4l-dvb

Got it to that point, but I need to reboot AFTER I disable the modprobe
statement in my r.clocal file.  That loads about 25 modules it seems &
I don't want the old code to touch it before I've rebuilt the cvs.

Ok, rebooted to 2.6.15-rc2-git6

>4) (optional) If you are recompiling the cvs modules against a
> different kernel, clean the tree and kernel version info:
>
>   make distclean
>
Skipped

>5) Compile the modules:
>
>   make

Working now. Done.  The only odd thing was a couple of lines as it
started stateing 'no version now' but several lines later it had found
the kernel version ok.

>
>6) Install them: (as root)
>
>   make install

is this supposed to be make modules_install?  I did the plain one.
That seemed to work, a repeat shows this:

[root@coyote v4l-dvb]# make install
make -C /usr/src/v4l-dvb/v4l install
make[1]: Entering directory `/usr/src/v4l-dvb/v4l'

Eliminating old V4L modules (errors on this step is not a problem)..
make[1]: [v4l-rminstall] Error 1 (ignored)


Installing new V4L modules at corresponding Kernel dir...
install -d /lib/modules/2.6.15-rc2-git6/kernel/drivers/media/common
install -m 644 -c ir-common.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/common
install -d /lib/modules/2.6.15-rc2-git6/kernel/drivers/media/video
install -m 644 -c btcx-risc.ko bttv.ko tda9887.ko tuner.ko tvaudio.ko
tveeprom.ko saa6588.ko tvmixer.ko v4l1-compat.ko v4l2-common.ko
wm8775.ko cs53l32a.ko video-buf.ko video-buf-dvb.ko ir-kbd-gpio.ko
ir-kbd-i2c.ko msp3400.ko tvp5150.ko saa711x.ko saa7134-alsa.ko
saa7134-oss.ko saa7115.ko cx25840.ko saa7127.ko compat_ioctl32.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/video
install -d /lib/modules/2.6.15-rc2-git6/kernel/drivers/media/video/cx88
install -m 644 -c cx8800.ko cx8802.ko cx88-alsa.ko  cx88-blackbird.ko
cx88xx.ko cx88-dvb.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/video/cx88
install: cannot stat `cx88-alsa.ko': No such file or directory
make[1]: [v4l-install] Error 1 (ignored)
install -d
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/video/saa7134
install -m 644 -c saa6752hs.ko saa7134.ko saa7134-empress.ko
saa7134-dvb.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/video/saa7134
install -d
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/video/em28xx
install -m 644 -c em28xx.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/video/em28xx
/sbin/depmod -a

Eliminating old DVB modules (errors on this step is not a problem)..
make[1]: [dvb-rminstall] Error 1 (ignored)


Installing new DVB modules at corresponding Kernel dir...
install -d /lib/modules/2.6.15-rc2-git6/kernel/drivers/media/common
install -m 644 -c saa7146.ko saa7146_vv.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/common
install -d
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/frontends
install -m 644 -c cx22702.ko dvb-pll.ko lgdt330x.ko or51132.ko
tda1004x.ko mt352.ko sp887x.ko nxt6000.ko cx24110.ko or51211.ko
nxt200x.ko cx24123.ko mt312.ko stv0299.ko nxt2002.ko bcm3510.ko
dib3000mb.ko dib3000mc.ko ves1820.ko  cx22700.ko tda8083.ko ves1x93.ko
stv0297.ko sp8870.ko  l64781.ko s5h1420.ko tda10021.ko at76c651.ko
tda80xx.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/frontends
install -d /lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/bt8xx
install -m 644 -c bt878.ko dvb-bt8xx.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/bt8xx
install -d
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/dvb-core
install -m 644 -c dvb-core.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/dvb-core
install -d /lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/b2c2
install -m 644 -c b2c2-flexcop.ko b2c2-flexcop-pci.ko
b2c2-flexcop-usb.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/b2c2
install -d
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/cinergyT2
install -m 644 -c cinergyT2.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/cinergyT2
install -d /lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/dvb-usb
install -m 644 -c dvb-usb.ko dvb-usb-vp7045.ko dvb-usb-vp702x.ko
dvb-usb-dtt200u.ko dvb-usb-a800.ko dvb-usb-dibusb-mb.ko
dvb-usb-dibusb-mc.ko dvb-usb-nova-t-usb2.ko dvb-usb-umt-010.ko
dvb-usb-digitv.ko dvb-usb-cxusb.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/dvb-usb
install -d /lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/pluto2
install -m 644 -c pluto2.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/pluto2
install -d /lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/ttpci
install -m 644 -c budget-core.ko budget.ko ttpci-eeprom.ko budget-av.ko
budget-ci.ko budget-patch.ko dvb-ttpci.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/ttpci
install -d
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/ttusb-budget
install -m 644 -c dvb-ttusb-budget.o
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/ttusb-budget
install -d
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/ttusb-dec
install -m 644 -c ttusb_dec.ko ttusbdecfe.ko
/lib/modules/2.6.15-rc2-git6/kernel/drivers/media/dvb/ttusb-dec
/sbin/depmod -a
make[1]: Leaving directory `/usr/src/v4l-dvb/v4l'
------------------
Now the acid test, reboot...  Humm, rebooted, but the line in rc.local,
that I ran from a vt after logging in as root, did not find the
cx88-dvb module, so nothing is loaded.  Odd, maybe a typu the first
time, the second time after starting x seems to have worked.

So lets see if it works.  Nope, same symptoms as before, huge amount of
digital noise on-screen, and the audio is thoroughly buried in the
noise.  Just like the antenna is unplugged, but there is 60,000-65,000
u-v at the tuners input.

>7) Reboot the machine
>
>Hopefully, this will fix your problem.  Please let me know.

And now you know.  And I'm gonna cold reboot to 2.6.14.3, which will
restore it, or has several times before.

>-Michael Krufky

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.



