Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVADAYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVADAYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVADAWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:22:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21767 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262011AbVADALf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:11:35 -0500
Date: Tue, 4 Jan 2005 01:11:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mark_H_Johnson@raytheon.com
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       perex@suse.cz, Takashi Iwai <tiwai@suse.de>,
       alsa-devel@alsa-project.org
Subject: 2.6.10-mm1: ALSA ac97 compile error with CONFIG_PM=n
Message-ID: <20050104001130.GT2980@stusta.de>
References: <OF0551C40F.E8032010-ON86256F7E.007EFEBA-86256F7E.007EFF1F@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0551C40F.E8032010-ON86256F7E.007EFEBA-86256F7E.007EFF1F@raytheon.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 05:07:08PM -0600, Mark_H_Johnson@raytheon.com wrote:
> I was looking to compare RT latency between this kernel and the latest from
> Ingo and I had the following warnings / errors building 2.6.10-mm1:
> 
> [no apparent compile / link errors]
> *** Warning: "snd_ac97_restore_iec958" [sound/pci/ac97/snd-ac97-codec.ko]
> undefined!
> *** Warning: "snd_ac97_restore_status" [sound/pci/ac97/snd-ac97-codec.ko]
> undefined!
>...
> To fix this, should I just add the EXPORT_SYMBOL lines for these symbols
>   snd_ac97_restore_status  snd_ac97_restore_iec958
> or is something more needed?

That's not the problem, since function and definition are in the same 
module.

You didn't send your .config, but looking at the code it seems 
CONFIG_PM=n was the culprit.

As a workaround, it should work after enabling the following option:
  Power management options (ACPI, APM)
    Power Management support

This is only a workaround, I've Cc'ed the ALSA maintainers for a real 
fix.

> Thanks.
>   --Mark Johnson <mailto:Mark_H_Johnson@Raytheon.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

