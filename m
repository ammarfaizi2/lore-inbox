Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268537AbUH3QsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbUH3QsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268539AbUH3QsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:48:21 -0400
Received: from mdm-digital417.uol.brasilvision.com.br ([200.222.15.249]:33683
	"EHLO tirion") by vger.kernel.org with ESMTP id S268537AbUH3QsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:48:20 -0400
Date: Mon, 30 Aug 2004 12:47:24 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] - Fixes bug in fs/ext3/super.c.
Message-Id: <20040830124724.5f9b2f8e.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Marcelo,

  Some time ago I fixed this bug in 2.6.

  There is a `return NULL' missing in ext3_get_journal() if the
 call to journal_init_inode() fail. Note that if the error happens,
 `journal' will be NULL and used.

(agains't 2.4.28-pre2).

Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>


diff -Nparu a/fs/ext3/super.c a~/fs/ext3/super.c
--- a/fs/ext3/super.c	2004-08-07 20:26:05.000000000 -0300
+++ a~/fs/ext3/super.c	2004-08-15 22:18:18.000000000 -0300
@@ -1302,6 +1302,7 @@ static journal_t *ext3_get_journal(struc
 	if (!journal) {
 		printk(KERN_ERR "EXT3-fs: Could not load journal inode\n");
 		iput(journal_inode);
+		return NULL;
 	}
 	ext3_init_journal_params(EXT3_SB(sb), journal);
 	return journal;

-- 
Luiz Fernando Capitulino
