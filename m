Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWADBJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWADBJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWADBJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:09:44 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:59081 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S965089AbWADBJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:09:43 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
To: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org, zaitcev@yahoo.com,
       zwane@commfireservices.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       jgarzik@pobox.com, parisc-linux@lists.parisc-linux.org,
       kyle@parisc-linux.org, zab@zabbo.net, linux-sound@vger.kernel.org,
       sailer@ife.ee.ethz.ch, James@superbug.demon.co.uk,
       alsa-devel@alsa-project.org, perex@suse.cz, Andi Kleen <ak@suse.de>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Olivier Galibert <galibert@pobox.com>, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
References: <20050726150837.GT3160@stusta.de>
	 <200601031629.21765.s0348365@sms.ed.ac.uk>
	 <20060103170316.GA12249@dspnet.fr.eu.org>
	 <200601031716.13409.s0348365@sms.ed.ac.uk>
	 <20060103192449.GA26030@dspnet.fr.eu.org> <20060103193736.GG3831@stusta.de>
	 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-2
Date: Wed, 04 Jan 2006 01:33:27 +0100
Message-Id: <1136334807.4106.51.camel@unreal>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-06.tornado.cablecom.ch 32701; Body=20
	Fuz1=20 Fuz2=20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 00:10 +0100, Tomasz K³oczko wrote:

> 1) ALSA API forces not use devices files and many things on sound managing
>    level are handled on user space library. This dissallow civilized

Huh? Why's that? Actually, I welcome that ALSA does quite a lot in
userspace, it could even do more. The whole format conversion and
sampling rate conversion has no business in the kernel, IMO.

> 2) ALSA API is to complicated: most applications opens single sound
>    stream.

Agreed. It took me quite some time to get my app ported, even though I
had lots of documentation and sample code...


> 3) ALSA kernel architecture is to complicated. This main reason why
>    configuring sound on Linux is SO COMPLICATED. From my system:

Also agreed. It is IMO the hardest kernel subsystem to read. Instead of
having control passing from VFS to driver and the driver calling core
library routines, control passes from VFS to alsa core, which is calling
lots of callbacks. It's a coding style that should be avoided, it makes
reading and understanding code extremely hard.

> 4) ALSA mixing model is UNSECURE by design because all mixing sound
>    streams (for example with diffrent sampling rates) are performed
>    in user space.

Why is that? Even with kernel space mixing, any application having
access to the soundcard can fuck up the output, so I don't see why the
user space solution is less secure than a kernel solution.

Tom


