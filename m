Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbVLFEBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbVLFEBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbVLFEBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:01:19 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:28536 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751592AbVLFEBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:01:18 -0500
Date: Mon, 05 Dec 2005 23:01:16 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ntp problems
In-reply-to: <1133839229.7605.63.camel@cog.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Message-id: <200512052301.16998.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512050031.39438.gene.heskett@verizon.net>
 <200512052107.24427.gene.heskett@verizon.net>
 <1133839229.7605.63.camel@cog.beaverton.ibm.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 22:20, john stultz wrote:
>On Mon, 2005-12-05 at 21:07 -0500, Gene Heskett wrote:
>> On Monday 05 December 2005 19:14, john stultz wrote:
>> >On Mon, 2005-12-05 at 18:33 -0500, Gene Heskett wrote:
>> >> On Monday 05 December 2005 16:39, john stultz wrote:
>> >> >On Mon, 2005-12-05 at 00:31 -0500, Gene Heskett wrote:
>> >> >> Greetings everybody;
>> >> >>
>> >> >> I seem to have an ntp problem.  I noticed a few minutes ago
>> >> >> that if my watch was anywhere near correct, then the computer
>> >> >> was about 6 minutes fast.  Doing a service ntpd restart crash
>> >> >> set it back nearly 6 minutes.
>> >> >
>> >> >Not sure exactly what is going on, but you might want to try
>> >> > dropping the LOCAL server reference in your ntp.conf. It could
>> >> > be you're just syncing w/ yourself.
>> >>
>> >> Joanne, bless her, pointed out that I had probably turned the ACPI
>> >> stuff in my kernel back on.  She was of course correct, shut it
>> >> off & ntpd works just fine.
>> >
>> >Err. ACPI stuff? Could you elaborate? Sounds like you have some sort
>> > of bug hiding there.
>>
>> This has been a relatively long standing problem, John.  I think its
>> possibly related to some access path in the nforce2 chipset as it
>> seems to plague that chipset worse than others.  But its long been,
>> and I had forgotten, that if ntpd didn't work, turning off the ACPI
>> stuff was the fix.
>
>Hey Gene,
>
> I know we've spoken before about a few timekeeping problems, but
>sometimes I have a hard time keeping all the issues straight. Have you
>filed a bug on this issue? I queried for your email in
>bugzilla.kernel.org and I couldn't find anything. If not, would you
> mind opening a bug describing the behavior you are seeing with the
> different boot options (possibly also dmesg output for both
> configurations)? It will greatly help make sure this doesn't slip by
> without notice.

You're asking me to fight with bugzilla again John?  I'm not THAT 
masochistic.

When you have to lose your cool to get out of the search for duplicate 
entries menu's, I call the software broken.  Lifes too short to put up 
with that, just let me file the friggin bug and let the software search 
for similar ones.  If there are, then it should email you for 
clarification as to whether my bug is a dup, or a new one with different 
triggering conditions.  The present interface is a genuine PITA.

>> It had worked for a few kernel.org kernels and I had become
>> complacent. My mistake.
>>
>> OTOH, calling it a local bug, no, I certainly wouldn't call it a
>> local to my machine bug.  Jdow OTOH, running an FC4 box, has it
>> enabled, and hers is working just fine.  She is I believe, running
>> the FC4's latest kernel too, so maybe the redhat people have massaged
>> it.  However, at one time several months ago I believe she also had
>> to have a grub argument turning acpi=no.
>
>Hmmm. Indeed the nforce2 has had a number of problems, but I'm not sure
>why it would have changed recently. Can you bound at all the kernel
>versions where it worked and where it broke? Additionally, do be sure
>you have the most recent BIOS, I've seen a number of nforce2 issues be
>resolved with a BIOS update.

I've already put more powerdown cycles (60 some) on my hard drives 
fighting with the recent tv card problem, I'd like to get some uptime 
in.  All I know for sure is if I build 2.6.15-rc5 with acpi, ntpd 
doesn't work.  ntpdate does, but ntpd doesn't.  And both dmesg and the 
ntp.log (and -d's passed at launch time do not make it more verbose, 
they just keep it from starting) are silent as to the diffs other than 
the interrupt number shuffling in dmesg when its on.  But I suspect it 
may have started with 2.6.15-rc2, and I didn't build rc1.  And I *think* 
it worked as recently as 2.6.14.1 with it turned on.  I've cleaned house 
in /usr/src's so I don't have anything older.  Sorry.

>> There was a bunch of ntp related patches submitted recently, and I
>> have no idea which of them may have restored the broken acpi vs ntp
>> scenario to its formerly broken status, again.
>
>I don't think the NTP changes would have triggered this, but I want to
>be sure (its more likely something else in the timekeeping code is
>causing problems).
>
>> Should it be looked at?  Certainly, but I don't have the knowledge to
>> do so.  So I build kernels, and report problems areas.  The canary in
>> the coal mine so to speak. :-)
>
>The testing and problem report is very much appreciated! Start with
>filing a bugzilla bug and then I'll point you at a few more mines to
>checkout :)

Maybe next week when I have restored my patience, its been in short 
supply lately over this tv card problem.  Joanne (jdow) might be able to 
furnish more co-oberating details as she sees more machines at earthlink 
in a days work than I do in a year.  I only have 3 here on my little 
network, one rh7.3 box (firewall), this one, and a box in the shop that 
runs my milling machine, so there is not at the moment, a sacrificial 
lamb.

>thanks
>-john

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
