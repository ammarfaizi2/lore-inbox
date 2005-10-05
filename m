Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbVJEXP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbVJEXP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbVJEXP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:15:59 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:22814 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030428AbVJEXP6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:15:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kd2+h5Q4hqRuxpXrS5m5RIbSZhEdUrWxbpsr/omnYTYIzXXbdjEhYH5Bz/8HtXsbT2U/9+6ahI1BoDlVPpphrMGoQXnhD3AmVcJFmTE+QZdMqu1+mTAiu1CSQo37bytY2WPn5Z+dQW8fykUTSpxQnga4gGHVQ2QH36s3IVUijMs=
Message-ID: <5bdc1c8b0510051615hfd77ba8pab7ee07bde13ffd4@mail.gmail.com>
Date: Wed, 5 Oct 2005 16:15:57 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc3-rt9 - a few xruns misses
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   This is nothing particularily new. I'm just presenting it to
represent what I'm seeign and get some guidance about how to find out
what's going on.

   This is my AMD64 machine. It was VERY lightly loaded. Just Gnome
and Aqualung which was running using Jack. Around 1PM I went to the
other room to watch a DVD and returned around 3PM. The only thing I
can think of that would cause an xrun around 1:23 or 1:34 would be
xscreensaver, or possibly soem updatedb operation that might have
started.

   When I returned at 3PM I started copying some audio files across
the network to a ogg file server. This was about 400MB of data. The
copies worked fine but during the copies I got a few more xruns:

12:08:46.070 Audio connection change.
12:08:48.119 Audio connection graph change.
subgraph starting at qjackctl-8905 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
12:10:27.191 XRUN callback (1).
**** alsa_pcm: xrun of at least 3.553 msecs
13:23:38.218 XRUN callback (2).
**** alsa_pcm: xrun of at least 2.263 msecs
subgraph starting at qjackctl-8905 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
13:34:39.647 XRUN callback (3).
**** alsa_pcm: xrun of at least 6.233 msecs
15:15:46.072 XRUN callback (4).
**** alsa_pcm: xrun of at least 2.339 msecs
15:20:08.262 XRUN callback (5).
**** alsa_pcm: xrun of at least 0.098 msecs
subgraph starting at qjackctl-8905 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
15:20:40.459 XRUN callback (6).
**** alsa_pcm: xrun of at least 5.159 msecs
15:36:21.595 XRUN callback (7).
**** alsa_pcm: xrun of at least 0.462 msecs
16:05:41.308 Audio connection graph change.
16:05:41.430 Audio connection graph change.

After the copies stopped the machine was idle until I wrote this
email. I'm also running MythTV on here right now. No problems.

Just a few xruns I'd like to better understand and get rid of over time.

lightning ~ # lsmod
Module                  Size  Used by
realtime               13832  0
snd_seq_midi           11456  0
snd_pcm_oss            54304  1
snd_mixer_oss          20480  2 snd_pcm_oss
snd_seq_oss            37120  0
snd_seq_midi_event     11392  2 snd_seq_midi,snd_seq_oss
snd_seq                58848  8 snd_seq_midi,snd_seq_oss,snd_seq_midi_event
sbp2                   27652  3
ohci1394               35532  0
ieee1394               99888  2 sbp2,ohci1394
snd_hdsp               54724  4
snd_rawmidi            27680  2 snd_seq_midi,snd_hdsp
snd_seq_device         10892  3 snd_seq_midi,snd_seq_oss,snd_rawmidi
snd_hwdep              12960  1 snd_hdsp
snd_intel8x0           37408  3
snd_ac97_codec        107224  1 snd_intel8x0
snd_ac97_bus            7168  1 snd_ac97_codec
snd_pcm                92296  6
snd_pcm_oss,snd_hdsp,snd_intel8x0,snd_ac97_codecsnd_timer             
26120  2 snd_seq,snd_pcm
snd                    55752  21
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_hdsp,snd_rawmidi,snd_seq_device,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc         13328  3 snd_hdsp,snd_intel8x0,snd_pcm
lightning ~ #

lightning ~ # uname -a
Linux lightning 2.6.14-rc3-rt9 #1 SMP PREEMPT Wed Oct 5 09:16:16 PDT
2005 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
lightning ~ #

Thanks,
Mark
