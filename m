Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVA3MQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVA3MQU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 07:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVA3MQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 07:16:20 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:51914 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261691AbVA3MQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 07:16:18 -0500
Date: Sun, 30 Jan 2005 13:15:49 +0100
From: Michael Gernoth <simigern@stud.uni-erlangen.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org,
       Matthias Koerber <simakoer@stud.informatik.uni-erlangen.de>,
       scott.feldman@intel.com, ganesh.venkatesan@intel.com
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
Message-ID: <20050130121549.GA23946@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org,
	Matthias Koerber <simakoer@stud.informatik.uni-erlangen.de>,
	scott.feldman@intel.com, ganesh.venkatesan@intel.com
References: <20050128164811.GA8022@cip.informatik.uni-erlangen.de> <20050129181821.GA2128@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129181821.GA2128@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 04:18:21PM -0200, Marcelo Tosatti wrote:
> Probably a task event is rescheduling itself repeatedly? e100 does not seem 
> to schedule_task() events directly, so I wonder what is going on.
> 
> Can you boot a machine with profile=2, then send the WOL packet causing
> keventd to go mad and run:
> 
> readprofile | sort -nr +2 | head -20

faui07c:~# readprofile | sort -nr +2 | head -20
  2352 acpi_ns_get_next_valid_node              130.6667
  9577 acpi_os_read_port                        121.2278
  4431 acpi_os_signal_semaphore                 100.7045
  4639 default_idle                              57.9875
  4363 acpi_ns_get_next_node                     57.4079
  5957 acpi_ns_delete_namespace_by_owner         37.7025
  2307 acpi_os_write_port                        34.9545
  4048 acpi_os_wait_semaphore                    18.8279
  1924 acpi_ut_acquire_mutex                     16.8772
   492 __rdtsc_delay                             15.3750
   526 acpi_os_get_thread_id                     15.0286
  1421 acpi_ut_release_mutex                     13.1574
   339 acpi_ns_get_parent_node                   11.6897
  1506 acpi_ut_release_to_cache                  10.9130
  1600 acpi_ut_acquire_from_cache                 9.8160
   909 acpi_ds_method_data_init                   8.4953
   327 acpi_ut_valid_acpi_name                    6.9574
   311 acpi_ns_search_node                        4.7121
   268 acpi_ps_get_opcode_info                    4.0606
    31 acpi_ut_delete_generic_state_cache         3.4444

The machine has an uptime of 10 minutes at that point, and the second
WOL packet was sent directly after the machine came up and I was able
to ssh into it.

Regards,
  Michael
