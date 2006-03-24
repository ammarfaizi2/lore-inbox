Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWCXGVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWCXGVe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWCXGVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:21:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50407 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030243AbWCXGVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:21:33 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Announce: kdb v4.4 is available for kernel 2.6.16
In-reply-to: Your message of "Tue, 21 Mar 2006 16:59:24 +1100."
             <28258.1142920764@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 17:21:25 +1100
Message-ID: <14717.1143181285@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens (on Tue, 21 Mar 2006 16:59:24 +1100) wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>KDB (Linux Kernel Debugger) has been updated for kernel 2.6.16.
>
>ftp://oss.sgi.com/projects/kdb/download/v4.4/
>ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/
>
>Note:  Due to a spam attack, the kdb@oss.sgi.com mailing list is now
>subscriber only.  If you reply to this mail, you may wish to trim
>kdb@oss.sgi.com from the cc: list.

Updates to kdb v4.4-2.6.16-{common,i386,ia64}-1, moving to -2.  Mainly
to get more forceful with stuck cpus on IA64, where the "non-maskable"
interrupt is masked by local_irq_disable().

We finally get decent backtraces on stuck IA64 cpus.  It took a long
time to get there, KDB could not change until the base kernel could
cope with INIT and recover correctly.

2006-03-22 Keith Owens  <kaos@sgi.com>

	* Add some more xpc flags.  Dean Nelson, SGI.
	* Replace open coded counter references with atomic_read().
	* Pass early_uart_console to early_uart_setup().  Francois
	  Wellenreiter, Bull.
	* Replace open code with for_each_online_cpu().
	* If cpus do not come into kdb after a few seconds then let
	  architectures send a more forceful interrupt.
	* Close a timing race with KDB_ENTER_SLAVE.
	* kdb v4.4-2.6.16-common-2.

2006-03-24 Keith Owens  <kaos@sgi.com>

	* Define a dummy kdba_wait_for_cpus().
	* kdb v4.4-2.6.16-i386-2.

2006-03-24 Keith Owens  <kaos@sgi.com>

	* Use INIT to interrupt cpus that do not respond to a normal kdb IPI.
	* Remove KDBA_MCA_TRACE from arch/ia64/kernel/mca.c.
	* kdb v4.4-2.6.16-ia64-2.

