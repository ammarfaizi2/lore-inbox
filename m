Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbTKMS0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 13:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTKMS0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 13:26:08 -0500
Received: from auth22.inet.co.th ([203.150.14.104]:37389 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S264397AbTKMS0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 13:26:01 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Keith Owens <kaos@sgi.com>
Subject: Re: 2.4.22 hangs upon echo > /proc/acpi/alarm
Date: Fri, 14 Nov 2003 02:24:43 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <2758.1068686462@kao2.melbourne.sgi.com>
In-Reply-To: <2758.1068686462@kao2.melbourne.sgi.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311140224.43459.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 November 2003 09:21, Keith Owens wrote:
> On Wed, 12 Nov 2003 20:33:18 +0800, 
> Michael Frank <mhf@linuxmail.org> wrote:
> >ACPI version is 20031002
> >
> >Initial backtrace obtained with kdb:
> >
> >acpi_os_read_port+36
> >acpi_hw_lowlevel_read+7b
> >acpi_ev_gpe_detect+94
> >acpi_ev_sci_xrupt_handler+3c
> >acpi_irq+d
> >handle_IRQ_event+31
> >do_IRQ+72
> >call_do_IRQ+5
> >do_softirq+5a
> >do_IRQ+a1
> >proc_file_write+9b
> >sys_write+be
> >system_call+33
> >
> >Further stepping shows endless loop around:
> >
> >acpi_ev_gpe_detect+80
> >  acpi_hw_lowlevel_read
> >    acpi_os_read_port
> >    acpi_ut_get_region_name
> >    acpi_ut_debug_print 
> >  acpi_ut_debug_print
> >  jmp acpi_ev_gpe_detect+80
> >
> >Debugging is compiled in, but no meesages go to dmesg
> >
> >How to enable acpi_ut_debug_print output?
> 
> printk() can be called from anywhere but the text is only stored in the
> log buffer.  The text is written from the log buffer to the console or
> syslog when the kernel is not running in interrupt context.  This is a
> common problem with printk, you get no output when debugging interrupt
> problems.
> 
> Since you have already applied the kdb patch, change acpi to add
> #include <linux/kdb.h> and call kdb_printf() instead of printk for
> debugging messages.  kdb_printf uses polling mode I/O so you get the
> output immediately.
> 

Thank you for your reply. I'll make good use of kdb_printf in future.

In this case however the messages did not even go into the dmesg buffer
as the acpi debug output (via its own printf) must be enabled by debug 
section flags which were disabled. I'll file a bug report against acpi asap.

I have two questions about kdb 3.0, x86 hw on 2.4.22 kernel

 - is there any netpoll interface for kdb for legacy free hw wo serial port.
 - on another non-acpi machine kdb hangs permanently and blinking kbleds stop once 
    - any key is pressed on the at keyboard 
    - after about a minute inside kdb (operating via serial port)


Regards
Michael

