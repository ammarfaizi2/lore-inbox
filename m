Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWGBJ72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWGBJ72 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 05:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWGBJ72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 05:59:28 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:61402 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932239AbWGBJ71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 05:59:27 -0400
Date: Sun, 2 Jul 2006 11:58:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: James Courtier-Dutton <James@superbug.co.uk>
cc: Olivier Galibert <galibert@pobox.com>, Lee Revell <rlrevell@joe-job.com>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       perex@suse.cz, Olaf Hering <olh@suse.de>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
In-Reply-To: <44A76DDF.4020307@superbug.co.uk>
Message-ID: <Pine.LNX.4.61.0607021153220.5276@yvahk01.tjqt.qr>
References: <20060629192128.GE19712@stusta.de> <44A54D8E.3000002@superbug.co.uk>
 <20060630163114.GA12874@dspnet.fr.eu.org> <1151702966.32444.57.camel@mindpipe>
 <20060701073133.GA99126@dspnet.fr.eu.org> <44A6279C.3000100@superbug.co.uk>
 <44A76DDF.4020307@superbug.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>There is an ALSA tool called aoss.
>What this does is hook any calls the application does to
>fopen/fwrite/fread/fclose/open/close/read/write/ioctl etc. and detects
>any calls to open /dev/dsp and /dev/mixer and diverts them to use
>alsa-lib. This therefore manages to divert the applications use of
>/dev/dsp before it even reaches the kernel. This therefore gives the
>application full use of all the alsa-lib features. So, for example,
>4-channel output would work in this mode. But, and this is the bit we
>need help with, if the application uses dlopen to dynamically open a
>plugin, the plugin's calls to open/close/read/write etc. are not hooked,
>so the application fails.
>
>Is there any way to also hook the IO calls of dlopened plugins?
>
Well you could patch the affected plugin's .dynstr table so that it should at
best try to call a function that has not yet been defined somewhere else (like
open); IOW, you change the .dynstr entry from 'open' to say 'my_open', and
regularly include libmy.so through e.g. LD_PRELOAD.

Of course the MD5 won't match afterwards, but I think the plugin should execute
as usual afterwards, since .dynstr is something no app should rely on.


Jan Engelhardt
-- 
