Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUBPWyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUBPWvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:51:09 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:11479 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S265965AbUBPWsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:48:21 -0500
Message-ID: <40314897.7040805@oracle.com>
Date: Mon, 16 Feb 2004 23:47:51 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: linux-acpi <linux-acpi@intel.com>
Subject: 2.6.3-rc3 (and possibly earlier 2.6): weird hang and oopses
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC:ing linux-acpi since some acpi stuff appears in backtraces]

While apparently doing nothing special (possibly a 'rm' on a
  regular ext3 filesystem) my laptop hung. Not completely, as
  I could

  * switch virtual desktops within Ximian Desktop 2
  * click on the kill window top right button, see the "app is
     not responding, kill it anyway ?" dialog, say ok, see the
     gnome-terminal vanish
  * Alt-Fn to virtual consoles, type a login name (but getting
     no prompt for the password - this hung)
  * Alt-SysRq


Trying to get more info, I Alt-SysRq-P seeing this (handcopied
  but should be fairly reliable :) :


Pid: 0, comm:     swapper
EIP: 0060: acpi_processor_idle+0x13c/0x1cb

  default_idle+0x0/0x27
  rest_init+0x0/0x5e
  acpi_nt_copy_ipackage_to_ipackage+0x69/0xdb
  default_idle+0x0/0x27
  rest_init+0x0/0x5e
  cpu_idle+0x2e/0x37
  start_kernel+0x182/0x1b0
  unknown_bootoption+0x0,0xff


While copying this down, there were 'ps' oopses at regular
  intervals (say 2/3 minutes apart from each other), with this
  further oops trace:

  pid_revalidate+0x28/0xd2
  pid_revalidate+0x41/0xd2
  dput+0x22/0x21f
  link_path_walk+0x61b/0x957
  buffered_rmqueue+0xc1/0x15a
  __alloc_pages+0xa4/0x342
  proc_info_read+0x74/0x155
  filp_open+0x67/0x69
  vfs_read+0xbc/0x127
  sys_read+0x42/0x63
  sysenter_past_esp+0x52/0x71

And right after each oops a further trace, with the warning
  that 'ps' exited with a preempt_count of 1:

Bad: scheduling while atomic

  schedule
  unmap_page_range
  unmap_vmas
  exit_mmap
  mmput
  do_exit
  do_divide
  do_page_fault
  acpi_processor_set_performance
  error_code
  file_read_actor

There was more, but I couldn't copy further info due to pressing
  time constraints. This isn't the first time a 2.6.x kernel hangs
  on me, and IIRC 2.6.1 never did.


Oh, and of course I still can't Alt-SysRq-B :(


Thanks for looking into this, ciao,

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

