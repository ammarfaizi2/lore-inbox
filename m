Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbUKRQVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbUKRQVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbUKRQTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:19:21 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:51860 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262699AbUKRQRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:17:13 -0500
Message-ID: <419CCBA8.4000205@tmr.com>
Date: Thu, 18 Nov 2004 11:19:52 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Lee Revell <rlrevell@joe-job.com>, Paul Blazejowski <diffie@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Diffie <diffie@blazebox.homeip.net>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: [Alsa-devel] Re: Linux 2.6.10-rc2
References: <1100553392.4369.1.camel@krustophenia.net><9dda349204111512234f30c60d@mail.gmail.com> <s5h7jomdt3w.wl@alsa2.suse.de>
In-Reply-To: <s5h7jomdt3w.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Mon, 15 Nov 2004 16:16:31 -0500,
> Lee Revell wrote:
> 
>>Please report ALSA issues to alsa-devel@lists.sourceforge.net.  I have
>>added them to the cc:.
> 
> 
> The attached patch should fix this.
> 
> 
> Takashi
> 
> ==
> Summary: [ALSA] fix sleep in atomic during prepare callback
> 
> Fixed the sleep in spinlock during prepare callback.
> This happened only on Nforce chips.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> --- linux/sound/pci/intel8x0.c	15 Nov 2004 14:19:52 -0000	1.173
> +++ linux/sound/pci/intel8x0.c	16 Nov 2004 09:41:47 -0000
> @@ -1020,7 +1020,9 @@ static void snd_intel8x0_setup_pcm_out(i
>  			 */
>  			if (cnt & ICH_PCM_246_MASK) {
>  				iputdword(chip, ICHREG(GLOB_CNT), cnt & ~ICH_PCM_246_MASK);
> +				spin_unlock_irq(&chip->reg_lock);
>  				msleep(50); /* grrr... */
> +				spin_lock_irq(&chip->reg_lock);
>  			}
>  		} else if (chip->device_type == DEVICE_INTEL_ICH4) {
>  			if (runtime->sample_bits > 16)

Might this make it into 2.6.10?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
