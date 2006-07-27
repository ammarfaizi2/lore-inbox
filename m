Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbWG0Fpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWG0Fpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 01:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWG0Fpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 01:45:38 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:15770 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751671AbWG0Fph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 01:45:37 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix trivial unwind info bug
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 27 Jul 2006 07:45:35 +0200
Message-ID: <874px31tz4.fsf@pike.pond.sub.org>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CFA needs to be adjusted upwards for push, and downwards for pop.
arch/i386/kernel/entry.S gets it wrong in one place.

Signed-off-by: Markus Armbruster <armbru@redhat.com>


diff --git a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
index d9a260f..37a7d2e 100644
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -204,7 +204,7 @@ #define RING0_PTREGS_FRAME \
 ENTRY(ret_from_fork)
        CFI_STARTPROC
        pushl %eax
-       CFI_ADJUST_CFA_OFFSET -4
+       CFI_ADJUST_CFA_OFFSET 4
        call schedule_tail
        GET_THREAD_INFO(%ebp)
        popl %eax
