Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVC1M7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVC1M7N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 07:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVC1M7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 07:59:13 -0500
Received: from witte.sonytel.be ([80.88.33.193]:56542 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261695AbVC1M6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 07:58:52 -0500
Date: Mon, 28 Mar 2005 14:58:38 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dave Jones <davej@redhat.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <20050327174026.GA708@redhat.com>
Message-ID: <Pine.LNX.4.62.0503281457160.7244@numbat.sonytel.be>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
 <1111881955.957.11.camel@mindpipe> <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
 <20050327065655.6474d5d6.pj@engr.sgi.com> <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
 <20050327174026.GA708@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2005, Dave Jones wrote:
> On Sun, Mar 27, 2005 at 05:12:58PM +0200, Jan Engelhardt wrote:
>  > Well, kfree inlined was already mentioned but forgotten again.
>  > What if this was used:
>  > 
>  > inline static void kfree_WRAP(void *addr) {
>  >     if(likely(addr != NULL)) {
>  >         kfree_real(addr);
>  >     }
>  >     return;
>  > }
>  > 
>  > And remove the NULL-test in kfree_real()? Then we would have:
> 
> Am I the only person who is completely fascinated by the
> effort being spent here micro-optimising something thats
> almost never in a path that needs optimising ?
> I'd be amazed if any of this masturbation showed the tiniest
> blip on a real workload, or even on a benchmark other than
> one crafted specifically to test kfree in a loop.

The benchmarks were started when someone noticed one of the tests was (a) not
in a cleanup path and (b) very unlikely to be true.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
