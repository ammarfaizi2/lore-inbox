Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269623AbUHZVKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbUHZVKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269642AbUHZVKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:10:09 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:22473 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S269645AbUHZVAs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:00:48 -0400
Message-ID: <412E4F43.9030801@ttnet.net.tr>
Date: Thu, 26 Aug 2004 23:59:47 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.28-pre2 and ntfs-2.1.6b ?
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

With 2.4.28-pre2, ntfs-2.1.6b from linux-ntfs site
started failing to compile at aops.c:

aops.c: In function `ntfs_read_block':
aops.c:315: parse error before "else"
-- or in case of gcc3.4 --
aops.c:315: error: syntax error before "else"

This happens with gcc-3.2.2 and gcc-3.4.0
and can be fixed by:

--- aops.c.BAK	2004-08-26 19:35:11.000000000 +0300
+++ aops.c	2004-08-26 21:41:53.000000000 +0300
@@ -310,10 +310,11 @@
  		return 0;
  	}
  	/* No i/o was scheduled on any of the buffers. */
-	if (likely(!PageError(page)))
+	if (likely(!PageError(page))) {
  		SetPageUptodate(page);
-	else /* Signal synchronous i/o error. */
+	} else { /* Signal synchronous i/o error. */
  		nr = -EIO;
+	}
  	unlock_page(page);
  	return nr;
  }

The very same code used to compile fine with
2.4.27 without any changes to it. I can't see
where the problem is (it's 23:57 here ;)).
Can anyone tell, please?

Regards,
Ozkan Sezer
