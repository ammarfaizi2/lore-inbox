Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTI3R0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 13:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbTI3R0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 13:26:45 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:13363 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261606AbTI3R0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 13:26:42 -0400
Date: Tue, 30 Sep 2003 18:26:18 +0100
From: Dave Jones <davej@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20030930172618.GE5507@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jamie Lokier <jamie@shareable.org>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	richard.brunner@amd.com
References: <20030930073814.GA26649@mail.jlokier.co.uk> <20030930132211.GA23333@redhat.com> <20030930133936.GA28876@mail.shareable.org> <20030930135324.GC5507@redhat.com> <20030930144526.GC28876@mail.shareable.org> <20030930150825.GD5507@redhat.com> <20030930165450.GF28876@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930165450.GF28876@mail.shareable.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 05:54:50PM +0100, Jamie Lokier wrote:

 > > >    - I don't see anything that prevents a PPro-compiled kernel from booting
 > > >      on a P5MMX with the F00F erratum.
 > > Compiled with -m686 - Uses CMOV, won't boot.
 > Ok, not PPro, but with Processor Family set to K6, CYRIXIII, or any of
 > the 3 WINCHIP choices, it is compiled with -march=i585 and without F00F.

in theory, these should be interchangable. Not tested though.

 > (Fixing that by adding F00F too all those non-Intel processors, just to
 > make sure non-F00F kernels crash with a cmov instruction is too subtle
 > for my taste.)

this case is a little more obscure imo, and not worth the effort.

 > Anyway, it should complain about lack of cmov not crash :)

not easy, given we execute cmov instructions before we even hit
a printk. Such a test & output needs to be done in assembly in early
startup.

 > > 1. The splitting of X86_FEATURE_XMM into X86_FEATURE_XMM_PREFETCH and
 > >    X86_FEATURE_3DNOW_PREFETCH doesn't seem to really buy us anything
 > >    other than complication.
 > I once suggested turning off XMM entirely when prefetch is broken and
 > not fixed, but that resulted in a mild toasting, hence the extra
 > synthetic flag.

Which gets us back to the question of why this is needed at all ?
You said earlier "In case you hadn't fully grokked it, my code doesn't
disable the workaround!"  So why do you need this ?

 > > - If we haven't set CONFIG_X86_PREFETCH_FIXUP (say a P4 kernel), this
 > >   code path isn't taken, and we end up not doing prefetches on P4's too
 > >   as you're not setting X86_FEATURE_XMM_PREFETCH anywhere else, and apply_alternatives
 > >   leaves them as NOPs.
 > > - Newer C3s are 686's with prefetch, this nobbles them too.
 > Read the code again.  It does what you think it doesn't do, so to speak.

Yep, brain fart.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
