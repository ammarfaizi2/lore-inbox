Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422690AbWATGJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbWATGJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbWATGIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:08:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:7319 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422693AbWATGIJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:08:09 -0500
Cc: akpm@osdl.org
Subject: [PATCH] W1: u64 is not long long
In-Reply-To: <11377372373543@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jan 2006 22:07:17 -0800
Message-Id: <1137737237487@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] W1: u64 is not long long

You don't know what type a u64 is, hence you cannot print it without a cast.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 607d7b2cdf6922fe9f567db52115c62d22ba4925
tree 5d9072e66c18a92c35def2e55c0450c3cb9ef6d7
parent c8d1a16495d65c58ac1454e33b124105db9eb4fd
author Andrew Morton <akpm@osdl.org> Sat, 14 Jan 2006 00:05:59 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 19 Jan 2006 21:53:27 -0800

 drivers/w1/w1.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

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
 

