Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266063AbUGEMuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUGEMuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 08:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUGEMuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 08:50:18 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:14362 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266063AbUGEMuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 08:50:07 -0400
Date: Mon, 5 Jul 2004 14:27:22 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: question about /proc/<PID>/mem in 2.4
Message-ID: <Pine.LNX.4.44.0407051422240.18740-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed that in 2.4.x kernels the fs/proc/base.c:mem_read() function has 
this permission check:

        if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
                return -ESRCH;

Are you sure it shouldn't be like this instead:

        if (!MAY_PTRACE(task) && !may_ptrace_attach(task))
                return -ESRCH;

Because, normally MAY_PTRACE() is 0 (i.e. for any process worth looking at :)
so may_ptrace_attach() is never even called.

Is there any reason for the above check on each read(2)? Shouldn't there 
be a simple check at ->open() time only? I assume this is to close some 
obscure "security hole" but I would like to see the explanation of how 
could any problem arise if a) such check wasn't done at all (except at 
open(2) time) or at least b) there was && instead of ||.

The 2.6.x situation is similar except the addition of the security stuff.

Kind regards
Tigran

