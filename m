Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274883AbTGaWSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274911AbTGaWSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:18:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:6336 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274883AbTGaWSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:18:04 -0400
Date: Thu, 31 Jul 2003 15:05:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chip Salzenberg <chip@pobox.com>
Cc: SteveD@redhat.com, neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4 and 2.6 disagree about NFSEXP_CROSSMNT - upward
 incompatibility, please fix
Message-Id: <20030731150548.0cacb93b.akpm@osdl.org>
In-Reply-To: <20030731182332.GH18733@perlsupport.com>
References: <3F294DE3.9020304@RedHat.com>
	<20030731182332.GH18733@perlsupport.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg <chip@pobox.com> wrote:
>
> According to Steve Dickson:
> > It seems in nfs-utils-1.05 (actually it happen in 1.0.4)
> > the NFSEXP_CROSSMNT define was changed to 0x4000 ....
> 
> This looks like an actual kernel incompatibility 2.4 <-> 2.6, as
> the 2.4 and 2.6 trees disagree about the value of NFSEXP_CROSSMNT.

yup.

> > So could please add this patch that simply switchs the bits
> > so NFSEXP_CROSSMNT stays the same and the new NFSEXP_NOHIDE define
> > gets the higher bit?
> 
> And 2.6's include/linux/nfsd/export.h needs the same fix.  This needs
> to go in before the 2.6.0 release or nfs-utils is in deep kimchi.

Like this?

diff -puN include/linux/nfsd/export.h~nfs-flags-untangle include/linux/nfsd/export.h
--- 25/include/linux/nfsd/export.h~nfs-flags-untangle	Thu Jul 31 15:04:25 2003
+++ 25-akpm/include/linux/nfsd/export.h	Thu Jul 31 15:04:49 2003
@@ -35,12 +35,12 @@
 #define NFSEXP_UIDMAP		0x0040
 #define NFSEXP_KERBEROS		0x0080		/* not available */
 #define NFSEXP_SUNSECURE	0x0100
-#define NFSEXP_NOHIDE		0x0200
+#define NFSEXP_CROSSMNT		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
 #define NFSEXP_MSNFS		0x1000	/* do silly things that MS clients expect */
 #define NFSEXP_FSID		0x2000
-#define	NFSEXP_CROSSMNT		0x4000
+#define	NFSEXP_NOHIDE		0x4000
 #define NFSEXP_ALLFLAGS		0x7FFF
 
 

_

