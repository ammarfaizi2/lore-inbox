Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269281AbUIYIIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269281AbUIYIIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 04:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269283AbUIYIIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 04:08:53 -0400
Received: from ltgp.iram.es ([150.214.224.138]:55427 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S269281AbUIYIIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 04:08:47 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Sat, 25 Sep 2004 10:04:27 +0200
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Message-ID: <20040925080426.GB12901@iram.es>
References: <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz> <41530326.2050900@aknet.ru> <20040923180607.GA20678@vana.vc.cvut.cz> <4154853F.6070105@aknet.ru> <20040924214330.GD8151@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924214330.GD8151@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 11:43:30PM +0200, Petr Vandrovec wrote:
> On Sat, Sep 25, 2004 at 12:36:15AM +0400, Stas Sergeev wrote:
> > Hi,
> > 
> > Petr Vandrovec wrote:
> > >In that new patch I set the const to 0xe00, which
> > >is 3,5K. Is it still the limitation? I can probably
> > >For 4KB stacks 2KB looks better
> > OK, done that. Wondering though, for what?
> > I don't need 2K myself, I need 24 bytes only.
> > So what prevents me to raise the gap to 3.5K
> > or somesuch? Why 2K looks better?
> 
> You run with ESP decreased by 2KB for some time during
> CPL1 stack setup.  As you run in this part at CPL0
> with same setup as on CPL1, I think that you should
> offer same stack for setup code, and for CPL1 code,
> and so each should get 2KB.

Maybe I miss something, but it seems that lret (or retl)
is not affected by this bug. What prevents you from reordering
the stack (doing the inverse operation of what the lcall7 entry
point does) and then doing:

	popfl
	lret

Yes, I see issues with debugging (trap flag mostly) but I believe
that they are solvable.

	Regards,
	Gabriel

