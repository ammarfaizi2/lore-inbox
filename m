Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbREMIHk>; Sun, 13 May 2001 04:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbREMIHb>; Sun, 13 May 2001 04:07:31 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:27579 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S261386AbREMIHN>; Sun, 13 May 2001 04:07:13 -0400
Message-Id: <5.0.2.1.2.20010513005434.00a84d00@pxwang.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 13 May 2001 01:07:03 -0700
To: alan@lxorguk.ukuu.org.uk
From: Philip Wang <PXWang@stanford.edu>
Subject: [PATCH] vmalloc NULL Check Bug Fix
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Dawson Engler <engler@cs.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm Philip, from Professor Dawson Engler's Meta-Compilation Group at 
Stanford University.

This simple and obvious bug fix makes sure that vmalloc() does not return 
NULL.  My addition of returning -1 is consistent with how the rest of the 
code deals with allocation failures.

Warmly,

Philip

---drivers/mtd/ftl.c Fri Feb 9
11:30:23 2001
+++ ftl.c Sun May 13 00:25:26 2001
@@ -375,6 +375,8 @@
/* Set up virtual page map */
blocks = le32_to_cpu(header.FormattedSize) >> header.BlockSize;
part->VirtualBlockMap = vmalloc(blocks * sizeof(u_int32_t));
+ if(!part->VirtualBlockMap) return -1;
+
memset(part->VirtualBlockMap, 0xff, blocks * sizeof(u_int32_t));
part->BlocksPerUnit = (1 << header.EraseUnitSize) >> header.BlockSize;

