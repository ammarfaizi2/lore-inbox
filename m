Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTEPUR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 16:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTEPUR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 16:17:58 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:18906 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264606AbTEPUR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 16:17:58 -0400
Date: Fri, 16 May 2003 22:26:56 +0200 (MEST)
Message-Id: <200305162026.h4GKQumG026579@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: andreas@fjortis.info, davej@codemonkey.org.uk
Subject: Re: 2.5.69-mm6
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 May 2003 18:55:39 +0100, Dave Jones wrote:
>On Fri, May 16, 2003 at 07:28:34PM +0200, Andreas Henriksson wrote:
> > I also got unresolved symbols for two modules.
> > arch/i386/kernel/suspend.ko: enable_sep_cpu, default_ldt, init_tss
> > arch/i386/kernel/apm.ko: save_processor_state, restore_processor_state
>
>Mikael's patch for these has been posted several times already in the
>last few days.

No, Andreas' bug is different. He obviously built APM as a module,
and apparently the save and restore processor state procedures in
suspend.c aren't EXPORT_SYMBOL()d. I never build APM as a module
so I didn't notice this in my testing.

Workarounds: configure APM non-modular, or add EXPORT_SYMBOL()
for {save,restore}_processor_state somewhere in arch/i386/kernel/.

I'll whip up a proper patch with the EXPORT_SYMBOL()s tomorrow.

/Mikael

