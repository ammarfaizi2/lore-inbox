Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752552AbWAHHOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbWAHHOW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbWAHHOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:14:22 -0500
Received: from spooner.celestial.com ([192.136.111.35]:61078 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1752552AbWAHHOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:14:22 -0500
Date: Sun, 8 Jan 2006 02:14:16 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
Message-ID: <20060108071416.GD26614@kurtwerks.com>
Mail-Followup-To: Mitchell Blank Jr <mitch@sfgoth.com>,
	Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136544309.2940.25.camel@laptopd505.fenrus.org> <20060107190531.GB8990@kurtwerks.com> <1136663088.2936.36.camel@laptopd505.fenrus.org> <20060108031605.GB26614@kurtwerks.com> <20060108035622.GP27284@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108035622.GP27284@gaz.sfgoth.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 07:56:22PM -0800, Mitchell Blank Jr took 0 lines to write:
> Kurt Wall wrote:
> >    text	   data	    bss	    dec	    hex	filename
> > 2577982	 462352	 479920	3520254	 35b6fe	vmlinux.344.NO_OPT
> > 2620255	 462336	 479984	3562575	 365c4f	vmlinux.442.NO_OPT
> > 2326785	 462352	 479920	3269057	 31e1c1	vmlinux.344.OPT
> > 2227294	 502680	 479984	3209958	 30fae6	vmlinux.442.OPT
> 
> And idea what's up with the .data size there?  The first three are almost
> exactly the same (as you'd expect) and then the last one jumps up by 40K.
> Is there something normally in a different section that goes into normal
> .data only in that congiguration?  Might be worth looking at with:
> 	objdump -h vmlinux | egrep -v 'CONTENTS|ALLOC'

Given that I don't really understand what I'm looking at in this output, 
all this really shows me is that, yes, .data is ~40K larger. I'd think
what we're really interested in is the contents of .data. I don't
read hex as well as I read decimal, so I converted it):

                 Section  344.OPT      442.OPT         Delta
                 -------------------------------------------
                   .text  2135463      1783653       -351810
              __ex_table    17648        16768          -880
                 .rodata   239127       217865        -21262
              .pci_fixup     2112         2112             0
              .rio_route        0            0             0
               __ksymtab    34352        34352             0
           __ksymtab_gpl     5808         5808             0
               __kcrctab    17176        17176             0
           __kcrctab_gpl     2904         2904             0
       __ksymtab_strings    54818        54818             0
                 __param     2360         2360             0
                   .data   386816       427160         40344
                    .bss   479984       479984             0
 .data.cacheline_aligned    16896        16896             0
       .data.read_mostly     3104         3104             0
             .vsyscall_0      295          255           -40
             .xtime_lock        4            4             0
                 .vxtime       48           48             0
           .wall_jiffies        8            8             0
                 .sys_tz        8            8             0
        .sysctl_vsyscall        4            4             0
                  .xtime       16           16             0
                .jiffies        8            8             0
             .vsyscall_1       41           40            -1
             .vsyscall_2        8            8             0
             .vsyscall_3        8            8             0
         .data.init_task     8192         8192             0
              .init.text   106076        87536        -18540
              .init.data    44016        44016             0
             .init.setup     2160         2160             0
          .initcall.init     1048         1048             0
      .con_initcall.init        8            8             0
 .security_initcall.init        0            0             0
        .altinstructions      331          307           -24
   .altinstr_replacement       46           43            -3
              .exit.text     1548         1147          -401
             .init.ramfs      134          134             0
                .comment    11592        11592             0
         .note.GNU-stack        0            0             0

Kurt
-- 
It is easier to write an incorrect program than understand a correct
one.
