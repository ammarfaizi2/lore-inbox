Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269124AbTGUBGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 21:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269131AbTGUBGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 21:06:46 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:32510 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S269124AbTGUBGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 21:06:44 -0400
Message-ID: <3F1B4027.2010301@wmich.edu>
Date: Sun, 20 Jul 2003 21:21:43 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030628
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Axelsson <smiler@lanil.mine.nu>
CC: Lukas Kolbe <lucky@knup.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-mm2 music skips
References: <1058733270.1169.32.camel@tigris.chaoswg> <1058744854.32319.7.camel@sm-wks1.lan.irkk.nu>
In-Reply-To: <1058744854.32319.7.camel@sm-wks1.lan.irkk.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Axelsson wrote:
> On Sun, 2003-07-20 at 22:34, Lukas Kolbe wrote:
> 
>>Hi!
>>
>>Just wanted to let you know that on my System (Debian Sid, Kernel
>>2.6.0-test1-mm2, .config attached) I get sound-skips with all recent
>>Kernels (tested 2.5.69 'til 2.6.0-test1-mm2). 
>>With each new version it gets better, but I still can produce
>>audio-skips.
>>
>>For music-hearing-pleasure I use xmms, it plays .oggs, .mp3s.
>>With .mp3s I potentially get more skips than with .oggs.
>>The skips occur while switching desktops in Gnome 2.2 with many windows
>>open, or while marking the Desktop drawn by Nautilus with it's
>>nice-looking shading square, or while starting large apps like the Gimp
>>or Mozilla.
>>
>>Intersting though is that I'm not able to produce audio-skips for Mod's
>>(.mt2, .xm, .it) in xmms.
>>
>>A switch from X to a VC and back also reproducibly produces a ~1.5
>>seconds skip.
>>
>>System is as follows:
>>
>>Duron 1.3
>>256MB DDR-RAM
>>Elitegroup K7S5A
>>WDC WD800BB-00CAA0
>>Ensoniq 5880 AudioPCI (rev 02)
>>nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev a1)
>>
>>And no, Xfree is not reniced :)
>>I'm not on the list, so pleas Cc me on reply. Although I'm periodically
>>reading the archives.
>>
>>Can I help somehow?
> 
> 
> Please read the O*int threads.
> It's probably Con's new scheduler that is causing these problems.
> If you are using alsa, try the OSS emulation as it seems to help abit.
> 

I've been using the 2.5 kernel for a long time now and the 2.4 kernel 
since it was just turned into 2.3. There have been these "problems" 
since 2.3, this is not something new caused by any new schedulers. The 
schedulers can cause problems, no doubt, but they also make userspace 
programming issues apparent. The fact that going to oss emu only proves 
that this is mostly a userspace problem. ALSA drivers have to be coded 
with much more attention to latency because it's very specific about 
being run on time. You can only send it a small amount of data every 
write you make to the soundcard.  It's a tradeoff for low latency.  Some 
of the plugins in these programs are just going to need to be 
streamlined.  The scheduler problems are problems when something is not 
getting it's time on the cpu when it's niced to -20 by programs not 
niced at that level.  This is a scheduler problem.  But i'm still rather 
confident that the majority of skipping in audio playing is a userspace 
problem brought on by being too lenient with how the decoder is looping 
and deciding to loop.   Players have to balance how much cpu they want 
to be reported as using to how skip resistant they want to be.  If you 
only loop around once a second and you expect 3/4 of a second or a 
second to be played by then, then you're likely to get skips when 
something steal the cpu or is really using it. Players do this to use 
less cpu because people assume less cpu usage automatically means it's 
better.  You could also simply tune that plugin to loop every 1/4 second 
  and it would be exponentially harder to cause a skip but it would use 
more cpu. And that's not counting less than efficient decoding loops. 
etc etc.

I'd suggest testing against players using different decoders (different 
players as well) and seeing if the problem is exactly the same for all 
of them. I seriously doubt it will be found that it is.

