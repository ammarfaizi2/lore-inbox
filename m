Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUEDIsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUEDIsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 04:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUEDIsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 04:48:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:23524 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264265AbUEDIsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 04:48:01 -0400
Date: Tue, 4 May 2004 01:47:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: arjanv@redhat.com
Cc: nickpiggin@yahoo.com.au, peter@mysql.com, linuxram@us.ibm.com,
       alexeyk@mysql.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040504014729.72b9220a.akpm@osdl.org>
In-Reply-To: <1083659274.3844.2.camel@laptop.fenrus.com>
References: <200405022357.59415.alexeyk@mysql.com>
	<409629A5.8070201@yahoo.com.au>
	<20040503110854.5abcdc7e.akpm@osdl.org>
	<1083615727.7949.40.camel@localhost.localdomain>
	<20040503135719.423ded06.akpm@osdl.org>
	<1083620245.23042.107.camel@abyss.local>
	<20040503145922.5a7dee73.akpm@osdl.org>
	<4096DC89.5020300@yahoo.com.au>
	<20040503171005.1e63a745.akpm@osdl.org>
	<1083659274.3844.2.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> 
> > 
> > That would cause the kernel to perform lots of pointless pagecache lookups
> > when the file is already 100% cached.
> 
> well surely the read itself will do those AGAIN anyway, so in the fully
> cached case this is just warming up the cpu cache ;)  (and thus really
> cheap as nett cost I suspect)

Probably true for x86, but the cost is noticeable on ppc64, for example. 
Anton fixed some things in there shortly after it went in, but it's still
apparent on profiles.

We could perhaps speed things up a little bit by using gang lookup in both
__do_page_cache_readahead() and in do_generic_file_read().
