Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269541AbRHLXQI>; Sun, 12 Aug 2001 19:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269572AbRHLXP6>; Sun, 12 Aug 2001 19:15:58 -0400
Received: from leng.mclure.org ([64.81.48.142]:28687 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S269541AbRHLXPk>; Sun, 12 Aug 2001 19:15:40 -0400
Date: Sun, 12 Aug 2001 16:15:44 -0700
From: Manuel McLure <manuel@mclure.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Message-ID: <20010812161544.A947@ulthar.internal.mclure.org>
In-Reply-To: <20010812155520.A935@ulthar.internal.mclure.org> <Pine.LNX.4.33.0108121557060.2102-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0108121557060.2102-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Aug 12, 2001 at 15:59:21 -0700
X-Mailer: Balsa 1.2.pre1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.08.12 15:59 Linus Torvalds wrote:

> Mind trying an alternate approach: remove the "if (!woinst)" thing, and
> instead move the line that initializes the tasklets down two lines
> (there's two places, they look something like
> 
>                 tasklet_init(&wiinst->timer.tasklet, emu10k1_wavein_bh, 
> (unsigned long) wave_dev);
>                 wave_dev->wiinst = wiinst;
>                 emu10k1_wavein_setformat(wave_dev, &wiinst->format);
> 
> and they _should_ do the "tasklet_init()" _after_ the other
> initializations, ie move that line down a bit, like so:
> 
>                 wave_dev->wiinst = wiinst;
>                 emu10k1_wavein_setformat(wave_dev, &wiinst->format);
>                 tasklet_init(&wiinst->timer.tasklet, emu10k1_wavein_bh,
> (unsigned long) wave_dev);
> 
> Does that also fix it?
> 
> And sure, I realize that you want to run it for a while..

Done - I'll post any Oops that might show up. No news will good news :-)

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft
