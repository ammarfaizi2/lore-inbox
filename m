Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275920AbSIUPHx>; Sat, 21 Sep 2002 11:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275921AbSIUPHx>; Sat, 21 Sep 2002 11:07:53 -0400
Received: from mail.rpi.edu ([128.113.22.40]:44282 "EHLO mail.rpi.edu")
	by vger.kernel.org with ESMTP id <S275920AbSIUPHw>;
	Sat, 21 Sep 2002 11:07:52 -0400
Date: Sat, 21 Sep 2002 11:12:51 -0400 (EDT)
From: Hua Qin <qinhua@poisson.ecse.rpi.edu>
To: linux-kernel@vger.kernel.org
Subject: Appache server hung after run out of memory
Message-ID: <Pine.GSO.4.10.10209211103430.3973-100000@poisson.ecse.rpi.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got a Appache server hung, and the error_log showed on  Appache server: 
(12)Cannot allocate memory 	
(105)No buffer space available: write to cgi daemon process

Then I dropped this server to kdb and did backtrace:

PID: 23406  TASK: e0e70000  CPU: 1   COMMAND: "httpd"
   START: swap_out_pmd+234
e0e71d40: swap_out_vma+181
e0e71d78: smp_call_function_interrupt+50
e0e71d98: swap_out_mm+83
e0e71dc0: swap_out+184
e0e71de0: refill_inactive_zone+44
e0e71e04: refill_inactive+73
e0e71e24: do_try_to_free_pages+66
e0e71e40: try_to_free_pages+42
e0e71e54: _wrapped_alloc_pages+450
e0e71e74: __alloc_pages+18
e0e71e94: __get_free_pages+19
e0e71e9c: pte_alloc+151
e0e71ed8: copy_page_range+338
e0e71f04: __alloc_pages_limit+134
e0e71f1c: copy_mm+498
e0e71f64: do_fork+1269
e0e71f84: filp_close+158
e0e71fa8: sys_fork+22
e0e71fc0: system_call+51


I am wondering what will cause this swap_out_pmd hung? I did turn on the
swapon, and the swap patition size is 514072. I did not check how many
swap had been used when the hung happened.

The Appache version is 2.0 and Linux kernelis 2.4.7 (I know it's a little
bit old).

Thanks!
Hua

