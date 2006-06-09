Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWFIRf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWFIRf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWFIRf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:35:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751456AbWFIRf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:35:58 -0400
Date: Fri, 9 Jun 2006 10:35:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: hch@infradead.org, cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-Id: <20060609103543.52c00c62.akpm@osdl.org>
In-Reply-To: <4489AAD9.80806@garzik.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org>
	<20060609030759.48cd17a0.akpm@osdl.org>
	<44899653.1020007@garzik.org>
	<20060609095620.22326f9d.akpm@osdl.org>
	<4489AAD9.80806@garzik.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2006 13:07:37 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> I would propose the obvious...  'cp -a ext3 ext4', apply the extent and 
> 48bit patches, and then do the obvious search-n-replace.

Most of ext3 is JBD.  At least, in terms of complexity.  And I don't think
there's anything in this proposal which affects JBD, apart from changing
the blocksize.

Cloning JBD for this exercise would, I suspect, be the wrong thing to do -
the two clones would be pretty much identical, apart from some scalar
types.

I did suggest a couple of years ago that we should clone the ext3 part and
have both ext3 and ext4 use the same JBD layer - I don't know what happened
to that idea.

There has been steady, cautious but significant improvement happening in
ext3 over the past few years.  I'd expect that to continue, although
perhaps at a lower rate.  Having to apply the same changes to two
filesystems would be an obvious loss.

It comes down to looking at the patches, and I haven't done that in quite
some time.  Ideally the new functionality would all be under CONFIG_foo,
but I do not know if that is being proposed here?

> We need to draw a line in the sand.  If we don't, no one ever will.

You speak as if this is something which has happened before, or that it will
happen again.

All that being said, Linux's filesystems are looking increasingly crufty
and we are getting to the time where we would benefit from a greenfield
start-a-new-one.  That new one might even be based on reiser4 - has anyone
looked?  It's been sitting around for a couple of years.
