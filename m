Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272160AbTHSG2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275365AbTHSG2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:28:31 -0400
Received: from [61.135.132.105] ([61.135.132.105]:4184 "EHLO smtp01.sohu.com")
	by vger.kernel.org with ESMTP id S272160AbTHSG2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:28:31 -0400
From: r6144 <r6k@sohu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16193.50055.259400.303737@localhost.localdomain>
Date: Tue, 19 Aug 2003 14:28:23 +0800
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test3] Sun JDK 1.4.2 doesn't exit properly using NPTL
X-Mailer: VM 7.14 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun JDK works fine with stock RH9 kernel with or without NPTL, and
under 2.6.0-test3 without NPTL.

When running it under 2.6.0-test3 with NPTL, the parent process (for
example bash) locks up after the java process exits.  Strace shows
that the parent had been waiting in wait4(), but isn't woken up when
the children (the java process) exits via exit_group().  Sending the
parent a SIGINT makes wait4() return -ECHILD and the parent continues
as normal.  The java process runs perfectly normally during its own
lifetime.

