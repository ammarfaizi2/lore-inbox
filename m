Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbVJDSLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbVJDSLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVJDSLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:11:34 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:42053 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964896AbVJDSLd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:11:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LKJAJe+ClLt5VfNgme+e6oACwCBcb0bIK2mVQ24g/67Up2X1+LxqpA6j2uX2MrKUJkvcaprxYjEvjFlunbaBp8yq2q0VsvuzM14E/Rb08q04xuy9+pmkU4+r5GZijKydtAvR3woM3UQP8wdSSac6T1qwFiq/VoPbTq9xsTmP23E=
Message-ID: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
Date: Tue, 4 Oct 2005 11:11:32 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt2
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
In-Reply-To: <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Mark Knecht <markknecht@gmail.com> wrote:
> On 10/4/05, Ingo Molnar <mingo@elte.hu> wrote:
<SNIP>
> >
> > ugh. uploaded -rt6.
> >
> >         Ingo
>
> Hi Ingo,
>    OK, I'm up and running 2.6.14-rc3-rt7. I see no run-time problems yet...
<SNIP>

I have now had one burst of xruns. As best I can tell I was
downloading some video files for mplayer to look at, or possibly
running one of them. I see this in qjackctl:

configuring for 44100Hz, period = 128 frames, buffer = 2 periods
nperiods = 2 for capture
nperiods = 2 for playback
09:59:12.079 Server configuration saved to "/home/mark/.jackdrc".
09:59:12.079 Statistics reset.
09:59:12.224 Client activated.
09:59:12.226 Audio connection change.
09:59:12.242 Audio connection graph change.
09:59:17.819 Audio connection graph change.
09:59:17.927 Audio connection change.
09:59:19.985 Audio connection graph change.
10:09:22.377 XRUN callback (1).
**** alsa_pcm: xrun of at least 0.336 msecs
10:09:28.450 XRUN callback (2).
**** alsa_pcm: xrun of at least 0.306 msecs
10:11:33.241 XRUN callback (3).
**** alsa_pcm: xrun of at least 4.058 msecs
subgraph starting at qjackctl-8560 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
10:12:02.490 XRUN callback (4).
**** alsa_pcm: xrun of at least 3.135 msecs
subgraph starting at qjackctl-8560 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
10:16:22.910 XRUN callback (5).
**** alsa_pcm: xrun of at least 1.848 msecs

There have been no more xruns since that burst about an hour ago.

Looking in the logs there is a suspicious 1394 access problem:

Oct  4 10:00:40 lightning ieee1394.agent[8630]: ... no drivers for
IEEE1394 product 0x/0x/0x
Oct  4 10:04:32 lightning kjournald starting.  Commit interval 5 seconds
Oct  4 10:04:32 lightning EXT3 FS on sdc2, internal journal
Oct  4 10:04:32 lightning EXT3-fs: mounted filesystem with ordered data mode.
Oct  4 10:09:05 lightning attempt to access beyond end of device
Oct  4 10:09:05 lightning sdb1: rw=0, want=5621502224, limit=117210177
Oct  4 10:09:05 lightning attempt to access beyond end of device
Oct  4 10:09:05 lightning sdb1: rw=0, want=8263631504, limit=117210177
Oct  4 10:09:05 lightning attempt to access beyond end of device
Oct  4 10:09:05 lightning sdb1: rw=0, want=27135269176, limit=117210177
Oct  4 10:09:05 lightning attempt to access beyond end of device
Oct  4 10:09:05 lightning sdb1: rw=0, want=25260813976, limit=117210177
Oct  4 10:09:05 lightning attempt to access beyond end of device
Oct  4 10:09:05 lightning sdb1: rw=0, want=5621502224, limit=117210177
Oct  4 10:10:02 lightning cron[8737]: (root) CMD (test -x
/usr/sbin/run-crons && /usr/sbin/run-crons )
Oct  4 10:20:01 lightning cron[8762]: (root) CMD (test -x
/usr/sbin/run-crons && /usr/sbin/run-crons )
Oct  4 10:30:01 lightning cron[8800]: (root) CMD (test -x
/usr/sbin/run-crons && /usr/sbin/run-crons )
Oct  4 10:40:01 lightning cron[8847]: (root) CMD (test -x
/usr/sbin/run-crons && /usr/sbin/run-crons )


/dev/sdb1 in this case holds a 50GB ogg-based music library. It's been
streaming since I brought the kernel up.

1394 problems????

Thanks,
Mark
