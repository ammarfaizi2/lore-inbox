Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbUCLUxC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbUCLUwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:52:39 -0500
Received: from waste.org ([209.173.204.2]:56002 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262520AbUCLUpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:45:06 -0500
Date: Fri, 12 Mar 2004 14:44:58 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bloat report 2.6.3 -> 2.6.4
Message-ID: <20040312204458.GJ20174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on an automated scheme to measure the growth of the kernel
from release to release. The current methodology is to do comparisons
from x to y, with the default config for x in both cases.  This is
automated with bloat-o-meter from linux-tiny and my kpatchup script
(http://selenic.com/kpatchup) plus a couple glue scripts. I intend to
post these reports regularly with new releases so comments on
improving the content are appreciated.

Here's a current sample report [with some explanatory comments
interspersed].

2.6.3 -> 2.6.4

   text	   data	    bss	    dec	    hex	filename
3313135	 660247	 162472	4135854	 3f1bae	vmlinux-2.6.3-c2.6.3
3342019	 664154	 162344	4168517	 3f9b45	vmlinux-2.6.4-c2.6.3

[ Results of size <a> <b>. -c2.6.3 means both kernel images were built
with the 2.6.3 defconfig. The dec column tells us that the 2.6.4
kernel image has grown by almost 1% in one release. Output from
bloat-o-meter follows.]

add/remove: 241/88 grow/shrink: 380/265 up/down: 44772/20838

[ A quick summary of modifications. 241 new symbols in 2.6.4, 88
disappeared, 380 functions grew, 265 shrank, and total growth and
shrinkage of listed symbols]

[ Next we list the growth and shrinkage of given functions, sorted by
delta. Symbols that aren't present in a given version are reported as
- and treated as size zero. I'm currently only listing the top 15 gainers
and decliners in the report to keep things manageable, though
bloat-o-meter will generate a complete list. ]

function                                     old     new   delta
n_tty_receive_buf                           1991    4450   +2459
_csr1212_read_keyval                           -    1253   +1253
hpsb_allocate_and_register_addrspace           -    1139   +1139
iso_stream_schedule                            -     820    +820
do_shmat                                       -     767    +767
csr1212_append_new_cache                       -     519    +519
csr1212_generate_csr_image                     -     510    +510
iso_stream_init                                -     505    +505
csr1212_new_icon_descriptor_leaf               -     409    +409
early_serial_init                              -     398    +398
inet_confirm_addr                              -     374    +374
csr1212_parse_dir_entry                        -     350    +350
setup_early_printk                             -     349    +349
do_unblank_screen                              -     348    +348
csr1212_generate_tree_subdir                   -     342    +342
...
iso_stream_find                              495     199    -296
parport_parse_params                         321       -    -321
parport_setup                                749     419    -330
itd_stream_schedule                          342       -    -342
nodemgr_read_text_leaf                       348       -    -348
rpc_proc_read                                350       -    -350
svc_proc_read                                361       -    -361
read_businfo_block                           436       -    -436
nodemgr_scan_root_directory                  470       -    -470
acpi_boot_init                               684     157    -527
nodemgr_scan_unit_directory                  541       -    -541
ide_end_taskfile                             589       -    -589
sys_shmat                                    767       -    -767
ohci_init_config_rom                         955       -    -955
n_tty_receive_char                          2037       -   -2037

[ Note that renames like sys_shmat to do_shmat show up in the top and
the bottom. ]

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
