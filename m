Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUCBLkF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 06:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUCBLkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 06:40:04 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:35276 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261618AbUCBLjm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 06:39:42 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Date: Tue, 2 Mar 2004 17:09:26 +0530
User-Agent: KMail/1.5
References: <20040227212301.GC1052@smtp.west.cox.net>
In-Reply-To: <20040227212301.GC1052@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403021709.26396.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It also makes core.patch dependent on 8250.patch
Any ideas on fixing that?

-Amit

On Saturday 28 Feb 2004 2:53 am, Tom Rini wrote:
> Hello.  The following patch moves all of the config options into one file,
> kernel/Kconfig.kgdb.
>
> diff -zrupN linux-2.6.3+nothing/arch/i386/Kconfig
> linux-2.6.3+config+serial/arch/i386/Kconfig ---
> linux-2.6.3+nothing/arch/i386/Kconfig	2004-02-27 12:16:14.296187607 -0700
> +++ linux-2.6.3+config+serial/arch/i386/Kconfig	2004-02-27
> 12:16:13.707320867 -0700 @@ -1253,36 +1253,7 @@ config DEBUG_SPINLOCK_SLEEP
>  	  If you say Y here, various routines which may sleep will become very
>  	  noisy if they are called with a spinlock held.
>
> -config KGDB
> -	bool "KGDB: kernel debugging with remote gdb"
> -	depends on DEBUG_KERNEL
> -	select DEBUG_INFO
> -	select FRAME_POINTER
> -	help
> -	  If you say Y here, it will be possible to remotely debug the
> -	  kernel using gdb. This enlarges your kernel image disk size by
> -	  several megabytes and requires a machine with more than 128 MB
> -	  RAM to avoid excessive linking time.
> -	  Documentation of kernel debugger available at
> -	  http://kgdb.sourceforge.net
> -	  This is only useful for kernel hackers. If unsure, say N.
> -
> -config KGDB_THREAD
> -	bool "KGDB: Thread analysis"
> -	depends on KGDB
> -	help
> -	  With thread analysis enabled, gdb can talk to kgdb stub to list
> -	  threads and to get stack trace for a thread. This option also enables
> -	  some code which helps gdb get exact status of thread. Thread analysis
> -	  adds some overhead to schedule and down functions. You can disable
> -	  this option if you do not want to compromise on speed.
> -
> -config KGDB_CONSOLE
> -	bool "KGDB: Console messages through gdb"
> -	depends on KGDB
> -	help
> -	  If you say Y here, console messages will appear through gdb.
> -	  Other consoles such as tty or ttyS will continue to work as usual.
> +source "kernel/Kconfig.kgdb"
>
>  config FRAME_POINTER
>  	bool "Compile the kernel with frame pointers"
> diff -zrupN linux-2.6.3+nothing/arch/ppc/Kconfig
> linux-2.6.3+config+serial/arch/ppc/Kconfig ---
> linux-2.6.3+nothing/arch/ppc/Kconfig	2004-02-27 12:16:14.403163398 -0700
> +++ linux-2.6.3+config+serial/arch/ppc/Kconfig	2004-02-27
> 12:16:13.771306387 -0700 @@ -1170,52 +1170,7 @@ config DEBUG_SPINLOCK_SLEEP
>  	  If you say Y here, various routines which may sleep will become very
>  	  noisy if they are called with a spinlock held.
>
> -config KGDB
> -	bool "Include kgdb kernel debugger"
> -	depends on DEBUG_KERNEL
> -	select DEBUG_INFO
> -	select FRAME_POINTER
> -	help
> -	  Include in-kernel hooks for kgdb, the Linux kernel source level
> -	  debugger.  See <http://kgdb.sourceforge.net/> for more information.
> -	  Unless you are intending to debug the kernel, say N here.
> -
> -choice
> -	prompt "Serial Port"
> -	depends on KGDB
> -	default KGDB_TTYS1
> -
> -config KGDB_TTYS0
> -	bool "ttyS0"
> -
> -config KGDB_TTYS1
> -	bool "ttyS1"
> -
> -config KGDB_TTYS2
> -	bool "ttyS2"
> -
> -config KGDB_TTYS3
> -	bool "ttyS3"
> -
> -endchoice
> -
> -config KGDB_THREAD
> -	bool "KGDB: Thread analysis"
> -	depends on KGDB
> -	help
> -	  With thread analysis enabled, gdb can talk to kgdb stub to list
> -	  threads and to get stack trace for a thread. This option also enables
> -	  some code which helps gdb get exact status of thread. Thread analysis
> -	  adds some overhead to schedule and down functions. You can disable
> -	  this option if you do not want to compromise on speed.
> -
> -config KGDB_CONSOLE
> -	bool "Enable serial console thru kgdb port"
> -	depends on KGDB && 8xx || 8260
> -	help
> -	  If you enable this, all serial console messages will be sent
> -	  over the gdb stub.
> -	  If unsure, say N.
> +source "kernel/Kconfig.kgdb"
>
>  config XMON
>  	bool "Include xmon kernel debugger"
> diff -zrupN linux-2.6.3+nothing/arch/x86_64/Kconfig
> linux-2.6.3+config+serial/arch/x86_64/Kconfig ---
> linux-2.6.3+nothing/arch/x86_64/Kconfig	2004-02-27 12:16:14.350175389 -0700
> +++ linux-2.6.3+config+serial/arch/x86_64/Kconfig	2004-02-27
> 12:16:13.718318378 -0700 @@ -465,37 +465,7 @@ config IOMMU_LEAK
>           Add a simple leak tracer to the IOMMU code. This is useful when
> you are debugging a buggy device driver that leaks IOMMU mappings.
>
> -config KGDB
> -	bool "KGDB: kernel debugging with remote gdb"
> -	depends on DEBUG_KERNEL
> -	select DEBUG_INFO
> -	select FRAME_POINTER
> -	help
> -	  If you say Y here, it will be possible to remotely debug the
> -	  kernel using gdb. This enlarges your kernel image disk size by
> -	  several megabytes and requires a machine with more than 128 MB
> -	  RAM to avoid excessive linking time.
> -	  Documentation of kernel debugger available at
> -	  http://kgdb.sourceforge.net
> -	  This is only useful for kernel hackers. If unsure, say N.
> -
> -config KGDB_THREAD
> -	bool "KGDB: Thread analysis"
> -	depends on KGDB
> -	help
> -	  With thread analysis enabled, gdb can talk to kgdb stub to list
> -	  threads and to get stack trace for a thread. This option also enables
> -	  some code which helps gdb get exact status of thread. Thread analysis
> -	  adds some overhead to schedule and down functions. You can disable
> -	  this option if you do not want to compromise on speed.
> -
> -config KGDB_CONSOLE
> -	bool "KGDB: Console messages through gdb"
> -	depends on KGDB
> -	help
> -	  If you say Y here, console messages will appear through gdb.
> -	  Other consoles such as tty or ttyS will continue to work as usual.
> -
> +source "kernel/Kconfig.kgdb"
>  endmenu
>
>  source "security/Kconfig"
> diff -zrupN linux-2.6.3+nothing/drivers/net/Kconfig
> linux-2.6.3+config+serial/drivers/net/Kconfig ---
> linux-2.6.3+nothing/drivers/net/Kconfig	2004-02-27 12:16:14.521136701 -0700
> +++ linux-2.6.3+config+serial/drivers/net/Kconfig	2004-02-27
> 12:06:22.000000000 -0700 @@ -187,12 +187,6 @@ config NET_ETHERNET
>  	  Note that the answer to this question won't directly affect the
>  	  kernel: saying N will just cause the configurator to skip all
>  	  the questions about Ethernet network cards. If unsure, say N.
> -
> -config KGDB_ETH
> -	bool "KGDB: On ethernet"
> -	depends on KGDB
> -	help
> -	  Uses ethernet interface for kgdb.
>
>  config MII
>  	tristate "Generic Media Independent Interface device support"
> diff -zrupN linux-2.6.3+nothing/drivers/serial/Kconfig
> linux-2.6.3+config+serial/drivers/serial/Kconfig ---
> linux-2.6.3+nothing/drivers/serial/Kconfig	2004-02-27 12:16:14.545131271
> -0700 +++ linux-2.6.3+config+serial/drivers/serial/Kconfig	2004-02-27
> 12:06:30.000000000 -0700 @@ -6,34 +6,6 @@
>
>  menu "Serial drivers"
>
> -config KGDB_8250
> -	bool "KGDB: On generic serial port (8250)"
> -	depends on KGDB
> -	help
> -	  Uses generic serial port (8250) for kgdb. This is independent of the
> -	  option 9250/16550 and compatible serial port.
> -
> -config KGDB_PORT
> -	hex "hex I/O port address of the debug serial port"
> -	depends on KGDB_8250
> -	default  3f8
> -	help
> -	  Some systems (x86 family at this writing) allow the port
> -	  address to be configured.  The number entered is assumed to be
> -	  hex, don't put 0x in front of it.  The standard address are:
> -	  COM1 3f8 , irq 4 and COM2 2f8 irq 3.  Setserial /dev/ttySx
> -	  will tell you what you have.  It is good to test the serial
> -	  connection with a live system before trying to debug.
> -
> -config KGDB_IRQ
> -	int "IRQ of the debug serial port"
> -	depends on KGDB_8250
> -	default 4
> -	help
> -	  This is the irq for the debug port.  If everything is working
> -	  correctly and the kernel has interrupts on a control C to the
> -	  port should cause a break into the kernel debug stub.
> -
>  #
>  # The new 8250/16550 serial drivers
>  config SERIAL_8250
> diff -zrupN linux-2.6.3+nothing/kernel/Kconfig.kgdb
> linux-2.6.3+config+serial/kernel/Kconfig.kgdb ---
> linux-2.6.3+nothing/kernel/Kconfig.kgdb	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.3+config+serial/kernel/Kconfig.kgdb	2004-02-27
> 12:16:13.000000000 -0700 @@ -0,0 +1,141 @@
> +config KGDB
> +	bool "KGDB: kernel debugging with remote gdb"
> +	depends on DEBUG_KERNEL
> +	select DEBUG_INFO
> +	select FRAME_POINTER
> +	# XXX: Doesn't work w/o this right now
> +	select KGDB_THREAD if PPC32
> +	help
> +	  If you say Y here, it will be possible to remotely debug the
> +	  kernel using gdb. This enlarges your kernel image disk size by
> +	  several megabytes and requires a machine with more than 128 MB
> +	  RAM to avoid excessive linking time.
> +	  Documentation of kernel debugger available at
> +	  http://kgdb.sourceforge.net
> +	  This is only useful for kernel hackers. If unsure, say N.
> +
> +choice
> +	prompt "Method for KGDB communication"
> +	depends on KGDB
> +	default PPC_SIMPLE_SERIAL if PPC32 && (8xx || 8260)
> +	default KGDB_8250
> +	help
> +	  There are a number of different ways in which you can communicate
> +	  with KGDB.  The oldest is using a serial driver.  A newer method
> +	  is to use UDP packets and a special network driver.
> +
> +config KGDB_8250
> +	bool "KGDB: On generic serial port (8250)"
> +	help
> +	  Uses generic serial port (8250) for kgdb. This is independent of the
> +	  option 9250/16550 and compatible serial port.
> +
> +config KGDB_ETH
> +	bool "KGDB: On ethernet"
> +	select NETPOLL
> +	select NETPOLL_TRAP
> +	select NETPOLL_RX
> +	help
> +	  Uses ethernet interface for kgdb.
> +
> +config PPC_SIMPLE_SERIAL
> +	bool "KGDB: On any serial port"
> +	depends on PPC32
> +	help
> +	  Use a very simple, and not necessarily feature complete serial
> +	  driver.  This is the only serial option currently for MPC8xx or
> +	  MPC82xx based ports that do not offer an 8250-style UART.
> +
> +endchoice
> +
> +config KGDB_SIMPLE_SERIAL
> +	bool "Simple selection of KGDB serial port"
> +	depends on KGDB_8250 || PPC_SIMPLE_SERIAL
> +	help
> +	  If you say Y here, you will only have to pick the baud rate
> +	  and serial port (ttyS) that you wish to use for KGDB.  If you
> +	  say N, you will have provide the I/O port and IRQ number.  Note
> +	  that if your serial ports are iomapped, then you must say Y here.
> +	  If in doubt, say Y.
> +
> +choice
> +	depends on KGDB_8250 || PPC_SIMPLE_SERIAL
> +    	prompt "Debug serial port BAUD"
> +	default KGDB_115200BAUD
> +	help
> +	  Gdb and the kernel stub need to agree on the baud rate to be
> +	  used.  Some systems (x86 family at this writing) allow this to
> +	  be configured.
> +
> +config KGDB_9600BAUD
> +	bool "9600"
> +
> +config KGDB_19200BAUD
> +	bool "19200"
> +
> +config KGDB_38400BAUD
> +	bool "38400"
> +
> +config KGDB_57600BAUD
> +	bool "57600"
> +
> +config KGDB_115200BAUD
> +	bool "115200"
> +endchoice
> +
> +choice
> +	prompt "Serial port for KGDB"
> +	depends on KGDB_SIMPLE_SERIAL
> +	default KGDB_TTYS0
> +
> +config KGDB_TTYS0
> +	bool "ttyS0"
> +
> +config KGDB_TTYS1
> +	bool "ttyS1"
> +
> +config KGDB_TTYS2
> +	bool "ttyS2"
> +
> +config KGDB_TTYS3
> +	bool "ttyS3"
> +
> +endchoice
> +
> +config KGDB_PORT
> +	hex "hex I/O port address of the debug serial port"
> +	depends on !KGDB_SIMPLE_SERIAL && (KGDB_8250 || PPC_SIMPLE_SERIAL)
> +	default  3f8
> +	help
> +	  Some systems (x86 family at this writing) allow the port
> +	  address to be configured.  The number entered is assumed to be
> +	  hex, don't put 0x in front of it.  The standard address are:
> +	  COM1 3f8 , irq 4 and COM2 2f8 irq 3.  Setserial /dev/ttySx
> +	  will tell you what you have.  It is good to test the serial
> +	  connection with a live system before trying to debug.
> +
> +config KGDB_IRQ
> +	int "IRQ of the debug serial port"
> +	depends on !KGDB_SIMPLE_SERIAL && (KGDB_8250 || PPC_SIMPLE_SERIAL)
> +	default 4
> +	help
> +	  This is the irq for the debug port.  If everything is working
> +	  correctly and the kernel has interrupts on a control C to the
> +	  port should cause a break into the kernel debug stub.
> +
> +config KGDB_THREAD
> +	bool "KGDB: Thread analysis"
> +	depends on KGDB
> +	help
> +	  With thread analysis enabled, gdb can talk to kgdb stub to list
> +	  threads and to get stack trace for a thread. This option also enables
> +	  some code which helps gdb get exact status of thread. Thread analysis
> +	  adds some overhead to schedule and down functions. You can disable
> +	  this option if you do not want to compromise on speed.
> +
> +config KGDB_CONSOLE
> +	bool "KGDB: Console messages through gdb"
> +	depends on KGDB
> +	help
> +	  If you say Y here, console messages will appear through gdb.
> +	  Other consoles such as tty or ttyS will continue to work as usual.

