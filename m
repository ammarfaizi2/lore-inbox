Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbSJ2TJi>; Tue, 29 Oct 2002 14:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262122AbSJ2TJi>; Tue, 29 Oct 2002 14:09:38 -0500
Received: from citi.umich.edu ([141.211.92.141]:17828 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S262076AbSJ2TJh>;
	Tue, 29 Oct 2002 14:09:37 -0500
Date: Tue, 29 Oct 2002 14:15:56 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Badari Pulavarty <badari@us.ibm.com>
Cc: <linux-aio@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
       <akpm@digeo.com>
Subject: Re: [RFC] generic_file_direct_IO() argument changes for AIO
In-Reply-To: <200210291819.g9TIJvO16528@eng2.beaverton.ibm.com>
Message-ID: <Pine.BSO.4.33.0210291414120.11378-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Badari Pulavarty wrote:

> Inorder to support AIO for raw/O_DIRECT, I need to add "struct kiocb *"
> to generic_file_direct_IO() and all direct_IO() ops.
>
> generic_file_direct_IO(int rw, struct file *file, const struct iovec *iov,
>         loff_t offset, unsigned long nr_segs)
>
> Instead of adding a new argument, I propose replace
>
> 	"struct file *file" argument with "struct kiocb *iocb"
>
> One can get "filp" from iocb->ki_filp.
>
> Any objections ?

here's a naive objection.  is there any preallocated data structure
associated with a kiocb other than the struct itself?  if there is, that
will have some scalability impact for applications like Oracle that like
to create a very large database by opening thousands of files.

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

