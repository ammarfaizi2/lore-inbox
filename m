Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264392AbUEYAsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUEYAsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 20:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUEYAsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 20:48:14 -0400
Received: from mx15.sac.fedex.com ([199.81.195.17]:24582 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S264392AbUEYAsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 20:48:10 -0400
Date: Tue, 25 May 2004 08:47:56 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Jeff Dike <jdike@addtoit.com>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] uml-patch-2.6.6-1
In-Reply-To: <200405241733.i4OHXiWC030995@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.60.0405250845270.3841@boston.corp.fedex.com>
References: <200405241733.i4OHXiWC030995@ccure.user-mode-linux.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 05/25/2004
 08:48:01 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 05/25/2004
 08:48:03 AM,
	Serialize complete at 05/25/2004 08:48:03 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible for you to release one for 2.6.7-rc1?

I haven't tried this latest patch, but my own patches do not work for 
2.6.7-rc1. arch_free_page seems to have a problem in the following 
section...

--- a/mm/page_alloc.c   2004-03-10 08:20:20.000000000 -0500
+++ b/mm/page_alloc.c   2004-03-10 08:34:21.000000000 -0500
@@ -268,6 +268,8 @@
         LIST_HEAD(list);
         int i;

+       arch_free_page(page, order);
+
         mod_page_state(pgfree, 1 << order);
         for (i = 0 ; i < (1 << order) ; ++i)
                 free_pages_check(__FUNCTION__, page + i);
@@ -457,6 +459,8 @@
         struct per_cpu_pages *pcp;
         unsigned long flags;

+       arch_free_page(page, 0);
+
         kernel_map_pages(page, 1, 0);



Thanks,
Jeff
[ jchua@fedex.com ]

On Mon, 24 May 2004, Jeff Dike wrote:

> This patch updates UML to 2.6.6.  Aside from the update, there were a few
> small bug fixes.
>
> The 2.6.6-1 UML patch is available at
> 	http://www.user-mode-linux.org/mirror/uml-patch-2.6.6-1.bz2
>
> BK users can pull my 2.5 repository from
> 	http://www.user-mode-linux.org:5000/uml-2.5
>
> For the other UML mirrors and other downloads, see
>        http://user-mode-linux.sourceforge.net/dl-sf.html
>
> Other links of interest:
>
>        The UML project home page : http://user-mode-linux.sourceforge.net
>        The UML Community site : http://usermodelinux.org
>
> 				Jeff
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
