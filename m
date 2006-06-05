Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750802AbWFEJ7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWFEJ7u (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWFEJ7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:59:50 -0400
Received: from sc-outsmtp1.homechoice.co.uk ([81.1.65.35]:62477 "HELO
	sc-outsmtp1.homechoice.co.uk") by vger.kernel.org with SMTP
	id S1750802AbWFEJ7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:59:49 -0400
Subject: Re: [PATCH] Add support for Yamaha AICA sound on SEGA Dreamcast
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sh <linuxsh-dev@lists.sourceforge.net>,
        Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <20060605095318.GA30339@linux-sh.org>
References: <1149201071.9032.13.camel@localhost.localdomain>
	 <20060605095318.GA30339@linux-sh.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 10:59:32 +0100
Message-Id: <1149501573.6144.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 12:53 +0300, Paul Mundt wrote:

> > +static void spu_init(void)
> 
> This can probably be inlined..
> 
> > +/* aica_chn_start - write to spu to start playback */
> > +static void aica_chn_start(void)
> > +{
> > +	spu_write_wait();
> > +	writel(AICA_CMD_KICK | AICA_CMD_START,
> > +	       (uint32_t *) AICA_CONTROL_POINT);
> > +}
> > +
> > +/* aica_chn_halt - write to spu to halt playback */
> > +static void aica_chn_halt(void)
> > +{
> > +	spu_write_wait();
> > +	writel(AICA_CMD_KICK | AICA_CMD_STOP,
> > +	       (uint32_t *) AICA_CONTROL_POINT);
> > +}
> > +
> These too.
> 

No point in inlining these as they all wait on a FIFO to clear - ie the
benefit of inling will be tiny. I notice a stray inline still lurking
from the code that can go...

