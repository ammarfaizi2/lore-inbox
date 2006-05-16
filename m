Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWEPQoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWEPQoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWEPQoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:44:15 -0400
Received: from relay00.pair.com ([209.68.5.9]:24333 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1751858AbWEPQoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:44:15 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 16 May 2006 11:44:13 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] add input_enable_device()
In-Reply-To: <4469FDF0.3020403@aknet.ru>
Message-ID: <Pine.LNX.4.64.0605161142160.32181@turbotaz.ourhouse>
References: <44670446.7080409@aknet.ru> <20060515143119.54b5aff8.akpm@osdl.org>
 <4469F709.4040605@aknet.ru> <20060516090324.66ea0ea6.akpm@osdl.org>
 <4469FDF0.3020403@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, Stas Sergeev wrote:

> Hello.
>
> Andrew Morton wrote:
>>  iirc it had to do with the pc-speaker driver, but I don't seem to be able
>>  to locate the original email.
> OK, sorry, I haven't realized its important.
>
> ---
> The patch below adds input_enable_device() and input_disable_device()
> to the input subsystem, that allows to enable and disable the input
> devices. The reason to have it, is the snd-pcsp PC-Speaker driver in
> an ALSA tree that needs an ability to disable the pcspkr driver.
>
> Signed-off-by: Stas Sergeev <stsp@aknet.ru>
> CC:  Dmitry Torokhov <dtor_core@ameritech.net>
> CC:  Vojtech Pavlik <vojtech@suse.cz>
>
>

> --- a/include/linux/input.h	2006-04-05 17:10:01.000000000 +0400
> +++ b/include/linux/input.h	2006-04-05 17:36:49.000000000 +0400
> @@ -878,7 +878,7 @@
>
>  	struct pt_regs *regs;
>  	int state;
> -
> +	int disabled;
>  	int sync;
>
>  	int abs[ABS_MAX + 1];

Why eat an entire word here? It seems we already have a "dynalloc" 
boolean/int... perhaps some of these things could be rolled up into a 
bitfield.

Cheers,
Chase
