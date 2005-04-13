Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVDMV7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVDMV7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 17:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVDMV7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 17:59:39 -0400
Received: from smtp04.auna.com ([62.81.186.14]:40188 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S261201AbVDMV71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 17:59:27 -0400
Message-ID: <425D963C.5030202@latinsud.com>
Date: Wed, 13 Apr 2005 23:59:24 +0200
From: "SuD (Alex)" <sud@latinsud.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OSS] Add CXT48 to modem black list in ac97
References: <E1DInEA-0006md-00@gondolin.me.apana.org.au>
In-Reply-To: <E1DInEA-0006md-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>BTW Alex, if you have the time please determine whether ALSA
>works properly on your machine.
>  
>
Yes, alsa works, it's what i'm using now.

About how alsa detects the hardware, i have been reading some sources
and didn't get the whole point, but some facts:
- In intel8x0.c:
    In snd_intel8x0_probe() there is a call to snd_intel8x0_mixer().
    In that function it does: ac97.scaps = AC97_SCAP_SKIP_MODEM;

- In intel8x0.c:
    In snd_intel8x0m_probe() there is a call to snd_intel8x0_mixer().
    In that function it does: ac97.scaps = AC97_SCAP_SKIP_AUDIO;

- After that is done, in ac97_codec.c:
    http://lxr.linux.no/source/sound/pci/ac97/ac97_codec.c#L1921
    It checks for _SKIP_ variables and probes for soundcard (checking a 
mixer register) and modem (checking modem_id).

As a result, if i insert "snd-intel8x0" it will detect a soundcard (pci 
0:0:1f.5), but if insert instead
"snd-intel8x0M" it will detect a modem (pci 0:0:1f.6).
If a modem is detected i get errors like: "MC'97 0 converters and GPIO 
not ready (0x1)", and not sure how to test it.
If i load both modules only the first will work. The second will give an 
probe error -13 (EACCES?), because it has been marked as audio device, 
but also marked as _SKIP_AUDIO (ac97_codec.c:1862), or viceversa.

PS: And i finally subscribed to the list, thanks for your patience.
