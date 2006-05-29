Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWE2Oun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWE2Oun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 10:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWE2Oun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 10:50:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55696 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750882AbWE2Oun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 10:50:43 -0400
Date: Mon, 29 May 2006 10:50:31 -0400
From: Dave Jones <davej@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17rc emu10k1 regression.
Message-ID: <20060529145031.GA32274@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060528164015.GA13499@redhat.com> <s5hejydtbc3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hejydtbc3.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 11:43:56AM +0200, Takashi Iwai wrote:

 > > modprobe.conf has ..
 > > alias snd-card-0 snd-emu10k1
 > > options snd-card-0 index=0
 > > options snd-emu10k1 index=0
 > > remove snd-emu10k1 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; }; /sbin/modprobe -r --ignore-remove snd-emu10k1
 > > 
 > > What changed ?
 > 
 > Nothing from ALSA side.  Maybe the module loading mechanism (or slot
 > order) was changed on your system.
 > 
 > The scenario is:
 > 
 > intel8x0 driver is first loaded on the first empty slot (index=0)
 > before snd-emu10k1.  Since you set index=0 module option for
 > snd-emu10k1, it tried to load on the same slot but failed.
 > 
 > A workaround is to set index=1 option for snd-intel8x0 in addition,
 > for using emu10k1 as the primary card.

The modprobe.conf also had an index=1 entry already for the intel driver.

		Dave
-- 
http://www.codemonkey.org.uk
