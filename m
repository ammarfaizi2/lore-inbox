Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbSJ2TXd>; Tue, 29 Oct 2002 14:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262154AbSJ2TXc>; Tue, 29 Oct 2002 14:23:32 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:63403 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262126AbSJ2TXc>; Tue, 29 Oct 2002 14:23:32 -0500
From: Badari Pulavarty <badari@us.ibm.com>
Message-Id: <200210291928.g9TJSuG07916@eng2.beaverton.ibm.com>
Subject: Re: [RFC] generic_file_direct_IO() argument changes for AIO
To: cel@citi.umich.edu (Chuck Lever)
Date: Tue, 29 Oct 2002 11:28:55 -0800 (PST)
Cc: badari@us.ibm.com (Badari Pulavarty), linux-aio@kvack.org,
       linux-kernel@vger.kernel.org (lkml), akpm@digeo.com
In-Reply-To: <Pine.BSO.4.33.0210291414120.11378-100000@citi.umich.edu> from "Chuck Lever" at Oct 29, 2002 01:15:56 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, 29 Oct 2002, Badari Pulavarty wrote:
> 
> > Inorder to support AIO for raw/O_DIRECT, I need to add "struct kiocb *"
> > to generic_file_direct_IO() and all direct_IO() ops.
> >
> > generic_file_direct_IO(int rw, struct file *file, const struct iovec *iov,
> >         loff_t offset, unsigned long nr_segs)
> >
> > Instead of adding a new argument, I propose replace
> >
> > 	"struct file *file" argument with "struct kiocb *iocb"
> >
> > One can get "filp" from iocb->ki_filp.
> >
> > Any objections ?
> 
> here's a naive objection.  is there any preallocated data structure
> associated with a kiocb other than the struct itself?  if there is, that
> will have some scalability impact for applications like Oracle that like
> to create a very large database by opening thousands of files.
> 
> 	- Chuck Lever

If the application is not using Async IO, "kiocb" structure comes
from stack. Other than that, there are no preallocated strcutures
associated with kiocb.

- Badari
