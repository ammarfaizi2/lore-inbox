Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130146AbQK3VTK>; Thu, 30 Nov 2000 16:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbQK3VTA>; Thu, 30 Nov 2000 16:19:00 -0500
Received: from dsl-64-193-169-237.telocity.com ([64.193.169.237]:4740 "EHLO
	dsl-64-193-169-237.telocity.com") by vger.kernel.org with ESMTP
	id <S130146AbQK3VSm>; Thu, 30 Nov 2000 16:18:42 -0500
Date: Thu, 30 Nov 2000 14:47:50 -0600
To: Dick Streefland <dick.streefland@tasking.com>
Cc: Robert Schiele <rschiele@uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: es1371 mixer problems
Message-ID: <20001130144750.A30108@yipyap.net>
In-Reply-To: <20001124135956.A5842@kemi.tasking.nl> <20001130134725.A12437@kemi.tasking.nl> <20001130182428.A2127@schiele.priv> <20001130184209.A17335@kemi.tasking.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001130184209.A17335@kemi.tasking.nl>; from dick.streefland@tasking.com on Thu, Nov 30, 2000 at 06:42:09PM +0100
From: Brian McGroarty <snowfox@yipyap.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 06:42:09PM +0100, Dick Streefland wrote:
> On Thursday 2000-11-30 18:24, Robert Schiele wrote:
> | On Thu, Nov 30, 2000 at 01:47:25PM +0100, Dick Streefland wrote:
> | > This mixer probably replaces the normal AC97 mixer device. So, in
> | > what situations do you need CONFIG_SOUND_TVMIXER? It would be nice if
> | > someone could come up with an entry for Documentation/Configure.help.
> | 
> | In fact it does not 'replace' the other mixer device, but it adds
> | another one. The problem on your system is, that you load the new
> | module before your sound card module.
> | This means with only your sound card module, the mixer for your sound
> | card is major 14/minor 0. With tvmixer module loaded before your sound
> | card module, major 14/minor 0 is assigned to tvmixer and your sound
> | card mixer gets major 14/minor 16. This is a problem for some mixer
> | applications, because they always control the first mixer device.
> | So you should just make sure, your sound card module is loaded
> | _before_ the tvmixer module.
> 
> OK, that makes it somewhat clearer to me. However, I don't use modules
> and have everything compiled in, so I can't control the order in which
> the mixer devices get loaded. Perhaps the initialization order in the
> kernel should be changed?

Ditto this problem with via82c686a audio - likely all sound cards with
tvmixer linked in.

If initialization order in the kernel is not changed and you don't
want modules, you can swap /dev/mixer0 and /dev/mixer1 as an inelegant
workaround.


> Excuse my ignorance, but what exactly is the purpose of the tvmixer?
> I'm currently controlling the TV audio volume with the ac97 mixer,
> using an external cable between the TV card and sound card.

There exists a mixer for the pass-through on the WinTV bt848 cards at
least, as well as treble/bass control. Many stations broadcast with
obscene amounts of bass, and so access to this is nice as you don't
have to spoil your main EQ.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
