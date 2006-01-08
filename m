Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161193AbWAHWLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWAHWLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbWAHWLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:11:04 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:57455 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1161193AbWAHWLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:11:01 -0500
Date: Mon, 9 Jan 2006 00:08:24 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, linux-audio-dev@music.columbia.edu
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <20060108071953.17892.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.61.0601082324040.31407@zeus.compusonic.fi>
References: <20060108071953.17892.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 linux@horizon.com wrote:

> Only if you need 10 ms latencies 100.000...0% of the time.  Which isn't
> always the case.
If you are doing audio with 10 ms _buffers_ then you will need smaller 
than 10 ms latencies from the beginning to the end. This is always the 
case.

> The rest of the time, you can do very well by providing a way to supply
> "tentative" data in advance of need, but cancel it and replace it with
> better data when something happens... something explodes in a game, or
> a new person speaks up in an audio conferencing application, or a new MIDI
> event arrives.
You can't predict the future output if you are doing processing on live 
input and playing back the result immediately. In this kind of 
applications you are limited to the latencies the plattform can 
guarantee. There is nothing the audio subsystem can do to make things 
work better so for this reason any time spent on developing such features 
is complete waste of time.

Right. If you can predict what the output could be then you don't need to 
limit the the buffer to 10 ms. You can use much longer buffer and rewrite 
parts of it. 

In reality you can use surprisingly large buffers in applications like 
games and nobody will notice any lags. This is because human brain 
automatically masks them. As you know speed of sound is about 340 m/s. 
Largish delay of 0.1s=100ms equals to distance of 34 meters. This makes 
the distance to the explosion to sound like they occurred 34 meters behind
the actual place. 10 ms equals to just 3.4 meters.

Also in reality getting 10 ms "one way" latencies don't require any 
special tricking with DMA from user land or things like that. Simply using 
short enough buffer is enough. If the game itself is properly designed 
then 10-20ms will work out of box (at least with OSS). This approach has 
been used since the old sasteroids game 10-12 years ago and it's still 
used by the SDL library.

Using sophisticated algorithms that "cannot fail" may be sexy but it's 
pointless because nothing fails anyway.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
