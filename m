Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVFQVMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVFQVMo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 17:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVFQVMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 17:12:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262084AbVFQVMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 17:12:40 -0400
Date: Fri, 17 Jun 2005 14:13:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
Message-Id: <20050617141331.078e5f8f.akpm@osdl.org>
In-Reply-To: <42B2E7D2.9080705@us.ibm.com>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
	<20050616002451.01f7e9ed.akpm@osdl.org>
	<1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com>
	<20050616133730.1924fca3.akpm@osdl.org>
	<1118965381.4301.488.camel@dyn9047017072.beaverton.ibm.com>
	<20050616175130.22572451.akpm@osdl.org>
	<42B2E7D2.9080705@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> > It shouldn't be necessary to do both.  Either the patch or the tuning
> > should fix it.  Please confirm.
> > 
> > Also please determine whether the deep CFQ queue depth is a problem when
> > the VFS tuning/patching is in place.
> > 
> > IOW: let's work out which of these three areas needs to be addressed.
> > 
> 
> Andrew,
> 
> Sorry for not getting back earlier. I am running into weird problems.
> When running "dd" write tests to 2048 ext3 filesystems, just with your
> patch (no dirty ratio or CFS queue depth tuning), I see "buff" 
> increasing instead of "cache" and I see "bi" instead of "bo".
> Whats going on here ?

Beats me.  Are you sure you're not running a broken vmstat?

`buff' would increase if you were accidentally writing to /dev/sda1 rather
than /dev/sda1/some-filename, but I don't know why vmstat would be getting
confused over the direction of the I/O.

> 
> procs -----------memory---------- ---swap-- -----io---- --system-- 
> ----cpu----
>   r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
> sy id wa
> ..
>   2  0      4 6339920  42712  24884    0    0     0    19  413  1237 46 
>   6 48  0

You're wordwrapping...
