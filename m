Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUAQGu4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 01:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUAQGu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 01:50:56 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:38557 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261464AbUAQGuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 01:50:55 -0500
Message-ID: <4008DB4D.8090407@comcast.net>
Date: Sat, 17 Jan 2004 00:50:53 -0600
From: Ian Pilcher <i.pilcher@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: More info on VP6 panics
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Background:  I get a kernel panic when I boot 2.4.2{2,3,4} with ACPI on
my dual-processor Abit VP6.  Compiling the kernel with CONFIG_DEBUG_SLAB
turned on allows it to boot, as does booting with "idle=poll".

I do not believe that the panic occurs anywhere in the ACPI code.  From
what I can tell, the transition to ACPI mode causes the idle thread on
the other processor to panic.

I believe that I have identified the line of code that triggers the
panic.  It is the actual transition to ACPI mode at
drivers/acpi/hardware/hwacpi.c, line 143.  If I insert an infinite loop
before the call to acpi_os_write_port, the boot process simply hangs.
If I move the loop below the call to acpi_os_write_port, I get the same
old panic message.

How can I debug this further?

Thanks!
-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

