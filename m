Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267357AbUGNKdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267357AbUGNKdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUGNKdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:33:44 -0400
Received: from holomorphy.com ([207.189.100.168]:412 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267357AbUGNKdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:33:42 -0400
Date: Wed, 14 Jul 2004 03:33:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lenar L?hmus <lenar@vision.ee>, linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040714103334.GO3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Takashi Iwai <tiwai@suse.de>, Lenar L?hmus <lenar@vision.ee>,
	linux-kernel@vger.kernel.org
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <40F40080.8010801@vision.ee> <20040713221654.GJ21066@holomorphy.com> <40F4E7F9.3020603@vision.ee> <s5hekneanl4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hekneanl4.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At Wed, 14 Jul 2004 10:59:53 +0300, Lenar L?hmus wrote:
>> And this still seems to be very long and real:
>> 50ms non-preemptible critical section violated 2 ms preempt threshold 
>> starting at snd_pcm_action_lock_irq+0x1b/0x1d0 [snd_pcm] and ending at 
>> snd_pcm_action_lock_irq+0x65/0x1d0 [snd_pcm]
>> Trace has this:
>> [<f9239b09>] snd_pcm_playback_ioctl1+0x49/0x2f0 [snd_pcm]
>> So maybe this too is ioctl related (non-educated guess)?

On Wed, Jul 14, 2004 at 12:29:43PM +0200, Takashi Iwai wrote:
> If it's SNDRV_PCM_IOCTL_PREPARE, I'm modifying the relevant code with
> rwsem instead of rwlock.  But it's still in BKL of ioctl.  Do we need
> to unlock internally?

Yes, otherwise it'll be non-preemptible.


-- wli
