Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUDNVd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUDNVd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:33:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:18155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261867AbUDNVdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:33:53 -0400
Date: Wed, 14 Apr 2004 14:27:54 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
Message-Id: <20040414142754.02a42048.rddunlap@osdl.org>
In-Reply-To: <20040414212539.GE1175@waste.org>
References: <407CEB91.1080503@pobox.com>
	<20040414005832.083de325.akpm@osdl.org>
	<20040414010240.0e9f4115.akpm@osdl.org>
	<407CF201.408@pobox.com>
	<20040414011653.22c690d9.akpm@osdl.org>
	<407CFFF9.5010500@pobox.com>
	<20040414212539.GE1175@waste.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 16:25:39 -0500 Matt Mackall wrote:

| On Wed, Apr 14, 2004 at 05:10:17AM -0400, Jeff Garzik wrote:
| > Andrew Morton wrote:
| > >Jeff Garzik <jgarzik@pobox.com> wrote:
| > >
| > >>I would rather not kill the code in submit_bh() outright, just disable 
| > >>it for non-filesystem developers.
| > >
| > >
| > >submit_bh() is a slowpath ;) The one in mark_buffer_dirty() will be called
| > >more often, possibly others.  Kill!
| > 
| > Jens seems to like the debugging checks, so here's an alterna-patch.
| > 
| > 	Jeff
| > 
| > 
| 
| > ===== arch/alpha/Kconfig 1.36 vs edited =====
| > +++ edited/arch/alpha/Kconfig	Wed Apr 14 04:58:08 2004
| > @@ -690,6 +690,13 @@
| >  	  Say Y here only if you plan to use gdb to debug the kernel.
| >  	  If you don't debug the kernel, you can say N.
| >  
| > +config DEBUG_BUFFERS
| > +	bool "Enable additional filesystem buffer_head checks"
| > +	depends on DEBUG_KERNEL
| > +	help
| > +	  If you say Y here, additional checks are performed that aid
| > +	  filesystem development.
| > +
| >  endmenu
| 
| Sticking this in arch/*/Kconfig seems silly (as does much of the
| duplication in said files). Can we stick this and other debug bits
| under the kallsyms option in init/Kconfig instead? Or alternately move
| debugging bits into their own file that gets included as appropriate.

Yes, I'll jump onto that if noone else does it.
Matt, are you making a patch for this?

--
~Randy
"We have met the enemy and he is us."  -- Pogo (by Walt Kelly)
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
