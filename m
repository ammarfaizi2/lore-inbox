Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268900AbUIQQoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268900AbUIQQoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268954AbUIQQmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:42:21 -0400
Received: from [217.73.129.129] ([217.73.129.129]:19361 "EHLO
	car.linuxhacker.ru") by vger.kernel.org with ESMTP id S268900AbUIQPdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:33:02 -0400
Date: Fri, 17 Sep 2004 18:32:22 +0300
Message-Id: <200409171532.i8HFWMUv009546@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Strange reiserfs 3.6 msg warning.
To: maxsoft@linuxmail.org, mason@suse.com, linux-kernel@vger.kernel.org
References: <20040916235532.6216523C12@ws5-3.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Panos Polychronis" <maxsoft@linuxmail.org> wrote:
PP> hello i'm running 2.6.8.1-ck7 (reiserfs 3.6) and i got this message
PP> Sep 17 00:53:26 phobos kernel: ReiserFS: hda1: warning: vs-8115: get_num_ver: not directory item
PP> can anyone explain me what is this and if is something dangerous ?

This is totally harmless, you can silence the warning with below patch
(somehow it was lost on its way to Linus, it seems).

Bye,
    Oleg

===== fs/reiserfs/fix_node.c 1.35 vs edited =====
--- 1.35/fs/reiserfs/fix_node.c	2004-05-10 14:25:42 +03:00
+++ edited/fs/reiserfs/fix_node.c	2004-06-22 20:11:26 +03:00
@@ -510,9 +510,10 @@
 	// s2bytes
 	snum012[4] = op_unit_num (&vn->vn_vi[split_item_num]) - snum012[4] - bytes_to_r - bytes_to_l - bytes_to_S1new;
 
-	if (vn->vn_vi[split_item_num].vi_index != TYPE_DIRENTRY)
+	if (vn->vn_vi[split_item_num].vi_index != TYPE_DIRENTRY &&
+	    vn->vn_vi[split_item_num].vi_index != TYPE_INDIRECT)
 	    reiserfs_warning (tb->tb_sb, "vs-8115: get_num_ver: not "
-			      "directory item");
+			      "directory or indirect item");
     }
 
     /* now we know S2bytes, calculate S1bytes */
