Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSLPXJ1>; Mon, 16 Dec 2002 18:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSLPXJ1>; Mon, 16 Dec 2002 18:09:27 -0500
Received: from CPE-203-51-35-111.nsw.bigpond.net.au ([203.51.35.111]:36336
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S262266AbSLPXJY>; Mon, 16 Dec 2002 18:09:24 -0500
Message-ID: <3DFE5EFC.FC7CF213@eyal.emu.id.au>
Date: Tue, 17 Dec 2002 10:17:16 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: rmap and nvidia?
References: <3DFE522A.6010803@superonline.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"O.Sezer" wrote:
> 
> Is this patch correct in any way?
> (Ripped out of the 2.5 patch and modified some).

The equivalent minimal patch for nv.c in 2.4 will then be:

--- modules/nvidia/NVIDIA_kernel/nv.c.orig      Tue Dec 10 07:27:15 2002
+++ modules/nvidia/NVIDIA_kernel/nv.c   Tue Dec 17 10:07:37 2002
@@ -2247,7 +2247,13 @@
     pte_kunmap(pte__);
 #else
     pte__ = NULL;
+#ifdef pte_offset
     pte = *pte_offset(pg_mid_dir, address);
+#else	/* rmap-vm */
+    pte__ = pte_offset_map(pg_mid_dir, address);
+    pte = *pte__;
+    pte_unmap(pte__);
+#endif
 #endif

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
