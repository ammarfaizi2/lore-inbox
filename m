Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbULAD4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbULAD4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 22:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbULAD4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 22:56:03 -0500
Received: from smtp6.mindspring.com ([207.69.200.110]:58171 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id S261216AbULADz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 22:55:57 -0500
Message-Id: <5.1.0.14.2.20041130225221.009d1340@pop.mindspring.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 30 Nov 2004 22:55:41 -0500
To: roland@redhat.com
From: Joe Korty <kortyads@mindspring.com>
Subject: waitid breaks telnet
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ 2nd send, this one from my home email account...]

telnet no longer works:

     # chkconfig telnet on
     # telnet localhost
     Trying 127.0.0.1...
     Connected to localhost (127.0.0.1).
     Escape character is '^]'.
     Red Hat Enterprise Linux WS release 3 (Taroon Update 2)
     Kernel 2.6.10-rc2 on an i686
     Connection closed by foreign host.

A bsearch placed the bug between 2.6.9-rc1-bk[78], another
bsearch on the changesets showed the problem is caused
by this patch:

     roland@redhat.com[torvalds]|ChangeSet|20040831173525|30767
     [PATCH] waitid system call

My guess is, something about the new wait4(2) wrapper
is causing the telnet daemon to declare success before
its child, /bin/login, exits.

Joe

[PS: this email may not get through, our email servers
changed recently and I have been having problems.  Roland,
please ACK me privately as soon as you see this.  Thanks] 

