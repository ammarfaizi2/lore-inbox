Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUDBA1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUDBA1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:27:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:59339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262499AbUDBA1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:27:36 -0500
Date: Thu, 1 Apr 2004 16:29:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_DEBUG_PAGEALLOC and virt_addr_valid()
Message-Id: <20040401162943.149ee719.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404011236200.5095@localhost.localdomain>
References: <Pine.LNX.4.58.0404011105120.1956@localhost.localdomain>
	<20040401204407.A24608@infradead.org>
	<Pine.LNX.4.58.0404011236200.5095@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sridhar Samudrala <sri@us.ibm.com> wrote:
>
> On Thu, 1 Apr 2004, Christoph Hellwig wrote:
> 
> > On Thu, Apr 01, 2004 at 11:11:39AM -0800, Sridhar Samudrala wrote:
> > > When CONFIG_DEBUG_PAGEALLOC is enabled, i am noticing that virt_addr_valid()
> > > (called from sctp_is_valid_kaddr()) is returning true even for freed objects.
> > > Is this a bug or expected behavior?
> >
> > Generally every use of virt_addr_valid() is a bug.  What are you trying to
> > do?
> 
> We are trying to validate a kernel address that is passed by the user. Is
> there a better way to do that?

yup.  Pass the user an integer.

> When an SCTP association is established, the pointer to the association
> structure is passed to the user as an identifier of the association. This
> identifier is used in the later calls by the user.

Please don't do that.  See lib/idr.c.  I expect it does exactly what you
want.
