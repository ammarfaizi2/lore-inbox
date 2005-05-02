Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVEBJzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVEBJzg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 05:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVEBJzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 05:55:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14024 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261185AbVEBJz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 05:55:28 -0400
Date: Mon, 2 May 2005 11:55:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] properly stop devices before poweroff
Message-ID: <20050502095506.GB1821@elf.ucw.cz>
References: <20050421111346.GA21421@elf.ucw.cz> <20050501222403.GF3951@neo.rr.com> <20050501231635.GJ1909@elf.ucw.cz> <20050502000146.GI3951@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502000146.GI3951@neo.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thats okay, nobody really knows yet. I believe that SUSPEND and HALT
> > are very similar, and flags best way to separate them. I believe that
> > FREEZE and REBOOT are very similar, too, and again would use flags to
> > tell between them.
> 
> I'm not so sure about SUSPEND and HALT being similar.  It might be much faster
> to have a routine that ignores slow state changes and goes directly for
> stopping device activity.  Still, I'm not entirely decided.  On ACPI systems
> SUSPEND should generally work, as it's the intended behavior for S4 which is
> basically like S5 in many cases.  However, having a specific HALT message
> might allow driver developers to clarify this ambiguity on a per-device basis.

Umm, you are right, HALT is somewhere between FREEZE and SUSPEND.

> > First I want type checking for pm_message_t. That's 2.6.12-early
> > material. Then, when it is *really clear* that flags are needed, I'll
> > add them. "really needed" as in "we have a driver where it matters".
> 
> I think it's already clear that we need to pass the specific device state.
> Also the intended global system state transition might be helpful.

Global system state transition should be clear from flags. Specific
device state is needed for selective suspend, elsewhere I'd go for
helper function.

> However, at the moment I'm considering using a slightly different API for
> these sort of things.  It would include "->prepare_state_change()" and
> "->complete_state_change()"  I'll have further justification for these
> changes soon, however, I would like to leave the current stuff around also
> as it would still be useful for shutdown and reboot, non-PM suspend issues,
> and backward compatibilty.

I'd prefer not to have more callbacks (unless absolutely
neccessary). We used to have them, and people got it wrong....

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
