Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWEVJgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWEVJgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 05:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWEVJgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 05:36:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20686 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbWEVJgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 05:36:01 -0400
Date: Mon, 22 May 2006 02:35:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: hch@lst.de, pbadari@us.ibm.com, bcrl@kvack.org, cel@citi.umich.edu,
       zach.brown@oracle.com, linux-kernel@vger.kernel.org, raven@themaw.net
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use
 aio_read/aio_write instead
Message-Id: <20060522023519.2541f082.akpm@osdl.org>
In-Reply-To: <20060522022917.3e563261.akpm@osdl.org>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	<1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
	<1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com>
	<20060521180037.3c8f2847.akpm@osdl.org>
	<20060522053450.GA22210@lst.de>
	<20060522022917.3e563261.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Sun, May 21, 2006 at 06:00:37PM -0700, Andrew Morton wrote:
> > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > >
> > > > This patch removes readv() and writev() methods and replaces
> > > >  them with aio_read()/aio_write() methods.
> > > 
> > > And it breaks autofs4
> > > 
> > > autofs: pipe file descriptor does not contain proper ops
> > 
> > this comes because the autofs4 pipe fd doesn't have a write file
> > operations.
> > 
> 
> Note that fs/autofs/inode.c does the same thing.

The loop driver plays with file_operations.write() also.  The code should
be reviewed and tested against filesystems which use LO_FLAGS_USE_AOPS as
well as against those which do not, please.
