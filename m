Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWCHQWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWCHQWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWCHQWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:22:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:41417 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751242AbWCHQWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:22:44 -0500
Subject: Re: [RFC PATCH 0/3]  VFS changes to collapse all the vectored and
	AIO support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: christoph <hch@lst.de>
Cc: Zach Brown <zach.brown@oracle.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, bcrl@kvack.org
In-Reply-To: <20060308124726.GC4128@lst.de>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
	 <20060308124726.GC4128@lst.de>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 08:24:13 -0800
Message-Id: <1141835053.17095.58.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 13:47 +0100, christoph wrote:
> On Tue, Mar 07, 2006 at 04:19:59PM -0800, Badari Pulavarty wrote:
> > Hi,
> > 
> > These series of changes collapses all the vectored IO support 
> > into single file-operation method using aio_read/aio_write. 
> > 
> > This work was originally suggested & started by Christoph Hellwig, 
> > when Zach Brown tried to add vectored support for AIO. 
> > 
> > Christoph & Zach, comments/suggestions ? If you are happy with the
> > work, can you add your Sign-off or Ack ? I addressed all the
> > known issues, please review.
> 
> the first two patches are fine with me, they're basically my patches
> with the bugs fixed and the missing conversions done, so they must be
> good ;-)

:)

I rewrote usb/gadget/inode.c ep_aio_* support 3 times. I am still not
sure if I got it right. Can you review them ? I have no way to test
them.

> 
> can't really comment on the third one because I don't understand the
> aio internals good enough.

Zach okayed the changes. I am depending on BenL's expertise to review
them little more closely, before pushing to -mm.

> Onced this goes to -mm we should add a third patch to kill
> generic_file_read/generic_file_write and convert all filesystems to the
> aio/vectored variant and use do_sync_read/do_sync_write for
> .read/.write.  The major syscalls use the aio_ variant directly anyway,
> this is only needed for some special cases like the ELF loader.
> Removing generic_file_read/generic_file_write will finally cut filemap.c
> back to a sane size.

Yep.

Thanks,
Badari

