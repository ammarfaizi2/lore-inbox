Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbTL0UY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 15:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTL0UY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 15:24:56 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:17645 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264420AbTL0UYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 15:24:00 -0500
Date: Sat, 27 Dec 2003 12:12:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jaroslav Kysela <perex@suse.cz>
cc: Edward Tandi <ed@efix.biz>, azarah@nosferatu.za.org,
       alsa-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       Stan Bubrouski <stan@ccs.neu.edu>
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
Message-ID: <3800000.1072555973@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0312272050140.25504@pnote.perex-int.cz>
References: <1080000.1072475704@[10.10.2.4]> <1072479167.21020.59.camel@nosferatu.lan> <1480000.1072479655@[10.10.2.4]> <1072480660.21020.64.camel@nosferatu.lan> <1640000.1072481061@[10.10.2.4]> <1072482611.21020.71.camel@nosferatu.lan> <2060000.1072483186@[10.10.2.4]> <1072500516.12203.2.camel@duergar> <8240000.1072511437@[10.10.2.4]> <1072523478.12308.52.camel@nosferatu.lan><1072525450.3794.8.camel@wires.home.biz> <1960000.1072550125@[10.10.2.4]> <Pine.LNX.4.58.0312272050140.25504@pnote.perex-int.cz>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> --- compile/sound/core/oss/pcm_oss.c.old	Mon Nov 17 18:29:43 2003
>> +++ compile/sound/core/oss/pcm_oss.c	Sat Dec 27 10:32:30 2003
>> @@ -814,7 +814,7 @@
>>  			xfer += tmp;
>>  			if (substream->oss.setup == NULL || !substream->oss.setup->wholefrag ||
>>  			    runtime->oss.buffer_used == runtime->oss.period_bytes) {
>> -				tmp = snd_pcm_oss_write2(substream, runtime->oss.buffer, runtime->oss.buffer_used, 1);
>> +				tmp = snd_pcm_oss_write2(substream, runtime->oss.buffer, runtime->oss.period_bytes, 1);
>>  				if (tmp <= 0)
>>  					return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
>>  				runtime->oss.bytes += tmp;
> 
> It's not a good fix. 

OK you know the code far better than I ... but it sounds a lot better ;-)
So *something* around there is broken. It sounds horrible in 2.6.0 virgin.

> The problem might be that the rate convert plugin is 
> activated. When small chunks are passed to this plugin, the quality drops.
> You can check it with this command (and compare native and OSS rates):
> 
>   cat /proc/asound/card0/pcm0p/sub0/*

OSS rate: 44100
rate: 48000 (48000/1)

However, test2 worked fine - and it works fine with whole-frag turned on ...
has the rate conversion changed?

> Also, we fixed some OSS emulation errors in our latest code which is 
> available here:
> 
>   bk pull http://linux-sound.bkbits.net/linux-sound
> 
> or
> 
>   ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-12-05.patch.gz
> 
> I will prepare new patch for recent kernel soon.

I tried the above patch - doesn't help.

Thanks,

M.

