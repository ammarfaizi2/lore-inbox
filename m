Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbUJ0Nyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbUJ0Nyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUJ0Nyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:54:39 -0400
Received: from mailgate.urz.uni-halle.de ([141.48.3.51]:9100 "EHLO
	mailgate.uni-halle.de") by vger.kernel.org with ESMTP
	id S262444AbUJ0Nwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:52:31 -0400
Date: Wed, 27 Oct 2004 15:52:14 +0200 (METDST)
From: Clemens Ladisch <clemens@ladisch.de>
To: Christoph Hellwig <hch@lst.de>
cc: <perex@suse.cz>, <linux-kernel@vger.kernel.org>,
       <alsa-devel@alsa-project.org>
Subject: Re: [Alsa-devel] [PATCH, RFC] remove dead code an exports from alsa
In-Reply-To: <20041024133813.GA20174@lst.de>
Message-ID: <Pine.HPX.4.33n.0410270953290.8684-100000@studcom.urz.uni-halle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scan-Signature: 3a649d4e1fa61e44c5cb5c4b22c5527a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Alsa currently has tons of dead exports, often with totally unused
> functions behind them.  Care to look over the huge patch below and
> see what makes sense?

Exported for historical reasons (and no longer necessary):

> ===== include/sound/ad1848.h 1.7 vs edited =====
> -void snd_ad1848_dout(ad1848_t *chip, unsigned char reg, unsigned char value);
> -unsigned char snd_ad1848_in(ad1848_t *chip, unsigned char reg);
> -void snd_ad1848_mce_up(ad1848_t *chip);
> -void snd_ad1848_mce_down(ad1848_t *chip);
> -irqreturn_t snd_ad1848_interrupt(int irq, void *dev_id, struct pt_regs *regs);
> ===== include/sound/es1688.h 1.4 vs edited =====
> -irqreturn_t snd_es1688_interrupt(int irq, void *dev_id, struct pt_regs *regs);

Not really used:

> ===== include/sound/ainstr_fm.h 1.1 vs edited =====
> -extern char *snd_seq_fm_id;
> ===== include/sound/ainstr_gf1.h 1.2 vs edited =====
> -extern char *snd_seq_gf1_id;
> ===== include/sound/ainstr_iw.h 1.2 vs edited =====
> -extern char *snd_seq_iwffff_id;
> ===== include/sound/core.h 1.37 vs edited =====
> -extern int snd_cards_count;

I removed all exports above from the ALSA CVS.


The following headers are the driver API, so the unused symbols might
be used by future drivers:

> ===== include/sound/info.h 1.15 vs edited =====
> ===== include/sound/pcm.h 1.30 vs edited =====
> ===== include/sound/rawmidi.h 1.5 vs edited =====
> ===== include/sound/seq_midi_emul.h 1.1 vs edited =====
> ===== include/sound/seq_midi_event.h 1.3 vs edited =====
> ===== include/sound/seq_virmidi.h 1.2 vs edited =====
> ===== include/sound/timer.h 1.7 vs edited =====

However, I think some of these functions should not be part of the
API; I'll remove them, too.


The functions in the snd-trident-synth module might be used when^Wif
MIDI support for it will be written.


Clemens

