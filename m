Return-Path: <linux-kernel-owner+w=401wt.eu-S932666AbWLSIgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWLSIgq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWLSIgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:36:46 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:10379 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666AbWLSIgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:36:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=DeRXs9P6rcrNyZLuooYxCV+Sq6+FO4ZsRXokOYsUeUr63ge6jYAvgzDh0Zx1EIz0VB1VT26Wjx5m9x9xeP0iif9KmIR19GkFeLahrc7N4Ejx2FLxjZ47pQHUTPGIKOAn8at6Sp5L9U4KTJax4dWn37534425theGfsHRJjJodHk=
Date: Tue, 19 Dec 2006 17:35:49 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc: use is_init()
Message-ID: <20061219083549.GA4025@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_init() rather than hard coded pid comparison.

Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 arch/powerpc/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-mm/arch/powerpc/kernel/traps.c
===================================================================
--- 2.6-mm.orig/arch/powerpc/kernel/traps.c
+++ 2.6-mm/arch/powerpc/kernel/traps.c
@@ -174,7 +174,7 @@ void _exception(int signr, struct pt_reg
 	 * generate the same exception over and over again and we get
 	 * nowhere.  Better to kill it and let the kernel panic.
 	 */
-	if (current->pid == 1) {
+	if (is_init(current)) {
 		__sighandler_t handler;
 
 		spin_lock_irq(&current->sighand->siglock);
