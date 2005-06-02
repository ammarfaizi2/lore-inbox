Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVFBIB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVFBIB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFBIAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:00:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7111 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261170AbVFBH6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:58:37 -0400
Date: Thu, 2 Jun 2005 16:03:01 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 6/9] dlm: clear recovery flags
Message-ID: <20050602080301.GF21570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="clear-recovery-flags.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the start of recovery, all the recovery flags are cleared from the
previous recovery.  Two of them weren't being cleared.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/member.c
===================================================================
--- linux.orig/drivers/dlm/member.c	2005-06-02 12:28:30.000000000 +0800
+++ linux/drivers/dlm/member.c	2005-06-02 13:07:46.060566696 +0800
@@ -276,6 +276,8 @@
 	 */
 
 	dlm_recoverd_suspend(ls);
+	clear_bit(LSFL_LOCKS_VALID, &ls->ls_flags);
+	clear_bit(LSFL_ALL_LOCKS_VALID, &ls->ls_flags);
 	clear_bit(LSFL_DIR_VALID, &ls->ls_flags);
 	clear_bit(LSFL_ALL_DIR_VALID, &ls->ls_flags);
 	clear_bit(LSFL_NODES_VALID, &ls->ls_flags);

--

