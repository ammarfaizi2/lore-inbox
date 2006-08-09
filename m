Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWHITPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWHITPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWHITPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:15:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:9700 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751336AbWHITPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:15:35 -0400
Subject: Re: [PATCH 5/6] clean up OCFS2 nlink handling
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060809171253.GE7324@infradead.org>
References: <20060809165729.FE36B262@localhost.localdomain>
	 <20060809165733.704AD0F5@localhost.localdomain>
	 <20060809171253.GE7324@infradead.org>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 12:15:26 -0700
Message-Id: <1155150926.19249.175.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 18:12 +0100, Christoph Hellwig wrote:
> On Wed, Aug 09, 2006 at 09:57:33AM -0700, Dave Hansen wrote:
> > OCFS2 does some operations on i_nlink, then reverts them if some
> > of its operations fail to complete.  This does not fit in well
> > with the drop_nlink() logic where we expect i_nlink to stay at
> > zero once it gets there.
> > 
> > So, delay all of the nlink operations until we're sure that the
> > operations have completed.  Also, introduce a small helper to
> > check whether an inode has proper "unlinkable" i_nlink counts
> > no matter whether it is a directory or regular inode.
> > 
> > This patch is broken out from the others because it does contain
> > some logical changes.
> 
> looks good to me, although I probably can't ACK ocfs2 patches.

That's probably OK.  One of the Oracle guys was nice enough to help me
beat it into shape and sign off on it.

> did you look whether gfs2 in -mm needs something similar?

It doesn't appear to.  It doesn't manipulate i_nlink in the same, direct
manner.

-- Dave

