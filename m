Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUG3WfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUG3WfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUG3We7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:34:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:42149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267859AbUG3WeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:34:00 -0400
Date: Fri, 30 Jul 2004 15:13:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gene.heskett@verizon.net
Subject: Re: 2.6.8-rc2 crash(s)?
Message-Id: <20040730151332.63313e43.rddunlap@osdl.org>
In-Reply-To: <20040729220342.0a747257.rddunlap@osdl.org>
References: <200407242156.40726.gene.heskett@verizon.net>
	<200407292147.21463.gene.heskett@verizon.net>
	<20040729203603.1023ed38.rddunlap@osdl.org>
	<200407300050.53523.gene.heskett@verizon.net>
	<20040729220342.0a747257.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004 22:03:42 -0700 Randy.Dunlap wrote:

| On Fri, 30 Jul 2004 00:50:53 -0400 Gene Heskett wrote:
| 
| | On Thursday 29 July 2004 23:36, Randy.Dunlap wrote:
| | >On Thu, 29 Jul 2004 21:47:21 -0400 Gene Heskett wrote:
| | >| On Thursday 29 July 2004 18:14, Randy.Dunlap wrote:
| | >| [...]
| | >| I've gone clear back to a 2.6.7 kernel because thats the newest
| | >| one that has a diff when cmp'ing fs/dcache.c files to whats in
| | >| 2.6.8-rc2.
| | >|
| | >| I've had one Oops, virtually the same one, but it didn't kill the
| | >| machine like it would have if I was running 2.6.8-rc2.
| | >
| | >Yeah, oopsen often don't kill the entire machine.
| | 
| | Running 2.6.8-rc2 it sure did, deader than a doornail.  X's clock 
| | stopped, the whole maryann.  Keyboard leds off.  Had to use the reset 
| | button, and once or twice I had to do a full powerdown before it 
| | would enter post and reboot.  Then sit thru 20+ minutes of e2fscking 
| | all the drives of course.
| | 
| | >| >make fs/dcache.s
| | >|
| | >| Aha!  Voila!! It doesn't work in the "fs" subdir, but back out to
| | >| the top of the src tree and it works just fine.  Duh...
| | >
| | >Right, it needs the top-level makfile and kbuild machinery to do
| | > that.
| | >
| | >| Now, I must confess that what I'm looking at in those two files is
| | >| the .s is the source assembly that would normally be fed to gas,
| | >| and the objdump'ed version is the dissed object translated back to
| | >| gas source.  If no mistakes, they should be pretty close to the
| | >| same I'd think.  Am I on the right track?  Or full of it?
| | >
| | >Yes, right.
| | 
| | Which?
| | 
| | Right track, or full of it? :-)
| 
| Right track.  ;)
| 
| | In any event, I could send those two files along if you'd like, I'm 
| | not an assembly guru on "amd/intel" chips, not even in my wildest 
| | dreams .
| | 
| | >| Here's the theory thats gradually formed in whats left of my mind:
| | >| --------------
| | >| 5 things changed in the kernel soft when I changed the mobo.
| | >| 1. The ide driver, from via686a to the nforce2 version.
| | >| 2. The video driver, because the old card failed and took the mobo
| | >| with it.
| | >| 3. Ethernet driver is now forcedeth instead of rtl-8139too
| | >| 4. A different alsa driver, from via8233 to intel-8x0
| | >| 5. The 4Gb switch is turned on in the kernel now as theres a gig
| | >| of ram on this board.
| | >| --------------
| | >
| | >You can easily use a non-high-memory enabled kernel.  It will still
| | >use 896 MB of RAM (IIRC).  Enabling highmem gets you another 128 MB.
| | >
| | >IDE and video are somewhat important, no?
| | >But the ethernet and ALSA drivers should be optional, at least for
| | > some testing... Ha, you said that below!
| | >
| | >| I can't do anything about the first 2, but I can do without the
| | >| last 200 megs of ram long enough to test that, and I can switch
| | >| back to the rtl-8139too card for ethernet, and I can turn off
| | >| alsasound.
| | >|
| | >| In the meantime I turned a bunch of stuff the logs were
| | >| complaining about off, like sgi_fam (what the heck is that?), some
| | >| ups daemons
| | >
| | >FAM is File Alteration Monitor, from SGI:
| | >  http://oss.sgi.com/projects/fam/
| | 
| | So I should start it back up?  Its a security tool?, or a system 
| | watchdog (or both?)
| 
| No, you probably don't need it.  Depends on your apps/usage,
| but it's certainly not _required_.
| 
| | >| for brands I don't have, that sort of thing, and have a tail
| | >| running on the log.  So far, its clean since the restart of
| | >| xinetd.  Another 16 hours will tell most of the tale for this
| | >| particular instant configuration.
| | 
| | I just had mozilla try to display an rpm or tgz file, killed X, so the 
| | log got filled up a bit.  Odd, I haven't had to step on the shift key 
| | before clicking a download link in ages.  Trying to get a newer 
| | version of ymessenger.  I have an old beta version and yahoo says its 
| | too old.
| |  
| | >| One final question if I may:  What do I turn off (or on) in the
| | >| video dept of the kernel so that my screen doesn't go black after
| | >| vmlinuz is unpacked, and not come back on till "init" is run, at
| | >| which point the screen comes back on in what looks to be exactly
| | >| the same mode?
| | >
| | >Hm, do you have a serial console enabled (in the kernel config and
| | > in your kernel command line)?  If not, please send your .config
| | > file (your probably did, but I'm lost in the maze of emails).
| | 
| | Not that I can find, and I'm restricted to a make menuconfig, xconfig 
| | is broken because its not seeing the correct libqt-mt library.  Its 
| | complaining about the version in kde3.2.3, but all the env stuff now 
| | points it to kde3.3-beta2.  How can I cause that to get refreshed for 
| | the newer libraries now installed?
| 
| Dunno, I've seen some similar problems.
| 
| | I'll attach the 2.6.7 .config.
| 
| I'll check it, but I don't have a quick answer for you on that one.

Well, I managed to whack an ext3 partition (/) and have to reinstall it.

Just from looking at your .config, I suggest turning off some/all/most
of these to see if it will boot and run for awhile:

CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y

CONFIG_PREEMPT=y
CONFIG_INPUT_EVBUG=y

CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DEVICE_INTERFACE=y

CONFIG_4KSTACKS=y

--
~Randy
