Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756794AbWKSRIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794AbWKSRIu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 12:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756795AbWKSRIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 12:08:50 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:38518 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1756794AbWKSRIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 12:08:49 -0500
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uml fails to compile due to missing offsetof
X-Message-Flag: Warning: May contain useful information
References: <20061119120000.GA4926@aepfle.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 19 Nov 2006 09:08:47 -0800
In-Reply-To: <20061119120000.GA4926@aepfle.de> (Olaf Hering's message of "Sun, 19 Nov 2006 13:00:01 +0100 (MET)")
Message-ID: <aday7q7jrds.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 Nov 2006 17:08:47.0980 (UTC) FILETIME=[60AB02C0:01C70BFD]
Authentication-Results: sj-dkim-6; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim6002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I fail to see how arch/um/sys-i386/user-offsets.c can compile since
 > offsetof() was declared __KERNEL__ only in include/linux/stddef.h.
 > Does it work for anyone else? If so, is linux/stddef.h or
 > /usr/include/linux/stddef.h used during compilation?
 > The x86_64 variant looks weird as well, linux/stddef.h is appearently
 > included via some other headers.

Yes, the

#include <linux/stddef.h>

looks weird to me.  AFAIK the C standard says that offsetof() comes
from plain old <stddef.h>.  Does the (untested) patch below fix the
build for you?

diff --git a/arch/um/sys-i386/user-offsets.c b/arch/um/sys-i386/user-offsets.c
index 6f4ef2b..447306b 100644
--- a/arch/um/sys-i386/user-offsets.c
+++ b/arch/um/sys-i386/user-offsets.c
@@ -2,7 +2,7 @@ #include <stdio.h>
 #include <signal.h>
 #include <asm/ptrace.h>
 #include <asm/user.h>
-#include <linux/stddef.h>
+#include <stddef.h>
 #include <sys/poll.h>
 
 #define DEFINE(sym, val) \
