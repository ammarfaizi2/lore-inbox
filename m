Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbTCVQpR>; Sat, 22 Mar 2003 11:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263699AbTCVQo7>; Sat, 22 Mar 2003 11:44:59 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:32325
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263698AbTCVQoy>; Sat, 22 Mar 2003 11:44:54 -0500
Date: Sat, 22 Mar 2003 11:52:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: RPCSVC_MAXPAGES doesn't account for overhead(?) pages
In-Reply-To: <Pine.LNX.4.50.0303221116250.18911-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303221152060.18911-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303221116250.18911-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003, Zwane Mwaikambo wrote:

> I got this BUG with a 32k PAGE_SIZE, it looks like we unconditionally 
> allocate 2 extra pages on top of requested size so we wouldn't be able to 
> service a maximum payload from nfsd.
> 
> Is there a more suitable/elegant fix?

I forgot the patch...

Index: linux-2.5.65-pgcl/include/linux/sunrpc/svc.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/include/linux/sunrpc/svc.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 svc.h
--- linux-2.5.65-pgcl/include/linux/sunrpc/svc.h	17 Mar 2003 23:08:31 -0000	1.1.1.1
+++ linux-2.5.65-pgcl/include/linux/sunrpc/svc.h	22 Mar 2003 16:22:22 -0000
@@ -73,7 +73,8 @@ struct svc_serv {
  * This assumes that the non-page part of an rpc reply will fit
  * in a page - NFSd ensures this.  lockd also has no trouble.
  */
-#define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE + 1)
+
+#define RPCSVC_MAXPAGES		(2+((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE+1))
 
 static inline u32 svc_getu32(struct iovec *iov)
 {

-- 
function.linuxpower.ca
