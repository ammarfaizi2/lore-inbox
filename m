Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWGBGzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWGBGzc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 02:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWGBGzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 02:55:32 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:23045 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750879AbWGBGzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 02:55:31 -0400
Message-ID: <44A76DDF.4020307@superbug.co.uk>
Date: Sun, 02 Jul 2006 07:55:27 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.4 (X11/20060609)
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: Olivier Galibert <galibert@pobox.com>, Lee Revell <rlrevell@joe-job.com>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       perex@suse.cz, Olaf Hering <olh@suse.de>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
References: <20060629192128.GE19712@stusta.de> <44A54D8E.3000002@superbug.co.uk> <20060630163114.GA12874@dspnet.fr.eu.org> <1151702966.32444.57.camel@mindpipe> <20060701073133.GA99126@dspnet.fr.eu.org> <44A6279C.3000100@superbug.co.uk>
In-Reply-To: <44A6279C.3000100@superbug.co.uk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> "Never" probably only means terribly long. :-)
> 

There is in fact one implementation method that we would like to
implement, but currently we don't know how, so some input from people
from this list might be helpful.

There is an ALSA tool called aoss.
What this does is hook any calls the application does to
fopen/fwrite/fread/fclose/open/close/read/write/ioctl etc. and detects
any calls to open /dev/dsp and /dev/mixer and diverts them to use
alsa-lib. This therefore manages to divert the applications use of
/dev/dsp before it even reaches the kernel. This therefore gives the
application full use of all the alsa-lib features. So, for example,
4-channel output would work in this mode. But, and this is the bit we
need help with, if the application uses dlopen to dynamically open a
plugin, the plugin's calls to open/close/read/write etc. are not hooked,
so the application fails.

Is there any way to also hook the IO calls of dlopened plugins?

James
