Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271700AbTHDKoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 06:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271701AbTHDKoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 06:44:01 -0400
Received: from iv.ro ([194.105.28.94]:31906 "HELO iv.ro") by vger.kernel.org
	with SMTP id S271700AbTHDKn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 06:43:59 -0400
Date: Mon, 4 Aug 2003 13:58:19 +0300
From: Jani Monoses <jani@iv.ro>
To: linux-kernel@vger.kernel.org
Subject: hwclock causes __might_sleep dump
Message-Id: <20030804135819.462edada.jani@iv.ro>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

at system shutdown when hwclock --systohc is called there's a
might_sleep error dump from the kernel in do_page_fault. I found that
the problem is when hwclock uses direct cmos access when there's no RTC
support in kernel and only when hwclock is compiled with -O3 
hwclock does an atomic access achieved with __asm__ cli and sti. Is this
a hwclock bug? I suppose the kernel is not responsible for userland
disabling interrupts ... putting delays and printfs in hwclock either
makes the dump show a different backtrace (although still with 2
do_page_faults) or results in no dump at all. 

2.6.0-test1 and test2
