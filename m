Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVCJAkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVCJAkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVCJAhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:37:45 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:8615 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262401AbVCJA11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:27:27 -0500
Date: Wed, 09 Mar 2005 19:27:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime
In-reply-to: <20050309203317.64916119.khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net, video4linux-list@redhat.com,
       sensors@stimpy.netroedge.com
Reply-to: gene.heskett@verizon.net
Message-id: <200503091927.24558.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503082326.28737.gene.heskett@verizon.net>
 <200503090243.06270.gene.heskett@verizon.net>
 <20050309203317.64916119.khali@linux-fr.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 14:33, Jean Delvare wrote:
>Hi Gene, Andrew, all,
>
>(Gene, note that I cannot write to you directly because Verizon are
>idiots. Let's just hope you'll read that.)

Got it, & can't argue with that label.  Some of the labels I've 
applied to them are even more 'colorfull'.. Unforch, they are the 
*only* game in this town. :-(

>[Gene Heskett]
>
>> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:36
>>2: error: unknown field `id' specified in initializer
>
>I've dropped the "id" member of struct i2c_client, as it were
> useless. Third-party driver authors now need to do the same.

Aha!  As in just 'dd' any line containing the .id in vim?

>Patches to pcHDTV 1.6 and 2.0 attached (untested). Feel free to push
> the latter to the author of hdPCTV. Note that the removed struct
> member was really not used before, so the driver will still work
> with earlier kernels.

Good.  But where did you get the 2.0?  My 1.6 is only 2 weeks old here 
as thats about as long as I've had the card, but I haven't checked 
the dl page on Jacks site since yesterday sometime...

Humm, I see its labeled as for FC3, but since the kernel I'm booted to 
right now is linux-2.6.11.2-RT-V0.7.39-02, I'm going to make the 
assumption that I can use it till I find otherwise.

That kernel is locally built, using these patches, from my script:
VERP1="../2.6.11.1"
VERP2="../2.6.11.2"
VERP3="../2.6.11.2-RT-V0.7.39-02"
VERP4="../bk-ieee1394.patch"
VERP5="../2.6.11-forcedeth-fix"
VERP6="../Kconfig-1-patch"
VERP7="../Kconfig-2-patch"

The last 3 remove the '&& EXPERIMENTAL' from the respective Kconfigs 
for nforce2 stuffs.  If its not 'stable' yet, then lets get them 
fixed, this keeping stuff in experimental forever when half the 
planet is using them without any reported gotchas for extended 
periods just plain sucks.  So does the lag in getting 
bk-ieee1394.patch into mainline.  Firewire has been broken for quite 
a few moons now, so I fail to see the reason for the lag when the 
patch itself is demonstratably working great.  My hats off to Dan 
Dennedy & company there.

The only thing that didn't apply clean was Ingo's last RT patch, I 
dropped the ball on the EXTRAVERSION it was looking for in the main 
Makefile.  But vim fixed that right up after the fact.

So basicly, I'm cutting a fresh trail here, trying to scratch my 
personal itches and its not working too bad.  Not bad for an old 
fart.  I'll go see if the pcHDTV-2.0 version for kernels >2.6.9 works 
now, and get back to the list.  Thanks for the heads up on that.

>[Andrew Morton]
>
>> What's pcHDTV-1.6.tar.gz?  If it was merged up then these things
>> wouldn't happen.
>
>I second that, especially since the pcHDTV package is made up of
>modified bttv and cx88 drivers, not an original driver. Merging the
>changes into the kernel would obviously make everyone's life easier.
>
>As a side note, I have (many) other changes to the i2c subystem in
> my plans, some of them are rather intrusive, so expect pcHDTV to
> break again soon, unless it gets merged until then.

I'll second that, this having to do everything to build a new kernel 
twice before its actually built and working is a major PITA.  I'm 
also doing the same thing with the spca5xx stuffs for a webcam.

Silly Q?  How much trouble would it be for me to just copy over the 
revelant src code modules once the patch has been applied?  I could 
make that bit of copying a part of my buildit26 script, a snippet of 
which you see above.  This is my src code tree builder.

>[Gene Heskett]
>
>> Third, somewhere between 2.6.11-rc5-RT-V0.39-02 and 2.6.11, I've
>> lost my sensors except for one on the motherboard called THRM by
>> gkrellm-2.28.  Nothing seems to be able to bring the w83627hf back
>> to life.
>
>THRM is most likely a temperature you get from
> /proc/acpi/thermal_zone, and isn't related with the w83627hf
> driver.

Humm, it is the highest temp reported, as is temp2 in gkrellm, so I 
had assumed it was somehow a dup of the diode in the cpu, or of the 
thermistor against the bottom of it inside the socket.  Wrong 
assumption?

But I just in the last half hour managed to get it working again!

Somehow, in my playing with the CONFIG_BROKEN, (if you have an nforce2 
equipt board, never, ever, uncheck that option, its friggin dangerous 
to your sanity!) the building of the i2c-isa got erased from 
the .config.  Modularizing everything I needed, making sure the 
correct modprobe lines were in my rc.local, and fetching and 
installing the user portions of lm_sensors-2.9.0 to replace the 2.8.7 
stuff, and its suddenly working.

So now, sensors is working, as is gkrellm, and kino is working audio 
and all, but tvtime suddenly has a 2 second delay in anything it does 
including its on-screen clock sitting on a blue screen.  No video, 
just audio.

>I think that you are affected by recent changes made by the ACPI
> folks to the way resources are reserved. See bug #4014:
>  http://bugzilla.kernel.org/show_bug.cgi?id=4014
>
I haven't looked at that yet.

>You can check /proc/ioports on the working system after loading
>w83627hf, and compare with /proc/ioports on the non-working system.
> I'd expect you to find that the non-working system has reserved a
> subrange of what the w83627hf driver attempts to grab, making it
> fail.

Its working again, see above.

Many, many thanks to Jean D., and all on this.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
