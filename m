Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVLTNnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVLTNnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 08:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVLTNnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 08:43:13 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:40662 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751008AbVLTNnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 08:43:12 -0500
Date: Tue, 20 Dec 2005 08:43:46 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: -rc6 vs desktop use, desktop 0
In-reply-to: <200512201453.08826.kernel@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200512200843.46412.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512191808.18784.gene.heskett@verizon.net>
 <200512192238.31857.gene.heskett@verizon.net>
 <200512201453.08826.kernel@kolivas.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 December 2005 22:53, Con Kolivas wrote:
>On Tue, 20 Dec 2005 02:38 pm, Gene Heskett wrote:
>> On Monday 19 December 2005 22:21, Con Kolivas wrote:
>> >On Tue, 20 Dec 2005 02:11 pm, Gene Heskett wrote:
>> >> On Monday 19 December 2005 21:04, Con Kolivas wrote:
>> >> >Actually my question was what patches (if any) did you add to
>> >> > rc6?
>> >>
>> >> None Con, here is the script that builds it:
>> >
>> >Ah ok.
>> >
>> >When you said
>> >
>> >>Useing Con's scheduler as default in both cases.
>> >
>> >I'm pretty sure that others would have been confused as well as
>> > myself. I assumed you patched it with my alternate (staircase)
>> > scheduler. This is also why I responded to your email. Thus it is
>> > likely you won't get attention from anyone else unless you
>> > specify that you're using a vanilla kernel. Unfortunately I don't
>> > know what the problem is you're seeing.
>>
>> So I should repost, specifying a vanilla 2.6.15-rc6 kernel?
>
>Yes, with usual output of .config, lspci and dmesg. diff your dmesg
> between rc5's dmesg and rc6's if you can.

Ok, I rebuilt it with the size option back on and rebooted to it.
I'd previously saved the output of lspci as pspci-rc5 and now I've 
saved it to lspci-rc6, but there is no diff output, nor is there a cmp 
output.

As for the dmesg diffs, its included below.

The only .config diff is the addition and turning on of the compile for 
min size option, unchecking that mungs the system timekeeping and 
trashes the screen of any vt you are trying to use with error messages 
at about 1 second intervals.

>> Well, FWIW, its a sure one sickly dawg the vet needs to see
>> quickly. Its simply not usable for a desktop when stuff goes to
>> sleep for 10-30 seconds at a time. -rc5 vs kmail is a drag but its
>> rarely more than 5 or so seconds till it catches up with your
>> fingers, but -rc6 takes this to a whole new level.  And kpm nor
>> htop does not show a reason, seti is still getting 85% of the cpu
>> when I'm stalled, down from 98% when there is nothing else going
>> on.
>>
>> I was rather hoping you might have some clues or something to try,
>> but if 2.6.15 runs like -rc6, no one will want to run it for very
>> long.
>
>Check your syslogs for errors. These kinds of stalls are often
> related to huge dumps into syslogs. For what it's worth rc6 works
> fine for me.

And this time, it also seems to be much better than the first time, 
this is usable now.

>Cheers,
>Con
-----------------dmesg diff----------------
--- dmesg-rc5 2005-12-19 18:03:24.000000000 -0500
+++ dmesg-rc6 2005-12-20 08:19:45.000000000 -0500
@@ -1,4 +1,4 @@
-Linux version 2.6.15-rc5 (root@coyote.coyote.den) (gcc version 3.3.3 
20040412 (Red Hat Linux 3.3.3-7)) #5 PREEMPT Tue Dec 6 21:48:29 EST 
2005
+Linux version 2.6.15-rc6 (root@coyote.coyote.den) (gcc version 3.3.3 
20040412 (Red Hat Linux 3.3.3-7)) #3 PREEMPT Tue Dec 20 07:33:25 EST 
2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
@@ -43,16 +43,16 @@
 mapped APIC to ffffd000 (fee00000)
 mapped IOAPIC to ffffc000 (fec00000)
 Initializing CPU#0
-CPU 0 irqstacks, hard=c0477000 soft=c0476000
+CPU 0 irqstacks, hard=c03f6000 soft=c03f5000
 PID hash table entries: 4096 (order: 12, 65536 bytes)
-Detected 2087.920 MHz processor.
+Detected 2088.517 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 1035040k/1048512k available (2559k kernel code, 12880k 
reserved, 773k data, 184k init, 131008k highmem)
+Memory: 1035556k/1048512k available (2076k kernel code, 12364k 
reserved, 772k data, 152k init, 131008k highmem)
 Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
-Calibrating delay using timer specific routine.. 4179.94 BogoMIPS 
(lpj=2089972)
+Calibrating delay using timer specific routine.. 4179.92 BogoMIPS 
(lpj=2089963)
 Security Framework v1.0.0 initialized
 Capability LSM initialized
 Mount-cache hash table entries: 512
@@ -146,10 +146,11 @@
 Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
 Initializing Cryptographic API
 io scheduler noop registered
+io scheduler anticipatory registered
 io scheduler deadline registered
 io scheduler cfq registered (default)
 ACPI: Fan [FAN] (on)
-ACPI: Thermal Zone [THRM] (66 C)
+ACPI: Thermal Zone [THRM] (10 C)
 isapnp: Scanning for PnP cards...
 isapnp: No Plug & Play device found
 Real Time Clock Driver v1.12
@@ -262,7 +263,7 @@
 Using IPI Shortcut mode
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
-Freeing unused kernel memory: 184k freed
+Freeing unused kernel memory: 152k freed
 kjournald starting.  Commit interval 5 seconds
 input: AT Translated Set 2 keyboard as /class/input/input2
 EXT3 FS on hda7, internal journal
------------------------------

As for an lspci, they are identical
---------------lspci-rc6---------------
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different 
version?) (rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev 
c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev 
c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev 
c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev 
c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev 
c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev 
a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:07.0 Multimedia video controller: Conexant Winfast TV2000 XP (rev 
05)
01:07.2 Multimedia controller: Conexant: Unknown device 8802 (rev 05)
01:09.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 
IEEE-1394a-2000 Controller (PHY/Link)
02:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 
9200 SE] (rev 01)
02:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] 
(Secondary) (rev 01)
----------------

And as I'm working on composing this message, I have to say that this 
is 100,000% better than the first try.  I can use this ok.

So what did the -rc6 original fubar?  DamnifIknow.  From an 
identical .config, its totally different acting.  But it did just 
freeze for 15 seconds, totally, while kmail was doing a fetch & filter 
run.  Thats some longer than usual but semi-tolerable.  This is also a 
well known and much bitched about 'feature' of kmail.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should use this
address: <gene.heskett@verizononline.net> which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
