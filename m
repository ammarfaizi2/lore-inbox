Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267812AbUHPRGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267812AbUHPRGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUHPRFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:05:52 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:33501 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S267798AbUHPRFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:05:36 -0400
Date: Mon, 16 Aug 2004 10:05:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: adrian@humboldt.co.uk, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Subject: Re: [PATCH][2.4.27] PowerPC 745x data corruption bug fix
Message-ID: <20040816170534.GA7303@smtp.west.cox.net>
References: <200408161004.i7GA48fY002331@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408161004.i7GA48fY002331@harpo.it.uu.se>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 12:04:08PM +0200, Mikael Pettersson wrote:
> On Mon, 16 Aug 2004 08:40:51 +0100, Adrian Cox wrote:
> >On Mon, 2004-08-16 at 03:54, Mikael Pettersson wrote:
> >> On Mon, 16 Aug 2004 08:13:59 +1000, Paul Mackerras wrote:
> >
> >> >Does CONFIG_MPC10X_BRIDGE mean just MPC107, or is it set for (e.g.)
> >> >systems with a MPC106 as well?
> >> 
> >> I just copied this part from 2.6.8. Currently it
> >> seems CONFIG_MPC10X_BRIDGE is set for some platforms
> >> (sandpoint and lopec), but it is definitely not set
> >> for MPC106 machines like my beige PowerMac G3.
> >
> >I don't understand how your patch can improve the stability of your
> >machine when CONFIG_MPC10X_BRIDGE isn't set. 
> 
> See below.
> 
> >Pages should be marked coherent for the MPC106 as well as the MPC107,
> >but the problem shouldn't be seen unless the processor supports the
> >shared cache line state. My original patch only set
> >CPU_FTR_NEED_COHERENT for the 745x family, as only 745x plus 604 have
> >the shared state, but Tom Rini extended it to cover all the other
> >processors. I'm not convinced that extending it was necessary, but the
> >performance impact should be low.
> 
> CPU_FTR_NEED_COHERENT gets set via two independent mechanisms:
> 
> 1. The old code base had #ifdef SMP blocks in hashtable.S
>    and ppc_mmu.c that enforced _PAGE_COHERENT. Since that's
>    now also required in some non-SMP cases, they were
>    changed to be controlled by CPU_FTR_NEED_COHERENT. That's
>    what CPU_FTR_COMMON is for: enforcing CPU_FTR_NEED_COHERENT
>    on SMP. (Ignore CONFIG_MPC10X_BRIDGE. It's noise.)
> 
> 2. For the 745x CPUs, CPU_FTR_NEED_COHERENT is explicitly
>    added to their cpu_features bit mask.
> 
> So previously a CPU got _PAGE_COHERENT on SMP.
> Now a CPU gets _PAGE_COHERENT on (SMP || 745x).
> 
> I suspect the CONFIG_MPC10X_BRIDGE is an attempt to enable
> the fix in some other cases too.

The reason CPU_FTR_NEED_COHERENT was added was to work around an MPC107
(now Tsi107) errata.  See
http://216.239.57.104/search?q=cache:1MDn1X8ieUUJ:www.geocrawler.com/archives/3/8358/2002/9/100/9559482/+%22Adrian+Cox%22+errata&hl=en
(original is conn refused right now).

-- 
Tom Rini
http://gate.crashing.org/~trini/
