Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVLTVYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVLTVYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVLTVYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:24:09 -0500
Received: from gate.perex.cz ([85.132.177.35]:60562 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932122AbVLTVYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:24:07 -0500
Date: Tue, 20 Dec 2005 22:24:05 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103-a.perex-int.cz
To: Adrian Bunk <bunk@stusta.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] [RFC: 2.6 patch] Makefile: sound/ must come before
 drivers/
In-Reply-To: <20051220211359.GA5359@stusta.de>
Message-ID: <Pine.LNX.4.61.0512202220040.12853@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de>
 <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org> <43A86DCD.8010400@superbug.co.uk>
 <20051220211359.GA5359@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Adrian Bunk wrote:

> On Tue, Dec 20, 2005 at 08:47:09PM +0000, James Courtier-Dutton wrote:
> > Linus Torvalds wrote:
> > >
> > >On Tue, 20 Dec 2005, Adrian Bunk wrote:
> > >
> > >>But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no 
> > >>longer working.
> > >
> > >
> > >Ahh. I assume it's the sequencer init etc that is missing.
> > >
> > >Maybe we'll just have to do the late_init thing for at least the 2.6.15 
> > >timeframe.
> > >
> > >		Linus
> > >
> > 
> > But that's not really a useable fix. The problem is with almost all ALSA 
> > sound cards.
> 
> No, inside sound/ it's working due to the link order.
> 
> Thinking about this, what about the patch below?
>
> -drivers-y	:= drivers/ sound/
> +drivers-y	:= sound/ drivers/

It might break the "video" subsystem, because we have a lowlevel code 
for radio tuners in our code.

Basically, everything from /sound/core tree should be initialized at first 
before any lowlevel driver is loaded, except /sound/core/oss and
/sound/core/seq/oss subtrees.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
