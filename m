Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVHINqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVHINqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbVHINqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:46:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60563 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964772AbVHINqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:46:53 -0400
Date: Tue, 9 Aug 2005 08:44:24 -0500
From: serue@us.ibm.com
To: James Morris <jmorris@namei.org>
Cc: serue@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [PATCH] seclvl: use securityfs
Message-ID: <20050809134424.GB2590@serge.austin.ibm.com>
References: <20050809004321.GA9332@sergelap.austin.ibm.com> <Pine.LNX.4.63.0508090107190.20178@excalibur.intercode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508090107190.20178@excalibur.intercode>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Morris (jmorris@namei.org):
> On Mon, 8 Aug 2005, serue@us.ibm.com wrote:
> 
> This looks like a nice cleanup.
> 
> > +
> > +	if (count < 0 || count >= PAGE_SIZE)
> > +		return -ENOMEM;
> > +	if (*ppos != 0) {
> > +		return -EINVAL;
> > +	}
> 
> Why is the first error there -ENOMEM and not -EINVAL?

Thanks James, that should be -EINVAL for both.  For that matter, the
braces in the next line shouldn't be there.  Obvious patch appended.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 seclvl.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.13-rc5-mm1/security/seclvl.c
===================================================================
--- linux-2.6.13-rc5-mm1.orig/security/seclvl.c	2005-08-08 17:22:45.000000000 -0500
+++ linux-2.6.13-rc5-mm1/security/seclvl.c	2005-08-09 13:45:31.000000000 -0500
@@ -252,10 +252,9 @@ passwd_write_file(struct file * file, co
 	}
 
 	if (count < 0 || count >= PAGE_SIZE)
-		return -ENOMEM;
-	if (*ppos != 0) {
 		return -EINVAL;
-	}
+	if (*ppos != 0)
+		return -EINVAL;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
