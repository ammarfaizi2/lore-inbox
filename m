Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbUKDTX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbUKDTX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUKDTUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:20:13 -0500
Received: from peabody.ximian.com ([130.57.169.10]:21948 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261192AbUKDTNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:13:44 -0500
Subject: Re: [patch] kobject_uevent: fix init ordering
From: Robert Love <rml@novell.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, davem@redhat.com,
       herbert@gondor.apana.org.au
In-Reply-To: <1099595042.8249.23.camel@localhost.localdomain>
References: <20041104154317.GA1268@krispykreme.ozlabs.ibm.com>
	 <20041104180550.GA16744@kroah.com>
	 <1099592851.31022.145.camel@betsy.boston.ximian.com>
	 <1099595042.8249.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 14:11:17 -0500
Message-Id: <1099595477.31022.148.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 20:04 +0100, Kay Sievers wrote:

Hey, Kay.

> Looks good. Don't know why this never failed on any kernel I used.
> Does the failure happens on a SMP kernel?

In the original patches, I had the initialization done as module_init(),
which is done very late in the init ordering.  At some point it was
changed to core_initcall(), which is the very first things initialized.

> >  static int send_uevent(const char *signal, const char *obj, const void *buf,
> > -			int buflen, int gfp_mask)
> > +		       int buflen, int gfp_mask)

Ugh.  I am sure Greg can sort it out, but following patch has just the
init call ordering change.

	Robert Love


fix kobject_uevent init ordering

 lib/kobject_uevent.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff -urN linux-2.6.10-rc1/lib/kobject_uevent.c linux/lib/kobject_uevent.c
--- linux-2.6.10-rc1/lib/kobject_uevent.c	2004-10-25 16:17:09.000000000 -0400
+++ linux/lib/kobject_uevent.c	2004-11-04 13:20:32.731836880 -0500
@@ -149,7 +147,7 @@
 	return 0;
 }
 
-core_initcall(kobject_uevent_init);
+postcore_initcall(kobject_uevent_init);
 
 #else
 static inline int send_uevent(const char *signal, const char *obj,


