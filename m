Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbTEFMFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTEFMFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:05:38 -0400
Received: from pointblue.com.pl ([62.89.73.6]:29700 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262645AbTEFMFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:05:33 -0400
Subject: Re: [PATCH]   include/linux/sunrpc/svc.h compilation error
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus <torvalds@transmeta.com>
In-Reply-To: <1052222558.3873.19.camel@nalesnik>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
	 <Pine.LNX.4.51L.0305061205400.1232@piorun.ds.pg.gda.pl>
	 <1052222558.3873.19.camel@nalesnik>
Content-Type: text/plain; charset=ISO-8859-2
Organization: K4 labs
Message-Id: <1052223106.4051.7.camel@nalesnik>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 May 2003 13:12:01 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for that Linus, patch below is a right one.


diff -r -u 2/include/linux/sunrpc/svc.h 1/include/linux/sunrpc/svc.h
--- 2/include/linux/sunrpc/svc.h        2003-05-05 00:53:31.000000000
+0100
+++ 1/include/linux/sunrpc/svc.h        2003-05-06 13:06:27.000000000
+0100
@@ -176,8 +176,14 @@
 {
        if (rqstp->rq_arghi <= rqstp->rq_argused)
                return -ENOMEM;
-       rqstp->rq_respages[rqstp->rq_resused++] =
-               rqstp->rq_argpages[--rqstp->rq_arghi];
+
+       rqstp->rq_arghi--;
+       
+       rqstp->rq_respages[rqstp->rq_resused] =
+               rqstp->rq_argpages[rqstp->rq_arghi];
+       
+       rqstp->rq_resused++;
+       
        return 0;
 }


On Tue, 2003-05-06 at 13:02, Grzegorz Jaskiewicz wrote:
> On Tue, 2003-05-06 at 11:08, Pawe³ Go³aszewski wrote:
> > That kernel fails for me when building...
> > [cut]
> > 
> > gcc -Wp,-MD,fs/lockd/.clntproc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=clntproc -DKBUILD_MODNAME=lockd -c -o fs/lockd/.tmp_clntproc.o fs/lockd/clntproc.c
> > In file included from fs/lockd/clntproc.c:17:
> > include/linux/sunrpc/svc.h: In function `svc_take_page': 
> > include/linux/sunrpc/svc.h:180: invalid lvalue in assignment
> > make[3]: *** [fs/lockd/clntproc.o] Error 1
> > make[2]: *** [fs/lockd] Error 2
> > make[1]: *** [fs] Error 2
> > make: *** [modules] Error 2
> 
> Looks like gcc fault, can You Pawel give as gcc version  ?
> 
> this patch as reported by Pawel helps:
> but still, it looks strange - i am sure it is just an gcc issue
-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

