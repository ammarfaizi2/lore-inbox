Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbUCBPEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUCBPEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:04:23 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:34452 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261666AbUCBPEV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:04:21 -0500
Date: Tue, 2 Mar 2004 08:04:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][2/7] Serial updates, take 2
Message-ID: <20040302150418.GB16434@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <403FD868.4090007@mvista.com> <20040301152807.GQ1052@smtp.west.cox.net> <200403021706.03925.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403021706.03925.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 05:06:03PM +0530, Amit S. Kale wrote:

> This patch broke Ctrl+C response on my system. Fix as follows
> With this fix I can kill or detach gdb with pending console messages and then 
> connect a new gdb.
> 
> Is following fix ok to checkin? (interdiff)
> 
> @@ -412,11 +418,11 @@
>  +              /* The user has selected one of ttyS[0-3], which we pull
>  +               * from rs_table[].  If this doesn't exist, user error. */
>  +              gdb_async_info.port = gdb_async_info.state->port =
> -+                  rs_table[KGDB_PORT].port;
> ++                  rs_table[kgdb8250_ttyS].port;
>  +              gdb_async_info.line = gdb_async_info.state->irq =
> -+                  rs_table[KGDB_PORT].irq;
> -+              gdb_async_info.state->io_type = rs_table[KGDB_PORT].io_type;
> -+              reg_shift = rs_table[KGDB_PORT].iomem_reg_shift;
> ++                  rs_table[kgdb8250_ttyS].irq;
> ++              gdb_async_info.state->io_type = 
> rs_table[kgdb8250_ttyS].io_type;
> ++              reg_shift = rs_table[kgdb8250_ttyS].iomem_reg_shift;
>  +      }
>  +
>  +      switch (gdb_async_info.state->io_type) {

Hmm.  I take it you passed in a different ttyS than you configured for?
Been a while since I tried that, and the above look correct.  Go ahead.

-- 
Tom Rini
http://gate.crashing.org/~trini/
