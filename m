Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbUDAWdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbUDAWdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:33:37 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:52630 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263146AbUDAWd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:33:29 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] lockfs patch for 2.6
Date: Thu, 1 Apr 2004 16:32:48 -0600
User-Agent: KMail/1.6
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       thornber@redhat.com
References: <1078867885.25075.1458.camel@watt.suse.com> <20040326102549.A4248@infradead.org> <1080851723.3547.285.camel@watt.suse.com>
In-Reply-To: <1080851723.3547.285.camel@watt.suse.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404011632.49003.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 2:35 pm, Chris Mason wrote:
> On Fri, 2004-03-26 at 05:25, Christoph Hellwig wrote:
> > On Sun, Mar 14, 2004 at 10:23:31AM -0500, Chris Mason wrote:
> > > > P.S. this patch now kills 16 lines of kernel code summarized :)
> > >
> > > It looks good, I'll give it a try.
> >
> > ping?  I've seen you merged the old patch into the suse tree, and having
> > shipping distros with incompatible APIs doesn't sound exactly like a good
> > idea..
>
> Christoph's vfs patch looks good, I've stripped out the XFS bits (FS
> parts should probably be in different patches) and made one small
> change.  freeze/thaw now check to make sure bdev != NULL.
>
> On the device mapper side, I had to add a struct super_block pointer to
> the dm struct and changed it to pin the bdev struct during the freeze.
> Before, it could go away due to bdput, leading to deadlock when someone
> else got a bdev struct with bd_mount_sem held.
>
> New patches attached, along with an incremental to clearly show my
> changes to the dm patch.
>
> -chris

Thanks Chris! I'll test the new VFS-lock code in the morning.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
