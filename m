Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUJCRVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUJCRVo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 13:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUJCRVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 13:21:44 -0400
Received: from [213.205.33.44] ([213.205.33.44]:10213 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268029AbUJCRVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 13:21:42 -0400
Subject: [patch 1/1] Uml: add generic ptrace requests
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Sun, 03 Oct 2004 15:43:13 +0200
Message-Id: <20041003134313.E0FF4CC06@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When we don't know how to handle ptrace(2) calls, call the arch-independent
ptrace_request like i386 (and I guess other archs) do, instead of returning
-EIO.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/ptrace.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/ptrace.c~uml-add-generic-ptrace-requests arch/um/kernel/ptrace.c
--- linux-2.6.9-current/arch/um/kernel/ptrace.c~uml-add-generic-ptrace-requests	2004-10-03 15:41:12.023298992 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/ptrace.c	2004-10-03 15:41:12.026298536 +0200
@@ -287,7 +287,7 @@ int sys_ptrace(long request, long pid, l
 	}
 #endif
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
  out_tsk:
_
