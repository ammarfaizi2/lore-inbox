Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311965AbSCTS6J>; Wed, 20 Mar 2002 13:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311963AbSCTS57>; Wed, 20 Mar 2002 13:57:59 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:30162 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311954AbSCTS5q>; Wed, 20 Mar 2002 13:57:46 -0500
Subject: [PATCH] 2.4.19-pre3 - readv/writev should return EINVAL for count=0
From: Paul Larson <plars@austin.ibm.com>
To: Marcelo Tosati <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Mar 2002 12:53:47 -0600
Message-Id: <1016650428.2202.98.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minor patch against 2.4.19-pre3 for readv/writev to have it
return EINVAL if count=0 is passed to it.  According to the man page and
also the specifications for readv/writev, this is the correct behaviour.

Thanks,
Paul Larson

Index: linux24/fs/read_write.c
diff -u linux24/fs/read_write.c:1.1.1.1 linux24/fs/read_write.c:1.1.1.1.2.1
--- linux24/fs/read_write.c:1.1.1.1	Wed Mar 20 12:00:25 2002
+++ linux24/fs/read_write.c	Wed Mar 20 12:19:06 2002
@@ -215,10 +215,9 @@
 	 * First get the "struct iovec" from user memory and
 	 * verify all the pointers
 	 */
-	ret = 0;
+	ret = -EINVAL;
 	if (!count)
 		goto out_nofree;
-	ret = -EINVAL;
 	if (count > UIO_MAXIOV)
 		goto out_nofree;
 	if (!file->f_op)



