Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWEVJ3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWEVJ3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 05:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWEVJ3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 05:29:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23244 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750954AbWEVJ3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 05:29:45 -0400
Date: Mon, 22 May 2006 02:29:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: pbadari@us.ibm.com, hch@lst.de, bcrl@kvack.org, cel@citi.umich.edu,
       zach.brown@oracle.com, linux-kernel@vger.kernel.org, raven@themaw.net
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use
 aio_read/aio_write instead
Message-Id: <20060522022917.3e563261.akpm@osdl.org>
In-Reply-To: <20060522053450.GA22210@lst.de>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	<1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
	<1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com>
	<20060521180037.3c8f2847.akpm@osdl.org>
	<20060522053450.GA22210@lst.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, May 21, 2006 at 06:00:37PM -0700, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > This patch removes readv() and writev() methods and replaces
> > >  them with aio_read()/aio_write() methods.
> > 
> > And it breaks autofs4
> > 
> > autofs: pipe file descriptor does not contain proper ops
> 
> this comes because the autofs4 pipe fd doesn't have a write file
> operations.
> 

Note that fs/autofs/inode.c does the same thing.
