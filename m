Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTIJPVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264962AbTIJPVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:21:12 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:64945
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264956AbTIJPVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:21:11 -0400
From: Con Kolivas <kernel@kolivas.org>
To: root@chaos.analogic.com, Takashi Iwai <tiwai@suse.de>
Subject: Re: Audio skipping with alsa
Date: Thu, 11 Sep 2003 01:28:35 +1000
User-Agent: KMail/1.5.3
Cc: Jaroslav Kysela <perex@suse.cz>, Russ Garrett <rg@tcslon.com>,
       linux-kernel@vger.kernel.org
References: <1063116861.852.50.camel@russell> <s5hhe3kvjtc.wl@alsa2.suse.de> <Pine.LNX.4.53.0309101037120.12986@chaos>
In-Reply-To: <Pine.LNX.4.53.0309101037120.12986@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309110128.35543.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 00:45, Richard B. Johnson wrote:
> I don't see the driver in linux-2.4.22/drivers/sound, so I can't
> look at it directly, but normally all you have to do is keep
> a FIFO full (not empty) during play. There should not be any
> scheduling issues with sound chips although I am seeing too
> much of that lately. Maybe  somebody should look at the driver
> before the scheduler is blamed. Perhaps the driver is not
> designed properly so it assumes the user-mode code can do
> something it can't possibly be expected to do with any
> reliability. For instance, perhaps it's the user-mode's
> responsibility to keep a FIFO full? And, you can never
> guarantee that.

That may be the case, but there is a very clear problem with the vanilla 
scheduler that can cause too low priority for audio apps for up to 25 seconds 
after starting a new thread (eg new song). In turn they will skip madly when 
any higher priority task uses a burst of cpu and repeatedly preempts it (X, 
mozilla, the neighbour's dog...). Only the largest buffer audio cards wont 
skip with the vanilla scheduler, and _no_ amount of single cpu capability 
today is enough to avoid the scheduler based starvation. So while it never 
hurts to keep an eye on driver performance, the scheduler itself _must_ be 
fixed to prevent this happening.

Con

