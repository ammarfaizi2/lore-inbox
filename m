Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVAGOyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVAGOyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVAGOyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:54:54 -0500
Received: from lax-gate4.raytheon.com ([199.46.200.233]:4456 "EHLO
	lax-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261445AbVAGOyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:54:07 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Takashi Iwai <tiwai@suse.de>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org,
       Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>,
       perex@suse.cz
From: Mark_H_Johnson@Raytheon.com
Subject: Re: [Alsa-devel] Re: 2.6.10-mm1: ALSA ac97 compile error with	CONFIG_PM=n
Date: Fri, 7 Jan 2005 08:41:51 -0600
Message-ID: <OF54D6A36A.84E8AEAC-ON86256F82.0050BC7F-86256F82.0050BCA9@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/07/2005 08:42:00 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And if you want to find out who is using it then try fuser /dev/dsp,
> fuser /dev/snd/*, or lsof.

Hmm. I figured out which application is "getting in my way" but am not
quite sure why I have a problem opening the audio / what I should do
about it.

On my system...

# fuser /dev/snd/* /dev/dsp
/dev/snd/pcmC0D0p:    2972  2972m
# ps -fe | grep 2972
u21305    2972  2936  0 10:15 ?        00:00:02 artsd -F 10 -S 4096 -a alsa
-s 60 -m artsmessage -c drkonqi -l 3 -f
root      4915  3407  0 11:08 pts/7    00:00:00 grep 2972
# fuser /dev/snd/* /dev/dsp
[I caused a console beep here using backspace]
# fuser /dev/snd/* /dev/dsp
/dev/snd/pcmC0D0p:    2972  2972m

OK, so artsd wakes up on some trigger and then waits around a while
expecting to get some more audio to process. I see it is a user of
/dev/snd/pcmC0D0p but not a user of /dev/dsp. Yet when I attempt to
open /dev/dsp, I get an error.

When I successfully run latencytest (and open /dev/dsp) I see...

# fuser /dev/snd/* /dev/dsp
/dev/dsp:             9156

which is the pid of latencytest.

Can someone please explain the relationship between these devices
and why access to one of these devices prevents access to another?
This is certainly confusing to me.

Thanks.
  --Mark

