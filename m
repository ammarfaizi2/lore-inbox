Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUI0UD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUI0UD5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUI0UD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:03:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30215 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267304AbUI0UDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:03:09 -0400
Date: Mon, 27 Sep 2004 21:03:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC] ARM binutils feature churn causing kernel problems
Message-ID: <20040927210305.A26680@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The ARM binutils seems to be in a problematical state at the moment.
It has recently had a "bug" fixed where ARM specific "mapping symbols"
were not generated in ELF objects.  These "mapping symbols" have names
such as "$a" and "$d".

The unfortunate problem is that "$a" nearly always corresponds with
the same address as the name of a function - and since none of the
kernel knows about these "mapping symbols" we see backtraces which
effectively say:

[<address>] ($a+0xfoo/0xbar) from [<address>] ($a+0xfoo/0xbar)

in other words, the kallsyms table and the symbol tables from kernel
modules are next to useless because it invariably decodes all addresses
to functions named "$a".

While the binutils people have (we believe) fixed "ld" to ignore
these symbols when decoding to a function name, "nm" reveals these
symbols.

It may be true that this will cause a lot of stuff which parses
ELF objects to break, and I'm not going to debate whether the whole
idea is a good one or bad.  However, what are peoples (Rusty's in
particular) to adding yet more ARM binutils specific hacks to the
kernel to work around these continuing problems?

My major worry is that ARM ELF format will end up having soo many
extra "features" that the Linux kernel, if it's going to continue
supporting ARM, will need a fair amount of code to make all these
features "work" as expected.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
