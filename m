Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbVAFNE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVAFNE2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVAFNE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:04:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51332 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262814AbVAFNEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:04:24 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050106113216.GA16261@infradead.org> 
References: <20050106113216.GA16261@infradead.org>  <20050103011113.6f6c8f44.akpm@osdl.org> <20050103100725.GA17856@infradead.org> 
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 06 Jan 2005 13:04:04 +0000
Message-ID: <27229.1105016644@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > > add-page-becoming-writable-notification.patch
> > >   Add page becoming writable notification
> > 
> > David, this still has the bogus address_space operation in addition to
> > the vm_operation.  page_mkwrite only fits into the vm_operations scheme,
> > so please remove the address_space op.  Also the code will be smaller
> > and faster witout that indirection..
> 
> Here's the fix:

That's not right either. Filesystems really shouldn't be overloading the
vm_ops on memory mappings (as has been made clear to me) and the VM low-level
paging routines shouldn't be touching a_ops (as has also been made clear to
me). I also have other reasons I don't want to have ordinary files with
specialised vm_ops.

I suppose I could try and build a little knowledge about fscache into the
VM... that might be reasonable.

Remember also that your change is going to affect NFS too eventually, assuming
NFS caching support ends up being done this way. It may also affect other
filesystems, such as SMB/CIFS and Coda eventually should they partake of
fscache services too.

David
