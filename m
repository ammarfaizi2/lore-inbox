Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTFDPs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTFDPs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:48:57 -0400
Received: from grebe.mail.pas.earthlink.net ([207.217.120.46]:44434 "EHLO
	grebe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263503AbTFDPsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:48:43 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Galbraith <efault@gmx.de>, Arjan van de Ven <arjanv@redhat.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306041711410.13441-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0306041711410.13441-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1054742447.1820.46.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jun 2003 12:00:47 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.5, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 11:12, Ingo Molnar wrote:
> a question - which process in your system is responsible for the sound
> output?

In this simple test scenario it is wine itself (the actual process which
I am renicing).  I verified this with a 'lsof' while sound was playing.

This is why I keep saying that it almost seems as if it is the kernel
itself that is being starved (perhaps starved is the wrong word here).

If the environment is a simple as:

pluginserver-->/dev/dsp-->hardware

and renicing the pluginserver process to a lower priority is what makes
the sound stop skipping, then what else can it be?

I am using ALSA with OSS emulation, but I did try the OSS driver as
well.  My primary testing machine is a laptop with a Maestro3 sound card
which is known to be buggy sometimes (although I've actually had very
good success with it, especially with ALSA), but I have reproduced this
issue with my desktop at home which is an Athlon 950Mhz with a
Soundblaster live, although it is less noticable.

It's been suggested I may be tripping some type of hardware quirk here,
perhaps a shared interrupt issue, or simple PCI bandwidth or latency.  I
suppose this is possible and I'm looking at these kinds of tweaks, but I
think they are unlikely as why would renicing a userspace process make
this type of problem go away?

Later,
Tom

