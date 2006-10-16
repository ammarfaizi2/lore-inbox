Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161197AbWJPHj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbWJPHj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 03:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbWJPHj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 03:39:59 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:71 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161197AbWJPHj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 03:39:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=B6b3CjLnSnPRqtVagpB9kFAOPorr5t1CGrzC+ldEhJc6mTiOq+x8IsDdermSm2I3WuDYGnV7Ek4aH4XOQ+avBu/3/JdEFnvDZwvFT6OOxCdHrL4eIdcOiH8sGQH4x0KaOjhMZcKhA205PATOQN+NP2EpwVa2IzpwPTPGxoNISVQ=
Date: Mon, 16 Oct 2006 00:39:48 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc2] fs/cifs/readdir.c: check kmalloc() return value.
Message-Id: <20061016003948.d4a1bc43.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function cifs_readdir(), in file fs/cifs/readdir.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index b5b0a2a..2d43b2a 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -1063,6 +1063,11 @@ int cifs_readdir(struct file *file, void
 		such multibyte target UTF-8 characters. cifs_unicode.c,
 		which actually does the conversion, has the same limit */
 		tmp_buf = kmalloc((2 * NAME_MAX) + 4, GFP_KERNEL);
+		if (!tmp_buf) {
+			cERROR(1, ("No memory!"));
+			rc = -ENOMEM;
+			goto rddir2_exit;
+		}
 		for(i=0;(i<num_to_fill) && (rc == 0);i++) {
 			if(current_entry == NULL) {
 				/* evaluate whether this case is an error */
