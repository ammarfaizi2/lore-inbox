Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422971AbWCXBbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422971AbWCXBbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422973AbWCXBbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:31:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:36036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422971AbWCXBbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:31:09 -0500
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 7/8] W1: u64 is not long long
In-Reply-To: <11431638372371-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 17:30:38 -0800
Message-Id: <11431638383855-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You don't know what type a u64 is, hence you cannot print it without a cast.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/w1/w1.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

f73b5e7949945486a649e40821cd351e2f60bf02
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 5def7fb..d640c1e 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -388,11 +388,14 @@ static int w1_uevent(struct device *dev,
 	if (dev->driver != &w1_slave_driver || !sl)
 		return 0;
 
-	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_FID=%02X", sl->reg_num.family);
+	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size,
+			&cur_len, "W1_FID=%02X", sl->reg_num.family);
 	if (err)
 		return err;
 
-	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_SLAVE_ID=%024LX", (u64)sl->reg_num.id);
+	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size,
+			&cur_len, "W1_SLAVE_ID=%024LX",
+			(unsigned long long)sl->reg_num.id);
 	if (err)
 		return err;
 
-- 
1.2.4


