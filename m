Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVACRT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVACRT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVACRT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:19:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58313 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261506AbVACRTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:19:34 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.6.10-mm1
Date: Mon, 3 Jan 2005 09:19:20 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103100725.GA17856@infradead.org>
In-Reply-To: <20050103100725.GA17856@infradead.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y6X2BQTEjJdzevP"
Message-Id: <200501030919.20670.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Y6X2BQTEjJdzevP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday, January 3, 2005 2:07 am, Christoph Hellwig wrote:
> > add-page-becoming-writable-notification.patch
> >   Add page becoming writable notification
>
> David, this still has the bogus address_space operation in addition to
> the vm_operation.  page_mkwrite only fits into the vm_operations scheme,
> so please remove the address_space op.  Also the code will be smaller
> and faster witout that indirection..

And apparently it's broken on NUMA.  I couldn't find 
generic_file_get/set_policy in my tree, which builds with CONFIG_NUMA 
enabled.

Jesse

--Boundary-00=_Y6X2BQTEjJdzevP
Content-Type: text/plain;
  charset="iso-8859-1";
  name="numa-file-policy-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="numa-file-policy-fix.patch"

diff -Napur -X /home/jbarnes/dontdiff linux-2.6.10-mm1.orig/mm/filemap.c linux-2.6.10-mm1/mm/filemap.c
--- linux-2.6.10-mm1.orig/mm/filemap.c	2005-01-03 08:58:46.000000000 -0800
+++ linux-2.6.10-mm1/mm/filemap.c	2005-01-03 09:04:32.000000000 -0800
@@ -1542,10 +1542,6 @@ struct vm_operations_struct generic_file
 	.nopage		= filemap_nopage,
 	.populate	= filemap_populate,
 	.page_mkwrite	= filemap_page_mkwrite,
-#ifdef CONFIG_NUMA
-	.set_policy     = generic_file_set_policy,
-	.get_policy     = generic_file_get_policy,
-#endif
 };
 
 /* This is used for a general mmap of a disk file */

--Boundary-00=_Y6X2BQTEjJdzevP--
