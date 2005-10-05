Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVJEC1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVJEC1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 22:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJEC1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 22:27:36 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:53212 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751159AbVJEC1g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 22:27:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JOgXvzuLDk/qeopEOId46GzbJGl2aTxiEccBrEiuWbyrF8AjpS9HmI09wZpRWg/V8Yn6vC/157U+rwR06KN8hf7b32mfsXeiLAvE2xg2dcmLZ531j9RZwY7YIZZodR4C6nGSWVRZz3TniiAiT5a2SgmtFTxNy9aZUXUpsziR83g=
Message-ID: <89c400ad0510041927r120284beg4e63568f6f9935ae@mail.gmail.com>
Date: Wed, 5 Oct 2005 07:57:35 +0530
From: Krishnakumar R <rkrishnakumar@gmail.com>
Reply-To: Krishnakumar R <rkrishnakumar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][HugeTLB] Remove repeated code
Cc: akpm@osdl.org, rohit.seth@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch cleans up some repeated code related to HugeTLB.
hugetlb_zero_setup would have already allocated the file->f_op.

Thanks and Regards,
KK.

PS: Ack-ed by Rohit


    Signed-off-by: Krishnakumar. R <rkrishnakumar@gmail.com>

--- linux-2.6.14-rc2-mm1/ipc/shm.orig.c 2005-10-04 23:15:01.000000000 +0530
+++ linux-2.6.14-rc2-mm1/ipc/shm.c      2005-10-05 01:09:03.000000000 +0530
@@ -233,10 +233,11 @@ static int newseg (key_t key, int shmflg
        shp->id = shm_buildid(id,shp->shm_perm.seq);
        shp->shm_file = file;
        file->f_dentry->d_inode->i_ino = shp->id;
-       if (shmflg & SHM_HUGETLB)
-               set_file_hugepages(file);
-       else
+
+       /* Hugetlb ops would have already been assigned. */
+       if (!(shmflg & SHM_HUGETLB))
                file->f_op = &shm_file_operations;
+
        shm_tot += numpages;
        shm_unlock(shp);
        return shp->id;
