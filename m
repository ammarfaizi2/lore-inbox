Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVCHPsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVCHPsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 10:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCHPsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 10:48:06 -0500
Received: from god.demon.nl ([83.160.164.11]:23429 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S261331AbVCHPrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 10:47:48 -0500
Date: Tue, 8 Mar 2005 16:47:47 +0100
From: Henk Vergonet <rememberme@god.dyndns.org>
To: linux-kernel@vger.kernel.org
Cc: dtor_core@ameritech.net
Subject: Re: RFC: Harmonised parameter passing
Message-ID: <20050308154747.GA10071@god.dyndns.org>
References: <20050308145923.GA9914@god.dyndns.org> <d120d5000503080714ba3843d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000503080714ba3843d@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 10:14:32AM -0500, Dmitry Torokhov wrote:
> On Tue, 8 Mar 2005 15:59:23 +0100, Henk Vergonet
> > Could we extend this method where we use the same methodology for inbound drivers? (Currently a lot of drivers use their own parameter parsing code when it comes to passing values at kernel boot time.)
> > 
> > so we could do the regular:
> > 
> >        insmod mcd io=0x340
> > 
> > for modules, or with kernel boot parameters:
> > 
> >        mcd.io=0x340
> > 
> > for in-kernel drivers.
> > 
> 
> Umm.. This is already done. For parameters defined with module_param()
> you use <paramname>=<value> for modules and
> <modulename>.<paramname>=<value> for built-in case.

I did not know, but thats good news! My research was only based on the LKM module howto.

> > My proposal would be to introduce something like:
> > 
> > DRIVER_PARM_DESC(variable, description);
> > DRIVER_PARM(variable, type, scope);
> > 
> >    where scope can be:
> >        PARM_SCOPE_MODULE       => This parameter is used in module context.
> >        PARM_SCOPE_KERNEL       => This parameter is used in kernel context.
> >        PARM_SCOPE_MODULE | PARM_SCOPE_KERNEL
> >                                => This parameter is used in both kernel and module context, which should be the default if scope is omitted.
> > 
> 
> Why would you want parameters that only work for modules? I'd consider
> it a bug, not a feature, when parameter works only when code is
> modularized.
> 
I totally agree! (But I was preparing for the discussion were people
argue that they need a different set of parameters at boot time.)

One question remains though, how do you handle the initialization of
multiple instances of an inbound driver?

mcd0.io=0x340 mcd1.io=0x350 

Thnx,
Henk
