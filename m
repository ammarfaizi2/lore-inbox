Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVB1Xau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVB1Xau (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVB1Xau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:30:50 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:17581 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261815AbVB1XaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:30:25 -0500
Subject: Re: [PATCH 3/5] abstract discontigmem setup
From: Dave Hansen <haveblue@us.ibm.com>
To: linux-mm <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, kmannth@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <E1D5q2Q-0007eV-00@kernel.beaverton.ibm.com>
References: <E1D5q2Q-0007eV-00@kernel.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-E0c7nWu8qtH6CsSR5UHX"
Date: Mon, 28 Feb 2005 15:30:14 -0800
Message-Id: <1109633414.6921.69.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E0c7nWu8qtH6CsSR5UHX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The $SUBJECT patch has a small, obvious, compile bug in it on the
NUMA-Q, which I introduced while cleaning it up.  Please apply this
patch on top of that one.

-- Dave

--=-E0c7nWu8qtH6CsSR5UHX
Content-Disposition: attachment; filename=A3.2.1-fix-numaq.patch
Content-Type: text/x-patch; name=A3.2.1-fix-numaq.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

The "abstract discontigmem setup" patch has a small compile bug in
it on the NUMA-Q, which I introduced while "cleaning it up."

Please apply after that patch.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/kernel/numaq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/numaq.c~A3.2.1-fix-numaq arch/i386/kernel/numaq.c
--- memhotplug/arch/i386/kernel/numaq.c~A3.2.1-fix-numaq	2005-02-28 14:16:23.000000000 -0800
+++ memhotplug-dave/arch/i386/kernel/numaq.c	2005-02-28 14:16:59.000000000 -0800
@@ -62,7 +62,9 @@ static void __init smp_dump_qct(void)
 
 			memory_present(node,
 				node_start_pfn[node], node_end_pfn[node]);
-			node_remap_size[node] = node_memmap_size_bytes(node);
+			node_remap_size[node] = node_memmap_size_bytes(node,
+							node_start_pfn[node],
+							node_end_pfn[node]);
 		}
 	}
 }
_

--=-E0c7nWu8qtH6CsSR5UHX--

