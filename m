Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUEGGjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUEGGjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 02:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUEGGjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 02:39:40 -0400
Received: from smtp1.BelWue.de ([129.143.2.12]:51389 "EHLO smtp1.BelWue.DE")
	by vger.kernel.org with ESMTP id S263154AbUEGGji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 02:39:38 -0400
Date: Fri, 7 May 2004 08:39:29 +0200 (CEST)
From: Oliver Tennert <tennert@science-computing.de>
To: neilb@cse.unsw.edu.au
cc: linux-kernel@vger.kernel.org
Subject: PATCH [NFSd] NFSv3/TCP
Message-ID: <Pine.LNX.4.44.0405070834001.4547-100000@picard.science-computing.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil (and others),

is there any reason why current 2.4 kernels do not allow for
NFSSVC_MAXBLKSIZE to become as large as 32k?

The problem is when I use NFSv3/TCP with a 2.4.25, say, on the server
side, as well as on the client side, I am experiencing lockups when
copying medium-sized or large files from the NFS fs to a local fs.

But, after applying the following trivial patch, everything is well again:

--- linux-2.4.26-1/include/linux/nfsd/const.h.ORG       Mon May  3
16:20:18 2004
+++ linux-2.4.26-1/include/linux/nfsd/const.h   Mon May  3 16:20:32 2004
@@ -19,9 +19,9 @@
 #define NFSSVC_MAXVERS         3

 /*
- * Maximum blocksize supported by daemon currently at 8K
+ * Maximum blocksize supported by daemon currently at 32K
  */
-#define NFSSVC_MAXBLKSIZE      (8*1024)
+#define NFSSVC_MAXBLKSIZE      (32*1024)

 #ifdef __KERNEL__

32k is the maximum block size allowed by the NFS3 standard, as far as I
understand.

I realize that, before 2.4.19, this patch was part of the NFSv3/TCP server
patches, before this functionality got into the vanilla kernel. But with
the merge, this patch got lost! Is there any reason?

Best regards

Oliver

__
________________________________________creating IT solutions

Dr. Oliver Tennert			science + computing ag
phone   +49(0)7071 9457-598		Hagellocher Weg 71-75
fax     +49(0)7071 9457-411		D-72070 Tuebingen, Germany
O.Tennert@science-computing.de		www.science-computing.de



