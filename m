Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267652AbUHRUgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267652AbUHRUgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUHRUgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:36:10 -0400
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:50816 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267646AbUHRUft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:35:49 -0400
Date: Wed, 18 Aug 2004 22:35:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mochel@digitalimplant.org, benh@kernel.crashing.org,
       David Brownell <david-b@pacbell.net>
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040818203523.GC5395@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz> <20040817212510.GA744@elf.ucw.cz> <20040817152742.17d3449d.akpm@osdl.org> <20040817223700.GA15046@elf.ucw.cz> <20040817161245.50dd6b96.akpm@osdl.org> <20040818002711.GD15046@elf.ucw.cz> <1092850283.26049.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092850283.26049.20.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I can replace suspend_state_t with enum system_state, but it might
> > mean that enum system_state will have to be extended with things like
> > RUNTIME_PM_PCI_D0 in future... I guess that's easiest thing to do. It
> > solves all the problems we have *now*.
> 
> Can you not also provide a function
> 
> 	pci_state_for(system_state)
> 
> then most of the drivers don't have to care. It would also be nice

I actually named that function to_pci_state(), but you had same idea.

> to have a driver flag to indicate which devices can simply be
> hotunplug/hotreplugged over a suspend and don't need extra duplicate
> code.

Hmm, I do not think it is that easy

suspend is:
	stop hardware

hotunplug is:
	stop hardware
	tell user/system it is gone

So it is more like suspend is subset of hotunplug. If coded properly,
hotunplug should probably call suspend code, resulting in no
duplication.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
