Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWCWSap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWCWSap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWCWSap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:30:45 -0500
Received: from mail.aknet.ru ([82.179.72.26]:56080 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932469AbWCWSap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:30:45 -0500
Message-ID: <4422E968.1050506@aknet.ru>
Date: Thu, 23 Mar 2006 21:31:04 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
References: <200603220652.k2M6qZgi020656@shell0.pdx.osdl.net>	 <d120d5000603221332n6a6f9208x5651dc9ec993f4bf@mail.gmail.com>	 <4422318C.407@aknet.ru>	 <d120d5000603230651p6b43aad9ocad1aa3c2b51b388@mail.gmail.com>	 <4422E2DA.7050305@aknet.ru> <d120d5000603231012h1c0f5s8ecde64e67641317@mail.gmail.com>
In-Reply-To: <d120d5000603231012h1c0f5s8ecde64e67641317@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Dmitry Torokhov wrote:
> OK, you need to tell me again what snd_pcsp and what exactly it
> functions are, because I am confised at the moment.
It is a PCM emulation driver - like any other ALSA PCM driver
it can play a digital sound, emulating the 5bit PCM stream
on a 1bit PC-Speaker device. (actually it pretends to be a
16bit stereo device, but what it produces is a 5bit mono sound)

> If it is just for
> playing sounds/music through PC speaker then I don't understand why
> you want to disable pcspkr driver - if people don't like terminal
> beeps they can disable it.
The problem is that when the snd_pcsp is playing, the terminal beeps
will "destroy" it, as they reprogram the PIT channel 2. So I need a
way to disable pcspkr while the PCM is playing, but re-enable it as
soon as the PCM output stopped.
This only means people won't hear the terminal beeps while they "listen
to the music", but this is not as big problem as disabling these beeps
completely when snd_pcsp is selected in the config.

