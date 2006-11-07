Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753557AbWKGWLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbWKGWLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbWKGWLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:11:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42629 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753586AbWKGWKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:10:00 -0500
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Jeff Layton <jlayton@redhat.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>, Eric Sandeen <sandeen@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061107212012.GC27140@parisc-linux.org>
References: <454FA032.1070008@redhat.com>
	 <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com>
	 <1162914966.28425.24.camel@dantu.rdu.redhat.com>
	 <20061107172835.GB15629@wohnheim.fh-wedel.de>
	 <20061107174217.GA29746@wohnheim.fh-wedel.de>
	 <20061107175601.GB29746@wohnheim.fh-wedel.de>
	 <1162928464.28425.59.camel@dantu.rdu.redhat.com>
	 <20061107204135.GF29746@wohnheim.fh-wedel.de>
	 <1162933980.28425.64.camel@dantu.rdu.redhat.com>
	 <20061107212012.GC27140@parisc-linux.org>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 17:09:57 -0500
Message-Id: <1162937397.3689.5.camel@tleilax.poochiereds.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 14:20 -0700, Matthew Wilcox wrote:
> On Tue, Nov 07, 2006 at 04:13:00PM -0500, Jeff Layton wrote:
> > +	/* ino must not collide with any ino assigned in the loop below. Set
> > +	   it to the highest possible inode number */
> > +	inode->i_ino = (1 << (sizeof(s->s_lastino) * 8)) - 1;
> 
> This really isn't a good idiom to be using; GCC now takes this to mean
> "I can reformat your hard drive because you did something outside the
> spec".
> 
> Try instead:
> +	inode->i_ino = -1;
> 

The problem there is that on platforms with a 64-bit ino_t, this will be
too large to fit in a 32-bit field and we'll end up with the same
EOVERFLOW problem. Is there a more correct way to make it size
appropriately given the different possible sizes of s_lastino?

I suppose we could just set it to 0xffffffff and hope that that is "big
enough" for most cases.

-- Jeff


