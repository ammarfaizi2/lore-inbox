Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWCHMrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWCHMrc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWCHMrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:47:32 -0500
Received: from verein.lst.de ([213.95.11.210]:31124 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751667AbWCHMrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:47:31 -0500
Date: Wed, 8 Mar 2006 13:47:26 +0100
From: christoph <hch@lst.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Zach Brown <zach.brown@oracle.com>, christoph <hch@lst.de>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3]  VFS changes to collapse all the vectored and AIO support
Message-ID: <20060308124726.GC4128@lst.de>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 04:19:59PM -0800, Badari Pulavarty wrote:
> Hi,
> 
> These series of changes collapses all the vectored IO support 
> into single file-operation method using aio_read/aio_write. 
> 
> This work was originally suggested & started by Christoph Hellwig, 
> when Zach Brown tried to add vectored support for AIO. 
> 
> Christoph & Zach, comments/suggestions ? If you are happy with the
> work, can you add your Sign-off or Ack ? I addressed all the
> known issues, please review.

the first two patches are fine with me, they're basically my patches
with the bugs fixed and the missing conversions done, so they must be
good ;-)

can't really comment on the third one because I don't understand the
aio internals good enough.

Onced this goes to -mm we should add a third patch to kill
generic_file_read/generic_file_write and convert all filesystems to the
aio/vectored variant and use do_sync_read/do_sync_write for
.read/.write.  The major syscalls use the aio_ variant directly anyway,
this is only needed for some special cases like the ELF loader.
Removing generic_file_read/generic_file_write will finally cut filemap.c
back to a sane size.

