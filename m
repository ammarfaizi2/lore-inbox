Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbULERt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbULERt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbULERtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:49:55 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:46533 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261319AbULERoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:44:30 -0500
From: Kernel Stuff <kernel-stuff@comcast.net>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] Document kfree and vfree NULL usage (resend)
Date: Sun, 5 Dec 2004 12:44:36 -0500
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
References: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de> <200412051105.10934.kernel-stuff@comcast.net> <41B33E70.2000107@colorfullife.com>
In-Reply-To: <41B33E70.2000107@colorfullife.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ek0sBPpOlX2LmhW"
Message-Id: <200412051244.36449.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Ek0sBPpOlX2LmhW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch changes the vfree() documentation to correct "May not be 
called in interrupt context" to "Must not be called in interrupt context". 
Latter is compliant to  RFC2119 and matches the absolute requirement for  
vfree.

Is not the same requirement true for vmalloc() - or is it ok to call vmalloc() 
in interrupt?

Parag

On Sunday 05 December 2004 11:59 am, Manfred Spraul wrote:
> Kernel Stuff wrote:
> >>  *	May not be called in interrupt context
> >
> >Does this need to change to
> >      * Must not be called in interrupt context
> >?
> >Is there a case where it is guaranteed that kfree will not sleep?
>
> kfree never sleeps. The comment you mention is part of the vfree
> documentation.
>
> And you are right: for vfree, it's "must not be called". I'll send a
> separate patch. Or Andrew could just change it directly.
>
> --
>     Manfred
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--Boundary-00=_Ek0sBPpOlX2LmhW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch"

--- linux-mod/mm/vmalloc.c.orig	2004-12-05 12:40:50.699631616 -0500
+++ linux-mod/mm/vmalloc.c	2004-12-05 12:37:17.279076472 -0500
@@ -340,7 +340,7 @@ void __vunmap(void *addr, int deallocate
  *	Free the virtually contiguous memory area starting at @addr, as
  *	obtained from vmalloc(), vmalloc_32() or __vmalloc().
  *
- *	May not be called in interrupt context.
+ *	Must not be called in interrupt context.
  */
 void vfree(void *addr)
 {

--Boundary-00=_Ek0sBPpOlX2LmhW--
