Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264309AbUENGEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbUENGEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 02:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUENGEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 02:04:36 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:54829 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264309AbUENGEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 02:04:35 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6 echo > /proc/sys/kernel/foo not invoking strategy routine
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 May 2004 16:04:30 +1000
Message-ID: <14071.1084514670@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel/sysctl.c, you can define a ctl_table entry that has a
proc_handler of proc_dointvec and also define your own strategy
routine.  It turns out that the strategy routine is not called, despite
the comments saying it should be.  echo 1 > /proc/sys/kernel/foo
invokes sys_write() -> proc_writesys() -> do_rw_proc() ->
proc_dointvec() and completely ignores the strategy field.  The
strategy is only used on the do_sysctl() path, which is deprecated.  Is
this deliberate?

