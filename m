Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265950AbUFDSxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUFDSxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUFDSvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:51:50 -0400
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:8848 "EHLO
	rtp-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S265921AbUFDSuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:50:25 -0400
X-BrightmailFiltered: true
To: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Crypto digests and kmapping sg entries larger than a page, with
 [PATCH]
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Fri, 04 Jun 2004 13:50:15 -0500
Message-ID: <yquj7junkviw.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

N.C.Krishna Murthy asked me to forward this to the crypto maintainers.

While doing work on the iSCSI driver and 2.6.6 to use the crypto
CRC32C routines for digests, he saw that the scatterlist entries had
entries larger than one page.  We've had some discussion in
linux-iscsi about making sure we kmap() each page in such entries, and
Krishna saw that the crypto digest code may also need to do the same.

He supplies a patch, below.

If you agree with the implementation, I'll re-diff and test against a
recent BitKeeper extract and submit a patch.


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: krmurthy@cisco.com
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com
 [171.71.176.70]) by mcfeely.cisco.com (8.8.6
 (PHNE_17190)/CISCO.SERVER.1.2) with ESMTP id GAA20735; Thu, 3 Jun 2004
 06:36:07 -0400 (EDT)
Received: from sj-core-2.cisco.com (171.71.177.254)
  by sj-iport-1.cisco.com with ESMTP; 03 Jun 2004 03:36:11 -0700
X-BrightmailFiltered: true
Received: from krmurthy1-lnx.cisco.com (krmurthy1-lnx.cisco.com
 [10.77.7.60])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id i53Aa2Xl005288;
	Thu, 3 Jun 2004 03:36:03 -0700 (PDT)
Received: from localhost (localhost [[UNIX: localhost]])
	by krmurthy1-lnx.cisco.com (8.11.6/8.11.6) id i53AZoY29918;
	Thu, 3 Jun 2004 16:05:50 +0530
From: "N.C.Krishna Murthy" <krmurthy@cisco.com>
Subject: Patch for OOPs seen when using crypto APIs
Date: Thu, 3 Jun 2004 16:05:49 +0530
User-Agent: KMail/1.4.3
To: chaapala@cisco.com
Cc: Dave Myers <davmyers@cisco.com>, mbhojasi@cisco.com
Message-Id: <200406031605.49913.krmurthy@cisco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===-=-="

--===-=-=
Content-Type: text/plain; charset=iso-8859-1

Hi Clay,
	I was testing iSCSI driver code from 4.0 branch against 2.6.6 kernel.
I had the in kernel crypto CRC32 feature enabled. Initial testing resulted
in CRC errors. This was due to bugs in iSCSI driver and it has been reported
on sourceforge([965626 ] CRC errors seen when crypto APIs are used).

	I fixed the bugs in iSCSI driver and  ran some file I/O.
This resulted in an OOPs.
-----------------------------------------------------------------------------
---------- Process iscsi-tx (pid: 3344, threadinfo=f63e4000 task=f5c9f2a0)
Stack: f64d82b0 00000000 c0215af5 ffffffff fffe2000 00002000 fffe2000
 c0214c32 f64d82b0 fffe2000 00002000 f64d82b0 f63e4000 f63e4000 00002000
 f63e5e94 f7f609a0 f5c74000 f8b0dc80 f64d8284 f63e5e94 00000001 f63e5e78
 f63e5e7c Call Trace:
 [<c0215af5>] chksum_update+0x25/0x30
 [<c0214c32>] update+0x92/0x100
 [<f8b0dc80>] iscsi_xmit_data+0x460/0xb60 [iscsi_sfnet]
 [<c0119ff3>] scheduler_tick+0x43/0x630
 [<c036ea7f>] schedule+0x36f/0x6a0
 [<f8b0e52a>] iscsi_xmit_r2t_data+0xca/0x1b0 [iscsi_sfnet]
 [<f8af9025>] process_tx_requests+0x1f5/0x320 [iscsi_sfnet]
 [<c011a5e0>] default_wake_function+0x0/0x20
 [<f8af92e5>] iscsi_tx_thread+0x195/0x1d0 [iscsi_sfnet]
 [<c011a5e0>] default_wake_function+0x0/0x20
 [<f8af9150>] iscsi_tx_thread+0x0/0x1d0 [iscsi_sfnet]
 [<c0103f95>] kernel_thread_helper+0x5/0x10
-----------------------------------------------------------------------------
-----------

Upon looking into the crypto/digest.c, I found that "update()" function
does crypto_kmap() only the first page in the sg. A "struct scatterlist "
can point to a single page or physically contiguous pages.  The oops
seen is a result of "update()" not handling contiguous pages.
The patch I have attached solves the bug. I was able to test it and did
not see any oops after that. File I/O went through fine without any digest
errors.  Could you please forward the patch to the appropriate forum?

Thanx
N.C.Krishna Murthy

-------------------------------------------------------


--===-=-=
Content-Type: text/x-diff; charset=iso-8859-1; name=digest.patch
Content-Disposition: attachment; filename=digest.patch

--- /usr/src/linux-2.6.6/crypto/digest.c	2004-06-03 14:36:09.000000000 +0530
+++ /usr/src/linux-2.6.6/crypto.new/digest.c	2004-06-03 15:12:10.683261696 +0530
@@ -27,13 +27,28 @@
                    struct scatterlist *sg, unsigned int nsg)
 {
 	unsigned int i;
-	
+
 	for (i = 0; i < nsg; i++) {
-		char *p = crypto_kmap(sg[i].page, 0) + sg[i].offset;
-		tfm->__crt_alg->cra_digest.dia_update(crypto_tfm_ctx(tfm),
-		                                      p, sg[i].length);
-		crypto_kunmap(p, 0);
-		crypto_yield(tfm);
+
+		struct page *pg = sg[i].page;
+		unsigned int offset = sg[i].offset;
+		unsigned int l = sg[i].length;
+
+		do {
+			unsigned int bytes_from_page = min(l, ((unsigned int)
+							   (PAGE_SIZE)) - 
+							   offset);
+			char *p = crypto_kmap(pg, 0) + offset;
+
+			tfm->__crt_alg->cra_digest.dia_update
+					(crypto_tfm_ctx(tfm), p,
+					 bytes_from_page);
+			crypto_kunmap(p, 0);
+			crypto_yield(tfm);
+			offset = 0;
+			pg++;
+			l -= bytes_from_page;
+		} while (l > 0);
 	}
 }
 

--===-=-=--

--=-=-=



-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
"We're serious about this campaign now!  The training wheels are coming off!"
   -- a high White Horse Souse

--=-=-=--
