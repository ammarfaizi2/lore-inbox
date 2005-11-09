Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbVKIXEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbVKIXEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbVKIXEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:04:15 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:15747 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751544AbVKIXEO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:04:14 -0500
Subject: Re: [PATCH] Remove read-only check from inode_update_time().
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@lst.de
In-Reply-To: <Pine.LNX.4.64.0511092243001.7946@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0511092243001.7946@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 17:04:11 -0600
Message-Id: <1131577451.21652.10.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 22:48 +0000, Anton Altaparmakov wrote:
> Hi Andrew,
> 
> The read-only check in inode_update_time() (or file_update_time() as it is 
> now in -mm) is unnecessary as the VFS better have done all the read-only 
> checks and aborted much earlier in the file write code paths where 
> inode/file_update_time() is only called from.

I notice inode_update_time is called from pipe_writev.  I don't know how
likely it would be in practice, but wouldn't it be possible to write to
a pipe on a read-only partition?  In that case the read-only check still
makes sense.

> (In case you were not following the ntfs discussion, Christoph Hellwig 
> agreed that check is unnecessary and can be removed.)
> 
> Patch against latest Linus git tree is below, please apply.  If you prefer 
> a patch on top of Christoph's file_update_time() check please let me 
> know...
> 
> Best regards,
> 
> 	Anton
-- 
David Kleikamp
IBM Linux Technology Center

