Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWAJWBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWAJWBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWAJWBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:01:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932522AbWAJWBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:01:41 -0500
Date: Tue, 10 Jan 2006 14:01:16 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-audit@redhat.com
Subject: [PATCH] kaudit_thread return val
Message-ID: <20060110140116.16406581@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning because kaudit_thread() is not returning a value.
This is in current linux-2.6.git.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- skge-2.6.orig/kernel/audit.c
+++ skge-2.6/kernel/audit.c
@@ -300,6 +300,8 @@ static int kauditd_thread(void *dummy)
 			remove_wait_queue(&kauditd_wait, &wait);
 		}
 	}
+
+	return 0;
 }
 
 void audit_send_reply(int pid, int seq, int type, int done, int multi,
