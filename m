Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTFFJ7n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 05:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTFFJ7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 05:59:43 -0400
Received: from are.twiddle.net ([64.81.246.98]:53384 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261422AbTFFJ7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 05:59:42 -0400
Date: Fri, 6 Jun 2003 03:13:13 -0700
From: Richard Henderson <rth@twiddle.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Shared Library starter, ld.so
Message-ID: <20030606101313.GA28939@twiddle.net>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0306051045180.6171@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0306051045180.6171@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 10:46:18AM -0400, Richard B. Johnson wrote:
> The dynamic linker, provided with RedHat 9 no longer
> compiles with the de facto standard of having register
> EDX point to function to be called before exit.

You're wrong.  Indeed, the rh9 crt1.o still expects the value:


   8:   50                      push   %eax
   9:   54                      push   %esp
   a:   52                      push   %edx		<<==== HERE
   b:   68 00 00 00 00          push   $0x0
                        c: R_386_32     __libc_csu_fini
  10:   68 00 00 00 00          push   $0x0
                        11: R_386_32    __libc_csu_init
  15:   51                      push   %ecx
  16:   56                      push   %esi
  17:   68 00 00 00 00          push   $0x0
                        18: R_386_32    main
  1c:   e8 fc ff ff ff          call   1d <_start+0x1d>
                        1d: R_386_PC32  __libc_start_main

and ld.so provides the value here:

        # Pass our finalizer function to the user in %edx, as per ELF ABI.\n\
        leal _dl_fini@GOTOFF(%ebx), %edx\n\



r~
