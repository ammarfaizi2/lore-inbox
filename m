Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271331AbTGWVfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 17:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbTGWVfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 17:35:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:51590 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271331AbTGWVfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 17:35:33 -0400
Date: Wed, 23 Jul 2003 14:47:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: root@chaos.analogic.com, bernie@develer.com, uclinux-dev@uclinux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6 size increase
Message-Id: <20030723144719.103adc19.rddunlap@osdl.org>
In-Reply-To: <20030723130712.6ac59b56.davem@redhat.com>
References: <200307232046.46990.bernie@develer.com>
	<Pine.LNX.4.53.0307231507300.16939@chaos>
	<20030723130712.6ac59b56.davem@redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 13:07:12 -0700 "David S. Miller" <davem@redhat.com> wrote:

| On Wed, 23 Jul 2003 15:14:22 -0400 (EDT)
| "Richard B. Johnson" <root@chaos.analogic.com> wrote:
| 
| > On Wed, 23 Jul 2003, Bernardo Innocenti wrote:
| > It looks like a lot of data may have been initialized in the
| > newer kernel, i.e. int barf = 0; or struct vomit = {0,}.
| > If they just declared the static data, it would end up in
| > .bss which is allocated at run-time (and zeroed) and is
| > not in the kernel image.
| 
| GCC 3.3 and later do this automatically.
| 
| It's weird, since we killed TONS of explicit zero initializers during
| 2.5.x, you'd be pressed to find many examples like the one you
| mention.
| 
| Another thing is that the define_per_cpu() stuff eliminated many huge
| [NR_CPUS] arrays.  But this probably doesn't apply to his kernel
| unless he built is with SMP enabled.

Yes, lots were already killed off, but there are also several
kernel-janitor patches to remove many more static 0 inits.
They can be found at
  http://developer.osdl.org/ogasawara/kj-patches/uninit_static/
and I'll be trying to have them merged, although I don't know
how well they will be accepted.

--
~Randy
