Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263898AbUENH3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUENH3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 03:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUENH3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 03:29:45 -0400
Received: from mail1.eivd.ch ([193.134.216.148]:4540 "EHLO mail1.eivd.ch")
	by vger.kernel.org with ESMTP id S263898AbUENH3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 03:29:42 -0400
From: Antille Julien <julien.antille@eivd.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: keventd takes 99% of CPU when laptop lid is closed
Date: Fri, 14 May 2004 09:29:20 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200405132026.46505.julien.antille@eivd.ch> <20040513190842.2cfada4d.akpm@osdl.org>
In-Reply-To: <20040513190842.2cfada4d.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405140929.20879.julien.antille@eivd.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the ouput I get from the command you requested me to do:

c02064a8 acpi_ut_update_object_reference               5   0,0095
c0137e10 kmalloc                                       6   0,0163
c01f48d7 acpi_ds_result_pop                            6   0,0769
c01f9ab3 acpi_ex_name_segment                          6   0,0455
c01fec80 acpi_ns_search_and_enter                      6   0,0234
c01ff4b4 acpi_ns_walk_namespace                        6   0,0246
c0207994 acpi_ut_create_update_state_and_push          6   0,1200
c01f3d7d acpi_ds_exec_end_op                           7   0,0113
c0200855 acpi_ps_next_parse_state                      7   0,0355
c02013eb acpi_ps_pop_scope                             8   0,0800
c01f3c6d acpi_ds_exec_begin_op                         9   0,0331
c01f4b86 acpi_ds_create_walk_state                     9   0,0818
c0201857 acpi_ps_delete_parse_tree                     9   0,0621
c0207542 acpi_ut_valid_acpi_name                       9   0,1915
c01fdb18 acpi_ns_lookup                               10   0,0134
c02006f0 acpi_ps_complete_this_op                     10   0,0280
c02014b7 acpi_ps_append_arg                           10   0,0787
c01fbac2 acpi_ex_resolve_operands                     11   0,0139
c020173c acpi_ps_get_next_walk_op                     11   0,0417
c0200500 acpi_ps_get_next_arg                         14   0,0368
c01f2884 acpi_ds_method_data_init                     15   0,1402
c020067c acpi_ps_get_opcode_info                      17   0,2576
c01febe0 acpi_ns_search_node                          18   0,2727
c01f1a97 acpi_os_get_thread_id                        21   0,6000
c01ff439 acpi_ns_get_parent_node                      22   0,7586
c020091a acpi_ps_parse_loop                           44   0,0205
c01ff456 acpi_ns_get_next_valid_node                  48   2,6667
c0207928 acpi_ut_release_mutex                        53   0,4907
c010ac60 handle_IRQ_event                             72   0,4091
c01f153e acpi_os_write_port                           72   1,0909
c020585a acpi_ut_acquire_from_cache                   75   0,4601
c02057d0 acpi_ut_release_to_cache                     76   0,5507
c02078b6 acpi_ut_acquire_mutex                        95   0,8333
c01ff468 acpi_ns_get_next_node                       108   1,4211
c01fe00e acpi_ns_delete_namespace_by_owner           127   0,8038
c01f14ef acpi_os_read_port                           167   2,1139
c01f1985 acpi_os_wait_semaphore                      202   0,9395
c01f1a5c acpi_os_signal_semaphore                    254   5,7727
c020c4d3 acpi_processor_idle                        1205   2,5262
00000000 total                                      3042   0,0014

I hope that helps.

Julien Antille

On Friday 14 May 2004 04.08, Andrew Morton wrote:
> Antille Julien <julien.antille@eivd.ch> wrote:
> > On 2.4.26, 2.6.5 and 2.6.6, the kernel process keventd takes 99% of CPU
> > when my laptop's lid is closed. It comes back to normal when I open it
> > again. Laptop is a DELL Inspirion 2650.
> >
> > This problem did not occure with <=2.4.25 or <= 2.6.4
>
> Can you please generate a kernel profile?
>
> Boot with the "profile=1" kernel command line option.
>
> sudo readprofile -r
> <close lid>
> <wait 30 seconds>
> <open lid>
> sudo readprofile -n -v -m /wherever/System.map | sort -n +2 | tail -40 >
> foo
>
> And send us foo?
>
> Make sure that you use the System.map which corresponds to the
> currently-running kernel.
>
> Thanks.
