Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbRL0P0a>; Thu, 27 Dec 2001 10:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286307AbRL0P0R>; Thu, 27 Dec 2001 10:26:17 -0500
Received: from schwerin.p4.net ([195.98.200.5]:4 "EHLO schwerin.p4.net")
	by vger.kernel.org with ESMTP id <S286308AbRL0PZk>;
	Thu, 27 Dec 2001 10:25:40 -0500
Message-ID: <3C2B3E1D.1050309@p4all.de>
Date: Thu, 27 Dec 2001 16:28:29 +0100
From: Michael Dunsky <michael.dunsky@p4all.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Paul G. Allen" <pgallen@randomlogic.com>
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Sound issues with kernel 2.4.14 - 2.4.17
In-Reply-To: <3C2AA64C.2CD1AD6E@randomlogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul G. Allen wrote:

 > Sound worked fine through kernel 2.4.9. Since I upgraded to 2.4.14, and
 > now to 2.4.17 (I skipped 2.4.10 - 2.4.13) I have several games that are
 > FUBAR, all sound related: Quake III Arena and Quake II both core dump
 > initializing sound; Soldier of Fortune, Railroad Tycoon II, Sid Myers
 > Alpha Centaury all make strange noises with no intelligable game sound.
 > Tribes 2, Unreal Tournament, and Descent 3 all work fine. GNOME and
 > Enlightenment sound work fine as well, as does xmms.
 >
 > I have a SB Live! OEM and have tried compiling with and without the MIDI
 > module. The main thing is I am trying to do some game development and
 > it's impossible when sound is FUBAR. Any ideas?
 >
 > I hate to go back to an earlier kernel as IDE did not work (for me) in
 > the previous kernels.
 >
 > PGA
 >

Hello!

I ran into a similar problem:
Upgraded from 2.4.5 to 2.4.14 and added some RAM (total 1GB now). When not using 
  HIHGMEM_4GB, ~180MB of the RAM was missing. With HIGHMEM_4GB enabled, sound 
was totally trashed (I also had the segfaulting Quake3Arena).

The SBLive uses the "emu10k1"-driver - and the driver that came with 2.4.14 was 
broken if used with "HIGHMEM" enabled. W/o this, the sound had no problems. Rui 
Sousa made it working with HIGMEM enabled. (But sometimes, especially with very 
little free RAM left the sound is still broken )


Have you tried the latest snapshot from opensource.creative.com ?
I've taken a look into the kernel-patches (I'm still at 2.4.14 - will upgrade to 
2.4.17 when SGI's XFS is ready for thet kernel), and there were no 
version-changes in the driver.

How to do it (very short):
Unzip and untar, cd into "emu10k1_<date>" and do "make && make install"
(maybe save the old from "/lib/modules/<kernel-version>/kernel/drivers/sound" 
and "sound/emu10k1" before...) Remove your loaded "emu10k1" and "ac97_codec" 
modules (don't forget this), load the new and test it.

There are some more nice features within Creatives "official" drivers (such as 
bass/treble control)...


ciao

Michael


