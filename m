Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbUKPKBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUKPKBG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUKPJ6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:58:30 -0500
Received: from siaar2aa.compuserve.com ([149.174.40.137]:16196 "EHLO
	siaar2aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261722AbUKPJ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:57:35 -0500
Message-ID: <4199CEFE.7060800@compuserve.com>
Date: Tue, 16 Nov 2004 01:57:18 -0800
From: Bryan Batten <BryanBatten@compuserve.com>
Reply-To: BryanBatten@compuserve.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Kai.Makisara@kolumbus.fi, Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: [PATCH]-2.6.10-rc2: Fix Link Error osst.o, st.o
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After patching up to 2.6.10-rc2, I get the following error when 
building the kernel with gcc 2.95:

drivers/scsi/osst.o(.bss+0x0): multiple definition of `ST_partstat'
drivers/scsi/st.o(.bss+0x0): first defined here
make[2]: *** [drivers/scsi/built-in.o] Error 1
make[1]: *** [drivers/scsi] Error 2

The error occurs because the change from 'typedef struct {...} 
ST_buffer;' to 'struct st_buffer {...} ST_buffer;' causes storage to 
be allocated more than once.

The fix is to just remove the 'ST_buffer' part from the changed 
structure definition.

Here's the patch to drivers/scsi/st.h:

# diff -up *orig/drivers/scsi/st.h *x/drivers/scsi/st.h
--- *orig/drivers/scsi/st.h     Mon Nov 15 22:44:18 2004
+++ linux-2.6x/drivers/scsi/st.h        Tue Nov 16 01:27:19 2004
@@ -67,7 +67,7 @@ struct st_partstat {
         u32 last_block_visited;
         int drv_block;          /* The block where the drive head is */
         int drv_file;
-} ST_partstat;
+};

  #define ST_NBR_PARTITIONS 4

(Signed-off-by: Bryan Batten <BryanBatten@compuserve.com>)





