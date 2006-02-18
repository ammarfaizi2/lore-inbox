Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWBRXVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWBRXVD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 18:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWBRXVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 18:21:01 -0500
Received: from [141.85.221.189] ([141.85.221.189]:65235 "EHLO ghrt.acasa.ro")
	by vger.kernel.org with ESMTP id S932279AbWBRXVA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 18:21:00 -0500
From: ghrt <ghrt@dial.kappa.ro>
Reply-To: ghrt@dial.kappa.ro
To: Pavel Machek <pavel@suse.cz>
Subject: Re: No sound from SB live!
Date: Sun, 19 Feb 2006 01:27:26 +0200
User-Agent: KMail/1.9
References: <20060218231419.GA3219@elf.ucw.cz>
In-Reply-To: <20060218231419.GA3219@elf.ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz, tiwai@suse.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602190127.27862.ghrt@dial.kappa.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pe data de Dum 19 Feb 2006 01:14, a-ţi scris:
> Hi!
>
> I have SB Live! here. I remember it worked long time ago. Now I
> can't get it to produce any sound :-(.
>
> root@hobit:~# cat /proc/asound/cards
>  0 [Live           ]: EMU10K1 - SBLive! Value [CT4830]
>                       SBLive! Value [CT4830] (rev.7,
> serial:0x80261102) at 0x3000, irq 20
>  1 [Bt878          ]: Bt87x - Brooktree Bt878
>                       Brooktree Bt878 at 0xd0001000, irq 17
>
> root@hobit:~# uname -a
> Linux hobit 2.6.16-rc4 #1 SMP PREEMPT Sat Feb 18 23:53:41 CET 2006
> i686 GNU/Linux
>
Same problem here some time ago. See below forwarded message.


Subject: Re: Fw: PROBLEM: SB Live! 5.1 (emu10k1, rev. 0a) doesn't work 
with 2.6.15
Date: Lun 13 Feb 2006 23:52
From: ghrt <ghrt@dial.kappa.ro>
To: Takashi Iwai <tiwai@suse.de>

Pe data de Lun 13 Feb 2006 17:08, a-ţi scris:
> At Mon, 13 Feb 2006 04:09:00 -0800,
>
> Andrew Morton wrote:
> > Begin forwarded message:
> >
> > Date: Sat, 14 Jan 2006 00:03:48 +0200
> > From: ghrt <ghrt@dial.kappa.ro>
> > To: linux-kernel@vger.kernel.org
> > Subject: PROBLEM: SB Live! 5.1 (emu10k1, rev. 0a) doesn't work
> > with 2.6.15
> >
> >
> > hello
> >
> > i've compiled vanilla 2.6.15 and my sound card doesn't work
> > anymore. i can see it in kmix (and adjust the volumes, too), it
> > appears in dmesg (at ALSA devices), xmms & mplayer doesn't say
> > anything about errors, but it doesn't make any sound.
> > the onboard soundcard, via8233, works well with the same 2.6.15.
> > sb live! works well with 2.6.14.2 and previous.
> > i'm using an updated Slackware.
> >
> > if you have any questions i'll answer.
>
> First check /proc/asound/cards to see whether the emu10k1 model is
> detected properly.  If '[Unknown]' is shown, your model is not
> listed in the whitelist.

Seems ok (see below). But i came to the conclusion that it might be
KMix as well, because alsa-mixer (console) works fine.
Maybe if the name of the output (or input) device (now both are
"Wave") is changed to be different from the other names the problem
will dissapear. I didn't have time to do this (i am not a programmer
also).
When i unmute in KMix input->Wave it works (sounds) perfectly. The
problem is that KMix is wrongly linking input->Wave as output->Wave,
as far as i can see.
Giving these channels diff. names in kernel will prevent this
 problem.

root@ghrt:~# cat  /proc/asound/cards
0 [V8233          ]: VIA8233 - VIA 8233
                     VIA 8233 with VIA1612A at 0xe000, irq 5
1 [Live           ]: EMU10K1 - SB Live 5.1 [SB0220]
                     SB Live 5.1 [SB0220] (rev.10, serial:0x80651102)
at 0xe800, irq 12

> There was a bug that the front control conflicts with ac97 and
> emu10k1 dsp which was already fixed in the latest version (at least
> on 2.6.16-rc3).

i saw (already in 2.6.15.1 as well) and i will try it in weekend
(sooner if it's urgent).

tia
--
ghrt

> Takashi
