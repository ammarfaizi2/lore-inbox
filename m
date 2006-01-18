Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWARUly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWARUly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWARUly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:41:54 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:25547 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030430AbWARUlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:41:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=p00USIBgiuObFrQPGwd5fhsycKhvGDq3gEYc/Ili4AfwPoLGEXJay3SJU7KNNzwjdpbGPQzeDCbcd9BcKcG3v6YKB8fj3g/WQUg6CAx7vvCDKWAgXcx+AC78LuUqldy4FbcPLOwEIVYiAxiPBQhVXkGWr5J6rIUX0YdraMhEGTM=
Date: Wed, 18 Jan 2006 23:59:14 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: fixup get_signal_to_deliver call
Message-ID: <20060118205914.GE12771@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/arm26/kernel/signal.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

--- a/arch/arm26/kernel/signal.c
+++ b/arch/arm26/kernel/signal.c
@@ -480,6 +480,7 @@ static int do_signal(sigset_t *oldset, s
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka;
 
 	/*
 	 * We want the common case to go fast, which
@@ -493,7 +494,7 @@ static int do_signal(sigset_t *oldset, s
         if (current->ptrace & PT_SINGLESTEP)
                 ptrace_cancel_bpt(current);
 	
-        signr = get_signal_to_deliver(&info, regs, NULL);
+        signr = get_signal_to_deliver(&info, &ka, regs, NULL);
         if (signr > 0) {
                 handle_signal(signr, &info, oldset, regs, syscall);
                 if (current->ptrace & PT_SINGLESTEP)

