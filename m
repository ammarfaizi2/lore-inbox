Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270796AbRH1LoH>; Tue, 28 Aug 2001 07:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270779AbRH1Ln6>; Tue, 28 Aug 2001 07:43:58 -0400
Received: from femail48.sdc1.sfba.home.com ([24.254.60.42]:5033 "EHLO
	femail48.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270784AbRH1Lnt>; Tue, 28 Aug 2001 07:43:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: linux-kernel@vger.kernel.org
Subject: via82cxxx_audio problem.
Date: Tue, 28 Aug 2001 04:43:24 -0700
X-Mailer: KMail [version 1.2]
Cc: adrian@humboldt.co.uk, jgarzik@mandrakesoft.com
MIME-Version: 1.0
Message-Id: <01082804432400.03629@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a new one for you:

This is under 2.4.8-ac9, other kernels have not been tested, but given 
the nature of the problem, I don't think it's specific to the kernel 
version.

When XMMS is pointed to /dev/dsp (as per normal on my system) things are, 
a little odd...
The first symptom I noticed was that Mozilla started up *very* slowly... 
it'd sit there starting for a while, then eventualy, after its starting 
icon disapeared from my KDE taskbar, things would just sit quietly for a 
minute or so, and then suddenly mozilla started.
This is infinitely reproducable on my system, and all I have to do to 
"fix" the problem, is stop XMMS from playing, and Mozilla instantly goes 
back to normal.
This doesn't appear to be an XMMS issue, as pointing it to /dev/null 
(thus also causing it to play absurdly fast...) also "fixes" the problem.

I also noted hdparm -t giving me readings of 3 to 9MB/sec, this is on a 
7200RPM ATA/100 drive from IBM mind you... IBM-DTLA-307045. UDMA is 
enabled, it's on a Promise ATA/100 controller anyway so that's set by 
default. This behavior ceased after I exited XMMS, and I returned to 
normal 32MB+ numbers. This COULD be unrelated, but the timing is too 
coincidental for it to seem likely. This is not currently reproducable, 
will test further when I get some sleep.

Quake3 seems to exhibit similar behavior, but I do not have time at the 
moment to test that more thuroughly, I really need some sleep. I cannot 
test Quake2, as it freezes at sound initialization if XMMS (or anything 
else) is actively using /dev/dsp (this isn't entirely unexpected, though 
if it can't get control of the soundcard, it should normaly drop the 
attempt).
Konqueror, KDE konsole, and KMail don't seem to exhibit this behavior 
though, which is possibly attributable to either their far smaller size, 
or possibly that parts of them remain in memory at all times as a result 
of my running KDE in its entirety. X-Chat and LICQ also do not exhibit 
this behavior, further leading me to suspect it has to do with the 
general size of the process.

I have verified that this doesn't seem to be a problem with the kernel 
taking buffers or cache out of memory when a process needs that memory by 
starting up several large processes (Mozilla) to free RAM up manualy 
before retrying the tests. Why use of /dev/dsp would have any effect 
whatsoever on RAM allocation, I do not know, but with all the VM/memory 
concerns in 2.4, I figured I should probably eliminate that as a problem.

I also have a whole 1448KB in swap right now... why the kernel swaps 
instead of flushing the file cache from RAM, and why it leaves things in 
swap when there's plenty of RAM free, is a puzzle I leave to the experts.


hardware information:

ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
AMD Athlon 800Mhz
256MB PC100 RAM
Soyo K7VIA motherboard, VIA KX133 chipset

Any further information needed is avalible, just be prepared to tell me 
what you need and how to aquire it, and expect to wait at least 12-14 
hours so I can get some sleep.

If all of this is something stupid I missed/did, then you all have my 
explicit permission to thwap me.
