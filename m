Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWAHHUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWAHHUE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWAHHUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:20:04 -0500
Received: from science.horizon.com ([192.35.100.1]:2124 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932343AbWAHHUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:20:03 -0500
Date: 8 Jan 2006 02:19:53 -0500
Message-ID: <20060108071953.17892.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] ALSA userspace API complexity
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hannu@opensound.com wrote:
> To get (say) 10 ms latencies you have to tell the sound subsystem 
> to allocate to buffer that is smaller than 10 ms. This in turn means that 
> the application must be able to run it's processing loop within less than 10 
> ms with 100.000...0% confidence. This is true regardless of how advanced 
> or primitive the audio subsystem (API) is.

Only if you need 10 ms latencies 100.000...0% of the time.  Which isn't
always the case.

The rest of the time, you can do very well by providing a way to supply
"tentative" data in advance of need, but cancel it and replace it with
better data when something happens... something explodes in a game, or
a new person speaks up in an audio conferencing application, or a new MIDI
event arrives.


Real-time DSP is a different matter, but the point I'm trying to make
is that there is a non-zero set of applications for which additional
API festures allow low average latency and guaranteed lack of total
dropouts.

Simply writing to /dev/dsp doesn't give you that, but e.g. DMA out of
user-space buffers does.
