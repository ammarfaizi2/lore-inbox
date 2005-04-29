Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVD2ICb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVD2ICb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 04:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVD2ICb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 04:02:31 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:6993 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S262456AbVD2IC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 04:02:26 -0400
Message-ID: <4271EC60.6020809@sw.ru>
Date: Fri, 29 Apr 2005 12:12:16 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [QUESTION] why redhat and others disable lcall7/lcall27?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All redhat kernels contain the patch given below which disables 
lcall7/lcall27. Why? I've heared from some people that these calls are 
insecure or something like that. But what is the real problem with it?
Why mainstream kernel still keeps these calls then?

Kirill

diff -urNp linux-1130/arch/i386/kernel/traps.c 
linux-10000/arch/i386/kernel/traps.c
--- linux-1130/arch/i386/kernel/traps.c
+++ linux-10000/arch/i386/kernel/traps.c
@@ -1021,9 +1021,10 @@ void __init trap_init(void)
          * default LDT is a single-entry callgate to lcall7 for iBCS
          * and a callgate to lcall27 for Solaris/x86 binaries
          */
+#if 0
         set_call_gate(&default_ldt[0],lcall7);
         set_call_gate(&default_ldt[4],lcall27);
-
+#endif
         /*
          * Should be a barrier for any external CPU state.
          */

