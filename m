Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274841AbTGaRNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274840AbTGaRM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:12:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:55531 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S274822AbTGaRMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:12:07 -0400
Message-ID: <3F294DE3.9020304@RedHat.com>
Date: Thu, 31 Jul 2003 13:12:03 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Neil F. Brown" <neilb@cse.unsw.edu.au>
CC: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: nfs-utils-1.0.5 is not backwards compatible with 2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hey Neil,

It seems in nfs-utils-1.05 (actually it happen in 1.0.4)
the NFSEXP_CROSSMNT define was changed to 0x4000 and the
NFSEXP_NOHIDE define (which is not supported in 2.4) took
over the 0x0200 bit.. This breaks backwards compatibly with
1.0.3 and the 2.4 kernels...

So could please add this patch that simply switchs the bits
so NFSEXP_CROSSMNT stays the same and the new NFSEXP_NOHIDE define
gets the higher bit?

--- support/include/nfs/export.h.diff   Mon Jul 14 18:14:01 2003
+++ support/include/nfs/export.h        Thu Jul 31 11:58:05 2003
@@ -20,11 +20,11 @@
#define NFSEXP_UIDMAP          0x0040
#define NFSEXP_KERBEROS                0x0080          /* not available */
#define NFSEXP_SUNSECURE       0x0100
-#define NFSEXP_NOHIDE          0x0200
+#define NFSEXP_CROSSMNT                0x0200
#define NFSEXP_NOSUBTREECHECK  0x0400
#define NFSEXP_NOAUTHNLM       0x0800
#define NFSEXP_FSID            0x2000
-#define        NFSEXP_CROSSMNT         0x4000
+#define        NFSEXP_NOHIDE           0x4000
#define NFSEXP_NOACL           0x8000 /* reserved for possible ACL
related use */
#define NFSEXP_ALLFLAGS                0xFFFF


SteveD.



