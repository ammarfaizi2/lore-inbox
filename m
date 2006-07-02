Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWGBP1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWGBP1x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 11:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWGBP1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 11:27:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48339 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932322AbWGBP1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 11:27:52 -0400
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, Olivier Galibert <galibert@pobox.com>,
       perex@suse.cz, Olaf Hering <olh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.61.0607021153220.5276@yvahk01.tjqt.qr>
References: <20060629192128.GE19712@stusta.de>
	 <44A54D8E.3000002@superbug.co.uk> <20060630163114.GA12874@dspnet.fr.eu.org>
	 <1151702966.32444.57.camel@mindpipe>
	 <20060701073133.GA99126@dspnet.fr.eu.org> <44A6279C.3000100@superbug.co.uk>
	 <44A76DDF.4020307@superbug.co.uk>
	 <Pine.LNX.4.61.0607021153220.5276@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 11:28:12 -0400
Message-Id: <1151854092.12026.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 11:58 +0200, Jan Engelhardt wrote:
> >
> >There is an ALSA tool called aoss.
> >What this does is hook any calls the application does to
> >fopen/fwrite/fread/fclose/open/close/read/write/ioctl etc. and detects
> >any calls to open /dev/dsp and /dev/mixer and diverts them to use
> >alsa-lib. This therefore manages to divert the applications use of
> >/dev/dsp before it even reaches the kernel. This therefore gives the
> >application full use of all the alsa-lib features. So, for example,
> >4-channel output would work in this mode. But, and this is the bit we
> >need help with, if the application uses dlopen to dynamically open a
> >plugin, the plugin's calls to open/close/read/write etc. are not hooked,
> >so the application fails.
> >
> >Is there any way to also hook the IO calls of dlopened plugins?
> >
> Well you could patch the affected plugin's .dynstr table so that it should at
> best try to call a function that has not yet been defined somewhere else (like
> open); IOW, you change the .dynstr entry from 'open' to say 'my_open', and
> regularly include libmy.so through e.g. LD_PRELOAD.
> 
> Of course the MD5 won't match afterwards, but I think the plugin should execute
> as usual afterwards, since .dynstr is something no app should rely on.

Is this likely to work with an app like Skype that takes extensive steps
to thwart reverse engineers?

(Of course a Skype beta with ALSA support was just released, so it's
much less important now)

Lee

