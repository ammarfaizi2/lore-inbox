Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbUDEWTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUDEWS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:18:26 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9911
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263370AbUDEWM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:12:58 -0400
Date: Tue, 6 Apr 2004 00:12:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [2.4] NMI WD detected lockup during page alloc
Message-ID: <20040405221255.GM2234@dualathlon.random>
References: <20040404121756.GA8854@linuxhacker.ru> <20040405204317.GA13528@logos.cnet> <20040405212734.GA1819@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405212734.GA1819@linuxhacker.ru>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 12:27:34AM +0300, Oleg Drokin wrote:
> In addition to what I have compiled in:
> # lsmod
> Module                  Size  Used by    Not tainted
> ppp_deflate             4568   1  (autoclean)

you may want to disable compression, this sounds like mm corruption and
compression isn't trivial to handle in kernel skbs (though I doubt this
is the problem but it's easy to disable).

> ipt_state               1016   4  (autoclean)

the hang while unloading this module may also be a sign of a bug in the
module so it would be nice if you could reproduce also w/o the above
ips_state.

If this still doesn't help then you can try to go UP again, SMP is
harder at stressing the memory bus and see if it stabilizes. Other thing
you can do is to remove half of the ram and see if it stabilizes to try
to identify buggy ram slots.

Overall it's unlikely the oops is useful unfortunately since that piece
of the kernel is the most stressed ever, and it just signals random mm
corruption. I assume this is the first time you've got the nmi watchdog
oops, if you could get it again it would be more interesting, I'd expect
next time you would get it in another place.

hope this helps.
