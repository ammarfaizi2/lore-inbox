Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVIQPs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVIQPs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVIQPs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:48:56 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1017 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751126AbVIQPs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:48:56 -0400
Date: Sat, 17 Sep 2005 08:48:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: trem <trem@zarb.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Cc: ganzinger@mvista.com
Subject: Re: dependance loop on 2.6.14-rc1-mm1
Message-ID: <20050917154829.GC18074@smtp.west.cox.net>
References: <432C00C6.20305@zarb.org> <20050917115138.GA17589@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917115138.GA17589@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 12:51:38PM +0100, Russell King wrote:
> On Sat, Sep 17, 2005 at 01:40:54PM +0200, trem wrote:
> > I've tried to compile a 2.6.14-rc1-mm1 on my amd64. When I do the make 
> > modules_install,
> > I have this warning:
> > 
> > WARNING: Loop detected:
> > /lib/modules/2.6.14-rc1-mm1/kernel/drivers/serial/8250.ko needs 
> > serial_core.ko which needs 8250.ko again!
> 
> This looks suspicious.  8250 should need serial_core, but there's no
> way in hell serial_core should require 8250. 
> 
> Seems to be caused by the kgdb patches, which add the following to
> serial_core:
> 
> +#ifdef CONFIG_KGDB
> +       {
> +               extern int kgdb_irq;
> +
> +               if (port->irq == kgdb_irq)
> +                       return;
> +       }
> +#endif
> +
> 
> and kgdb_irq comes from the 8250 module.
> 
> Tom, can this dependency be solved before kgdb goes near mainline
> please?

My KGDB isn't in -mm yet, that comes from George Anzginer's version.
This is a non-issue in mine, it really just adds yet another/different
release function.

-- 
Tom Rini
http://gate.crashing.org/~trini/
