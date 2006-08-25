Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWHYQXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWHYQXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 12:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWHYQXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 12:23:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28890 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030183AbWHYQXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 12:23:10 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060825142753.GK10659@infradead.org> 
References: <20060825142753.GK10659@infradead.org>  <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 17:23:05 +0100
Message-ID: <10117.1156522985@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> Can you put this two into a single ifdef block?

I suppose it could make sense to move the two disk random source functions
together.

> >  config USB_STORAGE
> >  	tristate "USB Mass Storage support"
> > -	depends on USB
> > +	depends on USB && BLOCK
> 
> ditto.

ditto?

> again, try to reorder things here to only require a single ifdef block
> (or rather two, a second one for the array entries) if possible.

The problem with reordering things is that it makes the patch bigger, and that
makes people complain about not minimalising the changes.

> Can we put this into some other file under #ifndef CONFIG_BLOCK to
> avoid the separate file and makefile ugliness?

*blink*

What've you done with the real Christoph Hellwig?  You're actually *advocating*
the use of a cpp-conditional in a .c file!

It doesn't really belong in any of the files that are left.

> No one should include this file unless block device support is enabled,
> so I don't see the point for the ifdefs.  Ditto for many other header
> files you touch that don't contain any stubs for generic code.

Someone did.  Might've been USB storage now that I think about it.

> And btw, shouldn't the option be CONFIG_BLK_DEV instead of CONFIG_BLOCK
> to fit the variour CONFIG_BLK_DEV_FOO options we have?

No.

I'm not enabling a specific block device driver.  I'm taking out the entire
block layer, block drivers, block scheduler and everything that depends on it
(such as SCSI).

David
