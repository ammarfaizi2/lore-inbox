Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUB0WjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbUB0WjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:39:14 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:45762 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S263172AbUB0WjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:39:02 -0500
Date: Fri, 27 Feb 2004 15:39:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, amit@av.mvista.com,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Message-ID: <20040227223901.GK1052@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <403FC521.7040508@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403FC521.7040508@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 02:30:57PM -0800, George Anzinger wrote:

> Comments below...

I'm going to set aside some of the comments, simply because I'm not
going to change behavior / content right now, we can do that afterwards.

[snip]
> >+choice
> >+	depends on KGDB_8250 || PPC_SIMPLE_SERIAL
> >+    	prompt "Debug serial port BAUD"
> >+	default KGDB_115200BAUD
> >+	help
> >+	  Gdb and the kernel stub need to agree on the baud rate to be
> >+	  used.  Some systems (x86 family at this writing) allow this to
> >+	  be configured.
> 
> Should this depend on the archs that can use it?

The help is wrong, that's all, it's not arch-dependant, it's driver
dependant.

> >+config KGDB_IRQ
> >+	int "IRQ of the debug serial port"
> >+	depends on !KGDB_SIMPLE_SERIAL && (KGDB_8250 || PPC_SIMPLE_SERIAL)
> >+	default 4
> >+	help
> >+	  This is the irq for the debug port.  If everything is working
> >+	  correctly and the kernel has interrupts on a control C to the
> >+	  port should cause a break into the kernel debug stub.
>
> I think setserial will also spit this out.

And of course, ^C isn't needed now too.

> >+config KGDB_THREAD
> >+	bool "KGDB: Thread analysis"
> >+	depends on KGDB
> >+	help
> >+	  With thread analysis enabled, gdb can talk to kgdb stub to list
> >+	  threads and to get stack trace for a thread. This option also 
> >enables
> >+	  some code which helps gdb get exact status of thread. Thread 
> >analysis
> >+	  adds some overhead to schedule and down functions. You can disable
> >+	  this option if you do not want to compromise on speed.
> 
> Lets remove the overhead and eliminate the need for this option in favor of 
> always having threads.  Works in the mm kgdb...

Once it's clean, perhaps.

> >+config KGDB_CONSOLE
> >+	bool "KGDB: Console messages through gdb"
> >+	depends on KGDB
> >+	help
> >+	  If you say Y here, console messages will appear through gdb.
> >+	  Other consoles such as tty or ttyS will continue to work as usual.
>
> Might want to warn them of the need to connect prior to the first message 
> from the kernel....

There is no such need.

-- 
Tom Rini
http://gate.crashing.org/~trini/
