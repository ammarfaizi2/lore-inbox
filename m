Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbTHGTGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269661AbTHGTGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:06:18 -0400
Received: from maile.telia.com ([194.22.190.16]:41174 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id S269321AbTHGTGR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:06:17 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6: More about interactivity
Date: Thu, 7 Aug 2003 21:08:45 +0200
User-Agent: KMail/1.5.9
References: <1060280139.1406.17.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1060280139.1406.17.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308072108.45723.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 August 2003 20.15, Felipe Alfaro Solana wrote:
> Just wanted to throw a few thoughts I have about the current scheduler
> and my experiences with it (well, with my specific workloads and
> applications on my little 700 Mhz PIII laptop).
>
> I feel that 2.6.0-test2-mm5 is not as smooth as 2.6.0-test2-mm2 (O10int)
> was. I am experiencing sound skips, but this time I'm not using XMMS,
> but Juk, a KDE player which uses the aRTS sound daemon, which in turn, I
> assume it uses the OSS API.

Arts uses whatever you have - i think ALSA is preferred.

>
> With X reniced at +0, the system feels not as smooth as 2.6.0-test2-mm2,
> but at least there are no sound skips. However, to gain on smoothness, I
> have chosen to renice X to -20. Renicing X to -20 makes Juk skip like
> crazy simply by dragging a window over the screen. Also, with X at -20,
> opening a long Bookmarks Konqueror menu also causes sound skips (even
> with XMMS). By now, I'm sticking at +0, but I really miss those times
> when I was running O10int and the desktop was as smooth as silk.

Wait a minute!

Arts (I think JuK only tells Arts what to play) is a realtime task - if it 
does not meet its deadline you get drop outs. X is not a realtime task 
(unless you display video using it - is X even involved in video/3D?).

But you run X at a higher priority than Arts!? Don't you? You have told the
scheduler that X is more important than Arts - and you are surpriced that
you get dropouts?

Arts should really run as SCHED_FIFO or SCHED_RR but that opens another
can of worms - audio plugins can busy lock the computer... We need 
SCHED_SOFTRR now!

But you can try to prioritize arts higher than X (arts at -20, X at -15).
Or set suid root on artswrapper to get SCHED_FIFO, and then enable realtime 
scheduling in configuration.

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
