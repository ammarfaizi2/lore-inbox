Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932713AbWF1D72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbWF1D72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 23:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWF1D72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 23:59:28 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:44439 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932713AbWF1D71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 23:59:27 -0400
Subject: Re: [PATCH 19/20] elevate writer count for custom 'struct file'
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com
In-Reply-To: <20060627194011.d485c0ec.akpm@osdl.org>
References: <20060627221436.77CCB048@localhost.localdomain>
	 <20060627221456.F6AD6304@localhost.localdomain>
	 <20060627194011.d485c0ec.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 20:59:08 -0700
Message-Id: <1151467148.24103.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 19:40 -0700, Andrew Morton wrote:
> On Tue, 27 Jun 2006 15:14:56 -0700
> Dave Hansen <haveblue@us.ibm.com> wrote:
> 
> > Some filesystems forego the vfs and may_open() and create their
> > own 'struct file's.  Any of these users which set the write flag
> > on the file will cause an extra mnt_drop_write() on __fput(),
> > thus dropping the reference count too low.
> > 
> > These users tend to have artifical in-kernel vfsmounts which
> > aren't really exposed to userspace and can't be remounted, but
> > this patch is included for completeness and so that the warnings
> > don't trip over these cases.
> 
> Does the fake_file in fs/block_dev.c need similar treatment?

In practice, I think it should be OK.  The reference drop in __fput() is
only when the 'struct file' is !special_file(), which I assume all of
those block_dev.c files will be.  

I'll examine it in more detail to make sure this is true for all of the
users.

-- Dave

