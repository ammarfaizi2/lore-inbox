Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWDJSN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWDJSN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWDJSN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:13:56 -0400
Received: from mga03.intel.com ([143.182.124.21]:2234 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932083AbWDJSNz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:13:55 -0400
X-IronPort-AV: i="4.04,108,1144047600"; 
   d="scan'208"; a="21425158:sNHT32519305"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] ext3: Fix missed mutex unlock
Date: Mon, 10 Apr 2006 22:13:26 +0400
Message-ID: <6694B22B6436BC43B429958787E4549801BD7FFC@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ext3: Fix missed mutex unlock
Thread-Index: AcZcynY9WcDbQaNKQwSnDQ/vqnD04w==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Apr 2006 18:13:49.0677 (UTC) FILETIME=[842479D0:01C65CCA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Leonid Ananiev

Missed unlock_super()call is added in error condition code path.

Signed-off-by: Leonid Ananiev <leonid.i.ananiev@intel.com>

-------
--- fs/ext3/resize.c  2006-04-06 01:08:28.367109040 -0700
+++ fs/ext3/resize.c       2006-04-06 01:10:37.289509856 -0700
@@ -974,6 +974,7 @@ int ext3_group_extend(struct super_block
        if (o_blocks_count != le32_to_cpu(es->s_blocks_count)) {
                ext3_warning(sb, __FUNCTION__,
                             "multiple resizers run on filesystem!");
+               unlock_super(sb);
                err = -EBUSY;
                goto exit_put;
        }
