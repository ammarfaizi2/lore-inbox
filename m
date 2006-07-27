Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWG0BFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWG0BFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 21:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWG0BFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 21:05:52 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:14216 "EHLO
	asav06.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750753AbWG0BFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 21:05:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HANqtx0SBTw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Fwd: Using select in boolean dependents of a tristate symbol
Date: Wed, 26 Jul 2006 21:05:35 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <d120d5000607131232i74dfdb9t1a132dfc5dd32bc4@mail.gmail.com> <d120d5000607191317k2e773af3ta5034a37db5ad97d@mail.gmail.com> <Pine.LNX.4.64.0607270225540.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0607270225540.6761@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607262105.36159.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 20:42, Roman Zippel wrote:
> Hi,
> 
> On Wed, 19 Jul 2006, Dmitry Torokhov wrote:
> 
> > Another question for you  - what is the best way to describe
> > dependancy of a sub-option on a subsystem so you won't end up with the
> > subsystem as a module and user built in. Something like
> > 
> > config IBM_ASM
> >        tristate "Device driver for IBM RSA service processor"
> >        depends on X86 && PCI && EXPERIMENTAL
> > ...
> > config IBM_ASM_INPUT
> >        bool "Support for remote keyboard/mouse"
> >        depends on IBM_ASM && (INPUT=y || INPUT=IMB_ASM)
> > 
> > But the above feels yucky. Could we have something like:
> > 
> >         depends on matching(INPUT, IBM_ASM)
> 
> This is not really descriptive of what it does, is it?
> Linus suggested a syntax like (IBM_ASM && IMB_ASM<=INPUT)
> Another alternative which works now is to just disable the one invalid 
> case explicitely:
> 
> 	depends on IBM_ASM && INPUT
> 	depends on !(IBM_ASM=y && INPUT=m)
>

OK, then I'll be disabling invalid cases explicitly for now.

Thank you Roman.

-- 
Dmitry
