Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbTFQXRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 19:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265008AbTFQXRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 19:17:32 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:45761 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265007AbTFQXRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 19:17:30 -0400
Date: Wed, 18 Jun 2003 01:31:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: davidm@hpl.hp.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, Riley Williams <Riley@Williams.Name>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Message-ID: <20030618013114.A23697@ucw.cz>
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name> <16111.37901.389610.100530@napali.hpl.hp.com> <20030618002146.A20956@ucw.cz> <16111.38768.926655.731251@napali.hpl.hp.com> <20030618004233.B21001@ucw.cz> <16111.40816.147471.84610@napali.hpl.hp.com> <20030618011411.A23198@ucw.cz> <16111.41748.667166.867915@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16111.41748.667166.867915@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Tue, Jun 17, 2003 at 04:24:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 04:24:04PM -0700, David Mosberger wrote:
> >>>>> On Wed, 18 Jun 2003 01:14:11 +0200, Vojtech Pavlik <vojtech@suse.cz> said:
> 
>   >>  Sounds much better to me.  Wouldn't something along the lines of
>   >> this make the most sense:
> 
>   >> #ifdef __ARCH_PIT_FREQ # define PIT_FREQ __ARCH_PIT_FREQ #else #
>   >> define PIT_FREQ 1193182 #endif
> 
>   >> After all, it seems like the vast majority of legacy-compatible
>   >> hardware _do_ use the standard frequency.
> 
>   Vojtech> Now, if this was in some nice include file, along with the
>   Vojtech> definition of the i8253 PIT spinlock, that'd be
>   Vojtech> great. Because not just the beeper driver uses the PIT,
>   Vojtech> also some joystick code uses it if it is available.
> 
> ftape, too.  The LATCH() macro should also be moved to such a header
> file, I think.  How about just creating asm/pit.h?  Only platforms
> that need to (potentially) support legacy hardware would need to
> define it.  E.g., on ia64, we could do:
> 
>  #ifndef _ASM_IA64_PIT_H
>  #define _ASM_IA64_PIT_H
> 
>  #include <linux/config.h>
> 
>  #ifdef CONFIG_LEGACY_HW
>  # define PIT_FREQ	1193182
>  # define LATCH		((CLOCK_TICK_RATE + HZ/2) / HZ)
>  #endif
> 
>  #endif /* _ASM_IA64_PIT_H */
> 
> This way, machines that support legacy hardware can define
> CONFIG_LEGACY_HW and on others, the macro can be left undefined, so
> that any attempt to compile drivers requiring legacy hw would fail to
> compile upfront (much better than accessing random ports!).

Yes, that looks very good indeed. Riley?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
