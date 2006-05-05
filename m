Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWEENMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWEENMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 09:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWEENMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 09:12:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:16020 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751102AbWEENMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 09:12:23 -0400
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>
In-Reply-To: <23457.1146778849@warthog.cambridge.redhat.com>
References: <84144f020605040737k316fd5abva4476da69a65c084@mail.gmail.com>
	 <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504033829.GE28613@hellewell.homeip.net>
	 <23457.1146778849@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 05 May 2006 08:12:20 -0500
Message-Id: <1146834740.10109.9.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 22:40 +0100, David Howells wrote:
> Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> 
> > > +       ecryptfs_printk(KERN_DEBUG, "Enter; inode = [%p]\n", inode);
> > > +       crypt_stat = &(ECRYPTFS_INODE_TO_PRIVATE(inode))->crypt_stat;
> > > +       ecryptfs_destruct_crypt_stat(crypt_stat);
> > > +       kmem_cache_free(ecryptfs_inode_info_cache,
> > > +                       ECRYPTFS_INODE_TO_PRIVATE(inode));
> > 
> > Better to introduce a local variable for CRYPTFS_INODE_TO_PRIVATE.
> > More readable and smaller kernel text that way.
> 
> But it may use more stack, which is a much more limited resource, so what you
> suggest is not necessarily the best thing to do.

I think either way it's coded, the compiler will probably store the
result in a register.  I would recommend the most readable approach
(which I believe would be using a local variable) and leave the
optimization to the compiler.

> David

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

