Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266029AbUBQG0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbUBQG0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:26:41 -0500
Received: from fmr03.intel.com ([143.183.121.5]:28076 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266029AbUBQG0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:26:37 -0500
Subject: Re: 2.6.3-rc3 (and possibly earlier 2.6): weird hang and oopses
From: Len Brown <len.brown@intel.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F214C@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F214C@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076999173.2508.30.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Feb 2004 01:26:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro,
Sure looks like a failure in the ACPI processor driver.

Please confirm your system is otherwise happy when you disable the
processor driver.  eg. CONFIG_ACPI_PROCESSOR=n

Also, it would be helpful to know if this failure started recently or
you saw it in previous releases, b/c we've made some changes to the
processor driver recently.

thanks,
-Len

ps. acpi-devel@lists.sourceforge.net is the preferred alias to send
Linux ACPI issues -- it includes linux-acpi@intel.com which is a small
sub-set.

On Mon, 2004-02-16 at 17:47, Alessandro Suardi wrote:
> [CC:ing linux-acpi since some acpi stuff appears in backtraces]
> 
> While apparently doing nothing special (possibly a 'rm' on a
>   regular ext3 filesystem) my laptop hung. Not completely, as
>   I could
> 
>   * switch virtual desktops within Ximian Desktop 2
>   * click on the kill window top right button, see the "app is
>      not responding, kill it anyway ?" dialog, say ok, see the
>      gnome-terminal vanish
>   * Alt-Fn to virtual consoles, type a login name (but getting
>      no prompt for the password - this hung)
>   * Alt-SysRq
> 
> 
> Trying to get more info, I Alt-SysRq-P seeing this (handcopied
>   but should be fairly reliable :) :
> 
> 
> Pid: 0, comm:     swapper
> EIP: 0060: acpi_processor_idle+0x13c/0x1cb
> 
>   default_idle+0x0/0x27
>   rest_init+0x0/0x5e
>   acpi_nt_copy_ipackage_to_ipackage+0x69/0xdb
>   default_idle+0x0/0x27
>   rest_init+0x0/0x5e
>   cpu_idle+0x2e/0x37
>   start_kernel+0x182/0x1b0
>   unknown_bootoption+0x0,0xff
> 
> 
> While copying this down, there were 'ps' oopses at regular
>   intervals (say 2/3 minutes apart from each other), with this
>   further oops trace:
> 
>   pid_revalidate+0x28/0xd2
>   pid_revalidate+0x41/0xd2
>   dput+0x22/0x21f
>   link_path_walk+0x61b/0x957
>   buffered_rmqueue+0xc1/0x15a
>   __alloc_pages+0xa4/0x342
>   proc_info_read+0x74/0x155
>   filp_open+0x67/0x69
>   vfs_read+0xbc/0x127
>   sys_read+0x42/0x63
>   sysenter_past_esp+0x52/0x71
> 
> And right after each oops a further trace, with the warning
>   that 'ps' exited with a preempt_count of 1:
> 
> Bad: scheduling while atomic
> 
>   schedule
>   unmap_page_range
>   unmap_vmas
>   exit_mmap
>   mmput
>   do_exit
>   do_divide
>   do_page_fault
>   acpi_processor_set_performance
>   error_code
>   file_read_actor
> 
> There was more, but I couldn't copy further info due to pressing
>   time constraints. This isn't the first time a 2.6.x kernel hangs
>   on me, and IIRC 2.6.1 never did.
> 
> 
> Oh, and of course I still can't Alt-SysRq-B :(
> 
> 
> Thanks for looking into this, ciao,
> 
> --alessandro
> 
>   "Two rivers run too deep
>    The seasons change and so do I"
>        (U2, "Indian Summer Sky")
> 

