Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWC0RhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWC0RhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWC0RhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:37:05 -0500
Received: from mail.aknet.ru ([82.179.72.26]:15116 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750886AbWC0RhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:37:02 -0500
Message-ID: <442822B7.9010406@aknet.ru>
Date: Mon, 27 Mar 2006 21:36:55 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: 7eggert@gmx.de, Linux kernel <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz, Takashi Iwai <tiwai@suse.de>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it>	 <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it>	 <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz>	 <44266472.5080309@aknet.ru> <d120d5000603270834j79e707ffu760eba3062531b64@mail.gmail.com>
In-Reply-To: <d120d5000603270834j79e707ffu760eba3062531b64@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Dmitry Torokhov wrote:
>> I think I'd better try to code up the grabbing capability in
>> the input layer, since Dmitry didn't seem to object to that.
> I was pondering over implications of "grabbing" events over the
> weekend and I am not entirely happy with it either. The problem with
> grabbing is that your driver does not have any knowledge of how the
> events would be processed if left untouched. Right now you assume that
> all bells are handled by pcspkr but we could really have alternative
> bell implementations. For example we could have "visual" bell that
> could flash framebuffer or a bell that is routed through ALSA, etc,
> etc. All these alternative bells would not disrupt operation of your
> snd_pcsp module but it still would disable the bell because it does
> not know better.
Why not? I can check dev.id.bustype and dev.phys to find out what
exactly resources it allocates. This all is present in "struct input_dev"
AFAICS. And since they are here, I don't agree using the input subsystem
on that layer is completely wrong.
Well, I can also add the hack to snd-pcsp to always reprogram PIT
chan 2 to proper mode in an inthandler to make it tolerant to whatever
pcspkr does. But this is quite an evil hack, and an unnecessary code
pollution which I'd like to avoid.
Adding a dummy input driver, as per Bodo Eggert, doesn't look very good
to me either. If nothing else then at least because it won't be called
pcspkr, so the confusion is still unavoidable.

Adding a few ALSA guys to CC, who used to help with the snd-pcsp in
the past.

