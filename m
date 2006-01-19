Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWASWMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWASWMI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWASWMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:12:08 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41905 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422657AbWASWMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:12:07 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly
	different	approach
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz
In-Reply-To: <1137697269.32195.14.camel@mindpipe>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe> <20060119182859.GW19398@stusta.de>
	 <1137696885.32195.12.camel@mindpipe>  <s5hk6cw9h07.wl%tiwai@suse.de>
	 <1137697269.32195.14.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 22:09:33 +0000
Message-Id: <1137708573.8471.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 14:01 -0500, Lee Revell wrote:
> > > Hmm.  From sound/oss/kahlua.c:
> > > 
> > > /*
> > >  *      Initialisation code for Cyrix/NatSemi VSA1 softaudio
> > >  *
> > >  *      (C) Copyright 2003 Red Hat Inc <alan@redhat.com>
> > >  *
> > > 
> > > Why was a new OSS driver written and accepted at such a late date, when
> > > OSS was already deprecated?
> > 
> > You'll find out that it must be pretty easy to write kahlua driver for
> > ALSA, too, if you look at kahlua.c.  Just need a hardware to certify
> > if this is really demanded...
> 
> Yes, it looks simple enough to write a driver without the hardware, as
> long as someone volunteers to test it...

Most of the Kahlua logic is in the SB driver. It was a wrapper added
later to make autoconfiguration simple for end users. CS55x0 (VSA1
variants) are generic sound blaster 16 emulation via SMI traps. There
are certain things you must not do

1.	Use a 64K or 128K in 16bit ring buffer
2.	Disable/Enable DMA on the sound channel while audio is running

#1 causes the box to hang dead (firmware emulation bug)
#2 mistakenly flushes the FIFOs so breaks up the audio

Otherwise its SB16 compatible.


