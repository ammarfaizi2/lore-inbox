Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265534AbUFXUfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265534AbUFXUfV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265537AbUFXUfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:35:21 -0400
Received: from halon.barra.com ([144.203.11.1]:9652 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id S265534AbUFXUfK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:35:10 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] ali5451 not resumed properly under 2.6.7 ( fine under 2.6.6 )
Date: Thu, 24 Jun 2004 13:34:40 -0700
User-Agent: KMail/1.6.2
Cc: Takashi Iwai <tiwai@suse.de>, matt_wu@acersoftech.com.cn,
       Andrew Morton <akpm@osdl.org>
References: <200406231004.27689.fedor@karpelevitch.net> <s5hisdhia22.wl@alsa2.suse.de>
In-Reply-To: <s5hisdhia22.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406241334.49133.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai wrote:
> At Wed, 23 Jun 2004 10:04:17 -0700,
>
> Fedor Karpelevitch wrote:
> > Hi,
> >
> > I upgraded to 2.6.7 recently and noticed that my ali5451 souncard
> > stopped behaving properly after resuming.
> >
> > Basically after resume it produces no sound even though
> > everything pretends that the card is working properly (mixer
> > "changes" volume etc...).
> > I found that executing something like 'alsactl -F power A5451 D1'
> > makes it produce sound again although the volume is noticably
> > lower than it should be.
> >
> > 2.6.6 works just fine.
> >
> > I looked at the diff for ali5451.c and noticed that in
> > ali_suspend a call to snd_pcm_suspend_all(chip->pcm) was added,
> > but in ali_resume no call to resume pcm was added. Could that be
> > the cause of the problem?
>
> No, the resume is done either in pcm_oss.c or by calling the resume
> ioctl explicitly from ALSA-native apps later on.
>
> > I will try adding that call and see if that fixes the problem.
>
> There is no function such as snd_pcm_resume_pcm().

yeh, I figured that out... Should there be one?

>
> Maybe you can remove the calls of snd_pcm_suspend_all(),
> snd_ac97_suspend() in suspend callback, and snd_ac97_resume() in
> resume callback.
>

I tried this but it did not help, same result - no sound after resume, 
tweaking PCM volume does make sound come back, but it is noticably 
quieter than before suspend. I am back to 2.6.6 for now... :-(

Fedor
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2zrlw4m50RG4juoRAr5jAKClrmdZDMOKf12WVWQ5qmoyIv+z5ACfZit2
sBRBksHIVbqGF/Yljk1v/XY=
=eFiQ
-----END PGP SIGNATURE-----
