Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWEVFfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWEVFfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 01:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWEVFfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 01:35:36 -0400
Received: from verein.lst.de ([213.95.11.210]:3735 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932111AbWEVFfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 01:35:36 -0400
Date: Mon, 22 May 2006 07:34:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, hch@lst.de, bcrl@kvack.org,
       cel@citi.umich.edu, zach.brown@oracle.com, linux-kernel@vger.kernel.org,
       Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use aio_read/aio_write instead
Message-ID: <20060522053450.GA22210@lst.de>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com> <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com> <1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com> <20060521180037.3c8f2847.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521180037.3c8f2847.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 06:00:37PM -0700, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > This patch removes readv() and writev() methods and replaces
> >  them with aio_read()/aio_write() methods.
> 
> And it breaks autofs4
> 
> autofs: pipe file descriptor does not contain proper ops

this comes because the autofs4 pipe fd doesn't have a write file
operations.

Badari do you remember any place in your patches where you didn't
add do_sync_write for a file_operations instance?

Ian, what kind of file is the autofs4 pipe?  is it a named pipe or
a fifo or a "real" file?
