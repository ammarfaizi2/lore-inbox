Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVKGPgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVKGPgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 10:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVKGPgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 10:36:50 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10698 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964845AbVKGPgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 10:36:49 -0500
Subject: Re: + v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch
	added to -mm tree
From: Lee Revell <rlrevell@joe-job.com>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nshmyrev@yandex.ru, v4l@cerqueira.org
In-Reply-To: <1131344803.10094.8.camel@localhost>
References: <200511060743.jA67hpZa018948@shell0.pdx.osdl.net>
	 <20051106001249.48d3ade0.akpm@osdl.org> <1131301995.13599.5.camel@mindpipe>
	 <1131344803.10094.8.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 07 Nov 2005 10:33:35 -0500
Message-Id: <1131377615.8383.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 04:26 -0200, Mauro Carvalho Chehab wrote:
> Lee,
> 
> Em Dom, 2005-11-06 às 13:33 -0500, Lee Revell escreveu:
> > On Sun, 2005-11-06 at 00:12 -0800, Andrew Morton wrote:
> > > Well that didn't work.  The problem is that
> > > drivers/media/video/saa7134/saa7134-alsa.c doesn't appear to be wired
> > > up into the build system - it simply doesn't get compiled.
> > > 
> > > Please send a fix against next -mm? 
> > 
> > Also please send all ALSA related patches to
> > alsa-devel@lists.sourceforge.net for review.
> 
> 	I'm sending you enclosed saa7134-alsa patch. To make easier to
> understand, I've merged all stuff. This is highly dependent of the other
> saa7134 parts, since PCI stuff are common to both video and audio
> funcion on this device.
> 	This is meant to replace saa7134-oss (after more tests) that,
> currently, is part of saa7134 module.

OK, a brief review:

 - Why couldn't you use ALSA's DMA API?

 - The DMA must be stopped and started in the trigger callback, not the
prepare callback.

 - If this device lacks a volume control alsa-lib can emulate it in
software, just create a proper /usr/share/alsa/cards/your_card.conf
file.

 - By ALSA convention the acceptable formats, sample rates, etc should
be directly defined in the snd_pcm_hardware_t structure.

 - dev->oss needs to go.

Lee

