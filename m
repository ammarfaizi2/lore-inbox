Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTEZW4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTEZW4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:56:45 -0400
Received: from web41504.mail.yahoo.com ([66.218.93.87]:59801 "HELO
	web41504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262283AbTEZW4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:56:44 -0400
Message-ID: <20030526230956.65746.qmail@web41504.mail.yahoo.com>
Date: Mon, 26 May 2003 16:09:56 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Re: 'fscope': a new debugging tool
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Output from 'fscope -func=add_to_swap_cache -cycles',
 questions follow:

 1      cycle detected add_to_swap_cache read_swap_cache_async 
do_swap_page handle_pte_fault handle_mm_fault get_user_pages 
make_pages_present find_extend_vma get_user_pages
 2      cycle detected add_to_swap_cache read_swap_cache_async 
do_swap_page handle_pte_fault handle_mm_fault __verify_write 
access_ok clear_user __do_clear_user clear_user
 3      cycle detected add_to_swap_cache read_swap_cache_async 
do_swap_page handle_pte_fault handle_mm_fault __verify_write 
access_ok clear_user __do_clear_user __clear_user clear_user
 4      cycle detected add_to_swap_cache read_swap_cache_async 
do_swap_page handle_pte_fault handle_mm_fault __verify_write 
access_ok copy_from_user ax25_rt_ioctl ax25_protocol_function 
ax25_rx_iframe ax25_ds_state3_machine ax25_ds_frame_in 
ax25_process_rx_frame ax25_rcv ax25_kiss_rcv ax25_protocol_function
 5      cycle detected add_to_swap_cache read_swap_cache_async 
do_swap_page handle_pte_fault handle_mm_fault __verify_write 
access_ok copy_from_user ax25_rt_ioctl ax25_protocol_function 
ax25_rx_iframe ax25_protocol_function
 6      cycle detected add_to_swap_cache read_swap_cache_async 
do_swap_page handle_pte_fault handle_mm_fault __verify_write 
access_ok copy_from_user command ACOMMAND com90xx_probe arcnet_init 
com90xx_probe
 7      cycle detected add_to_swap_cache read_swap_cache_async 
do_swap_page handle_pte_fault handle_mm_fault __verify_write 
access_ok copy_from_user __copy_from_user copy_from_user
 8-104  cycle detected add_to_swap_cache read_swap_cache_async 
do_swap_page handle_pte_fault handle_mm_fault __verify_write 
access_ok copy_from_user COPY_FROM_USER write 
acpi_os_write_pci_configuration acpi_hw_low_level_write 
acpi_hw_disable_gpe_block .. [too many variants to list]

QUESTIONS

0) The fields go from innermost frame to outermost frame.
The last field is the outermost. So read them backwards,
until the last field repeats - there's your cycle.

1) These are merely _potentially_ dangerous cycles in the
code - so what is a good heuristic to decide which ones
to investigate?

2) Why in this case are there 12 times as many instances
found for the ACPI stuff as for the rest of the kernel?
Is ACPI a can of worms or what?

