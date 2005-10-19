Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVJSUAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVJSUAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVJSUAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:00:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751267AbVJSUAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:00:49 -0400
Date: Wed, 19 Oct 2005 13:00:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: uszhaoxin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Is ext3 flush data to disk when files are closed?
Message-Id: <20051019130010.28693db1.akpm@osdl.org>
In-Reply-To: <1129737026.23632.113.camel@localhost.localdomain>
References: <4ae3c140510190831j7530742aqc2b82e9e9cd6dde3@mail.gmail.com>
	<1129737026.23632.113.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@gmail.com> wrote:
>
> On Wed, 2005-10-19 at 11:31 -0400, Xin Zhao wrote:
> > As far as I know, if an application modifies a file on an ext3 file
> > ssytem, it actually change the page cache, and the dirty pages will be
> > flushed to disk by kupdate periodically.
> > 
> > My question is: if a file is to be closed, but some of its data pages
> > are marked as dirty, will system block on close() and wait for dirty
> > pages being flushed to disk? If so, it seems to decrease performance
> > significantly if a lot of updates on many small files are involved.
> > 
> > Can someone point me to the right place to check how it works? Thanks!
> 
> On the last close() of the file, it should be flushed through ..
> 
> 	iput_final() -> generic_drop_inode() -> write_inode_now()
> 		-> __writeback_single_inode() -> __sync_single_inode()
> 			-> do_writepages()

The dcache's reference to the inode will prevent this from happening at
close() time.

