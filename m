Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWCWSrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWCWSrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWCWSrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:47:52 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:51118 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932350AbWCWSrv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:47:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PT1SHR2/piZetqlrIUACgYSeoV3ztI4ePvbkCKbmLaKKXcxsVmh6TU4wbRXFJ7MOg6lzw0hPJvKqgu1jPSqKYxV5QfKCHQgKy4f7abZsgQmRFb0Mdjxb/LX/iHwOP1D9+FMK1XsEcrGOmHQdqf1zMp1bwzvFawswOUvLV2RNi14=
Message-ID: <d120d5000603231047q6e777243nb4031b701dbdc494@mail.gmail.com>
Date: Thu, 23 Mar 2006 13:47:46 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Stas Sergeev" <stsp@aknet.ru>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <4422E968.1050506@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603220652.k2M6qZgi020656@shell0.pdx.osdl.net>
	 <d120d5000603221332n6a6f9208x5651dc9ec993f4bf@mail.gmail.com>
	 <4422318C.407@aknet.ru>
	 <d120d5000603230651p6b43aad9ocad1aa3c2b51b388@mail.gmail.com>
	 <4422E2DA.7050305@aknet.ru>
	 <d120d5000603231012h1c0f5s8ecde64e67641317@mail.gmail.com>
	 <4422E968.1050506@aknet.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/06, Stas Sergeev <stsp@aknet.ru> wrote:
> Hi.
>
> Dmitry Torokhov wrote:
> > OK, you need to tell me again what snd_pcsp and what exactly it
> > functions are, because I am confised at the moment.
> It is a PCM emulation driver - like any other ALSA PCM driver
> it can play a digital sound, emulating the 5bit PCM stream
> on a 1bit PC-Speaker device. (actually it pretends to be a
> 16bit stereo device, but what it produces is a 5bit mono sound)
>
> > If it is just for
> > playing sounds/music through PC speaker then I don't understand why
> > you want to disable pcspkr driver - if people don't like terminal
> > beeps they can disable it.
> The problem is that when the snd_pcsp is playing, the terminal beeps
> will "destroy" it, as they reprogram the PIT channel 2. So I need a
> way to disable pcspkr while the PCM is playing, but re-enable it as
> soon as the PCM output stopped.

So what you actually need is a mediator module controlling concurrent
access to the speaker hardware from both pcspkr and snd_pcsp and
making sure that one does not disrupt the other. This is completely
outside of the scope of the input subsystem tough.

> This only means people won't hear the terminal beeps while they "listen
> to the music", but this is not as big problem as disabling these beeps
> completely when snd_pcsp is selected in the config.

You are right, I misunderstood the purpose of snd_pcsp. Still the best
solution would be to allow beeps to come through if user keeps them
enabled.

--
Dmitry
