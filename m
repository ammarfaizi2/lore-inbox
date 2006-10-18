Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWJRJMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWJRJMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWJRJMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:12:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932134AbWJRJMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:12:39 -0400
Date: Wed, 18 Oct 2006 02:12:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       hch@infradead.org, mhalcrow@us.ibm.com, penberg@cs.helsinki.fi,
       linux-fsdevel@vger.kernel.org
Subject: Re: fsstack: struct path
Message-Id: <20061018021222.2c4d907c.akpm@osdl.org>
In-Reply-To: <20061018090623.GK29920@ftp.linux.org.uk>
References: <20061018042323.GA8537@filer.fsl.cs.sunysb.edu>
	<20061018013103.4ad6311a.akpm@osdl.org>
	<20061018013551.3745e1d5.akpm@osdl.org>
	<20061018090623.GK29920@ftp.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 10:06:23 +0100
Al Viro <viro@ftp.linux.org.uk> wrote:

> On Wed, Oct 18, 2006 at 01:35:51AM -0700, Andrew Morton wrote:
> > On Wed, 18 Oct 2006 01:31:03 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > > One, rather unfortunate, fact is that struct path is also defined in
> > > > include/linux/reiserfs_fs.h as something completely different - reiserfs
> > > > specific.
> > > > 
> > > > Any thoughts?
> > > > 
> > > 
> > > reiserfs is being bad.  s/path/reiserfs_path/g
> > 
> > There's also drivers/md/dm-mpath.h's struct path.  Renaming fs/namei.c's
> > `struct path' to `struct namei_path' would be prudent.
> 
> Yuck...  If we really want to switch to it (and I can give you a dozen
> examples of possible users right now - starting with struct file), putting
> namei_ into it is both uninformative and ugly.
> 
> I'm not sure what would be the good name here; "pathname" comes to mind,
> but it suggests that we are dealing with a string.  And "location" is
> too vague (and probably would cause fsckloads of conflicts itself).
> 
> Suggestions?  "pathname" would almost work; the difference is that this
> is not a string but a node in tree that string resolves to.

path_item?
