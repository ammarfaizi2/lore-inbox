Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVLMNnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVLMNnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVLMNnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:43:20 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:58588 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932201AbVLMNnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:43:19 -0500
Subject: [PATCH -mm 0/9] unshare system call (take 4) - now with unwrapped
	lines
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134481276.25431.177.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 08:42:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am resending these since my mailer wrapped long lines (arrrgh...)

-------------------------------------------------------------------

The following patches represent the updated version of the proposed
new system call unshare. They were forward ported 2.6.15-rc5-mm2 and
reorganized as per Al Viro's suggestion to allow incremental unsharing
of process context without requiring ABI changes.

unshare allows a process to disassociate part of the process context (vm
and/or namespace) that was being shared with a parent.  Unshare is
needed
to implement polyinstantiated directories (such as per-user and/or
per-security context /tmp directory) using the kernel's per-process
namespace mechanism. For a more detailed description of the
justification
and approach, please refer to lkml threads from 8/8/05, 10/13/05 &
12/08/05.
                                                                                
Unshare system call, along with shared tree patches, have been in use
in our department for over month and half. We have been using them to
maintain per-user and per-context /tmp directory. The latest port to
2.6.15-rc5-mm2 has been tested on a uni-processor i386 machine.

Patches are organized as follows:

1. Patch implementing system call handler sys_unshare. System call
   accepts all clone(2) flags but returns -EINVAL when attempt is
   made to unshare any shared context.
2. Patch registering system call for i386 architecture
3. Patch registering system call for powerpc architecture
4. Patch registering system call for ppc architecture
5. Patch registering system call for x86_64 architecture
6. Patch implementing unsharing of filesystem information
7. Patch implementing unsharing of namespace
8. Patch implementing unsharing of vm
9. Patch implementing unsharing of files

Unsharing of singnal handlers is still not implemented. As far as I can
tell, issues raised by Chris Wright regarding possible problems stemming
from interaction of timers with unsharing of signal handlers, has been
resolved by a 2.6.14 patch that fixed race in send_sigqueue with thread
exit. However, I do want to understand the code better and experiment
with it some more before implementing signal handler unsharing. If 
deemed ok, it would be easy to add that functionality.


