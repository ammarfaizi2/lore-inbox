Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSKRJoS>; Mon, 18 Nov 2002 04:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSKRJoS>; Mon, 18 Nov 2002 04:44:18 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:1446
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261855AbSKRJoR>; Mon, 18 Nov 2002 04:44:17 -0500
Date: Mon, 18 Nov 2002 04:53:36 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Taral <taral@taral.net>
cc: alsa-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: Oops when removing snd-timer
In-Reply-To: <Pine.LNX.4.44.0211180347320.1538-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0211180450230.1538-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Zwane Mwaikambo wrote:

> Looks like you loaded ens137x.c and then that driver got unloaded leaving 
> the callback still valid, then the core timer code decided to walk off a 
> cliff using that pointer.

Not really the case, probably from pcm code.

> 0xc0365322 is in snd_timer_free (sound/core/timer.c:676).
> 671     static int snd_timer_free(snd_timer_t *timer)
> 672     {
> 673             snd_assert(timer != NULL, return -ENXIO);
> 674             if (timer->private_free)
> 675                     timer->private_free(timer);
> 676             snd_magic_kfree(timer);
> 677             return 0;
> 678     }
> 
> The problem seems to be a sort of chicken/egg case? We can't rely on 
> modules being around even with this inter dependency case.

Perhaps driver specific code should be doing as much of their own cleanup 
as possible. I'm still wondering how this managed to unload without that 
getting run, unless its a simple case of forgetting a failure path.

	Zwane
-- 
function.linuxpower.ca

