Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317516AbSFIDVY>; Sat, 8 Jun 2002 23:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSFIDVX>; Sat, 8 Jun 2002 23:21:23 -0400
Received: from demeter.chem.ucsb.edu ([128.111.116.91]:6 "EHLO
	demeter.chem.ucsb.edu") by vger.kernel.org with ESMTP
	id <S317516AbSFIDVW>; Sat, 8 Jun 2002 23:21:22 -0400
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
From: Dean Townsley <townsley@physics.ucsb.edu>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
cc: linux-kernel@vger.kernel.org
Subject: My tribulations with the SiS 5513 ide chipset
X-URL: http://www.physics.ucsb.edu/~townsley
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Jun 2002 20:21:15 -0700
Message-Id: <E17GtGV-00054p-00@demeter.chem.ucsb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

This message is prompted by two things: One my system is unstable, it has now 
locked about 3 times, with "hda: lost interrupt" (more explanation below).  
Also your recent exchange on linux-kernel with an "Andre LeBlanc" 
<ap.leblanc@shaw.ca>. (about 2 weeks ago now see  "Re: More UDMA Troubles" in 
http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=1&s=leblanc&q=b )
I am using debian kernel 2.4.17 as he was when he started out.

I want to tell you my experience for information, and maybe I'll be able to 
test something (problem being my crashes are not reproducable, they just 
happen randomly).

I have an ECS K7S5A motherboard with an SiS chipset and a Duron 950 processor. 
lspci says:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 90)
00:0b.0 SCSI storage controller: Future Domain Corp. TMC-18C30 [36C70]
00:0d.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85)

The SCSI controller only has a scanner hooked to it.  The one "strange" thing 
about my system is my hard drive is a HITACHI_DK227A-41, a laptop drive that I 
have attached through a little plug adaptor.  I don't expect DMA to work 
through this, but I never had a problem on the previous MB it was plugged 
into, a VIA chipset, it would get a CRC error and just turn off DMA and all 
would be well.

1.  I must turn off DMA manually with hdparm -d0.  Otherwise I get MASSIVE 
DISK CORRUPTION!!  From what I've read of DMA since then I would think that 
the CRC built into UDMA would prevent this.  But it happens anyway,  always 
reads fine (boots up mounts etc) but DMA write hoses the filesystem.

2.  turning DMA off with a kernel parameter DIDN'T WORK!!  This caused me to 
obliterate the system for the second time in a row.  I have inserted hdparm 
-d0 /dev/hda in an rc script so that it runs before remounting read-write.  
This seemed to fix the problem.  (I hope this has been fixed since :) )

That was all about in March (a while ago)  All has been well until two weeks 
ago when I decided to start using the onboard ethernet (sis900), up to that 
point I had been using an ISA ethernet card.  Well, two days after that (which 
means I don't *really know* that it's related), the system locked up just 
randomly.  I was browsing the web and making some notes in a text file and 
things just locked one after another.  A day later the same thing happened, 
but this time I was able to switch to the console before X Windows locked and 
it simply repeated "hda: lost interrupt" every 30 seconds or so until I reset 
it.

I went and jiggled and pressed on the ide cables to make sure I hadn't knocked 
anything loose, but everything seemed ok.  I ran repeated kernel compiles 
overnight and it stayed up.  It has been fine until this morning (two weeks 
later) when it locked again and I started looking around and found the 
messages on linux-kernel.  I looked at the 19-pre8 patch and it looks like 
you've done a fair amount of work on the DMA code.  (Though I shouldn't 
actually be using any of that since dma is disabled (?) ).

This morning after the crash I even had trouble booting.  Even with dma turned 
off it still wouldn't work.  Once it locked during the fsck, and the second 
time it produced DMA errors during drive detection!  I then did a real 
power-cycle (not reset) and turned off 32-bit IO in the bios (there's nowhere 
to turn off DMA like there was in my VIA bios, but I think this is 
approximately equivalent).  It then booted and e2fsck fixed things up and it 
seems to work.  I have no idea if turning off 32-bit io in the bios will make 
it stable or not, we'll see what happens.

This message is mostly for your information, but if you have any advice I'll 
take it.  If I have the chance (or if it locks up again) I'll probably update 
to the 2.4.19-pre8 kernel, but I can't guarantee it (I'm getting ready for a 
scientific conference in two weeks).  And since I can't reproduce the lockup, 
it can't be definitive.


Finally, A question:  There are newer BIOS' listed on the ECS site that say 
something like "timing adjusted to improve stability and compatibility".  What 
exactly does that mean and could it be significant to my problem?

I hope you could this made sense and gives you some useful information.  I'll 
email again if I have more info.  Please feel free to ask me questions or for 
clarification.

Best Regards,
-Dean Townsley

