Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWEFCWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWEFCWj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 22:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWEFCWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 22:22:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750792AbWEFCWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 22:22:37 -0400
Date: Fri, 5 May 2006 19:21:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: shaggy@austin.ibm.com, dhowells@redhat.com, phillip@hellewell.homeip.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       jmorris@namei.org, sct@redhat.com, ezk@cs.sunysb.edu
Subject: Re: [PATCH 10/13: eCryptfs] Mmap operations
Message-Id: <20060505192148.e2c968b7.akpm@osdl.org>
In-Reply-To: <1146843528.11271.1.camel@localhost>
References: <84144f020605040813q29fcddcr1c846d27cf156432@mail.gmail.com>
	<20060504031755.GA28257@hellewell.homeip.net>
	<20060504034127.GI28613@hellewell.homeip.net>
	<23514.1146779003@warthog.cambridge.redhat.com>
	<1146842548.10109.27.camel@kleikamp.austin.ibm.com>
	<1146843528.11271.1.camel@localhost>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2006 18:38:48 +0300
Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> On Thu, 2006-05-04 at 22:43 +0100, David Howells wrote:
> > > When writing CacheFiles, I noticed that ext3 would occasionally unlock a page
> > > that had neither PG_uptodate nor PG_error set, and so I had to force another
> > > readpage() on it.
> 
> On Fri, 2006-05-05 at 10:22 -0500, Dave Kleikamp wrote:
> > I understand this comes from the FiST package.  In that code, there is a
> > comment in one of these functions explaining the second read.  It would
> > be nice to have that comment in here too:
> > 
> >    /*
> >     * call readpage() again if we returned from wait_on_page with a
> >     * page that's not up-to-date; that can happen when a partial
> >     * page has a few buffers which are ok, but not the whole
> >     * page.
> >     */
> > 
> > I'm a bit surprised that this could happen.
> 
> Me too. How do we know we don't end up the same way for the second read?
> 

And why doesn't it cause do_generic_mapping_read() and page_cache_read() to
fail?

This is all raher fishy.
