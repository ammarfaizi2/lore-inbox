Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUDBBkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbUDBBkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:40:15 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:37262 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263513AbUDBBkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:40:05 -0500
Date: Thu, 1 Apr 2004 17:39:49 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_DEBUG_PAGEALLOC and virt_addr_valid()
In-Reply-To: <20040401162943.149ee719.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404011727350.3007@localhost.localdomain>
References: <Pine.LNX.4.58.0404011105120.1956@localhost.localdomain>
 <20040401204407.A24608@infradead.org> <Pine.LNX.4.58.0404011236200.5095@localhost.localdomain>
 <20040401162943.149ee719.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Andrew Morton wrote:

> Sridhar Samudrala <sri@us.ibm.com> wrote:
> >
> > On Thu, 1 Apr 2004, Christoph Hellwig wrote:
> >
> > > On Thu, Apr 01, 2004 at 11:11:39AM -0800, Sridhar Samudrala wrote:
> > > > When CONFIG_DEBUG_PAGEALLOC is enabled, i am noticing that virt_addr_valid()
> > > > (called from sctp_is_valid_kaddr()) is returning true even for freed objects.
> > > > Is this a bug or expected behavior?
> > >
> > > Generally every use of virt_addr_valid() is a bug.  What are you trying to
> > > do?
> >
> > We are trying to validate a kernel address that is passed by the user. Is
> > there a better way to do that?
>
> yup.  Pass the user an integer.
>
> > When an SCTP association is established, the pointer to the association
> > structure is passed to the user as an identifier of the association. This
> > identifier is used in the later calls by the user.
>
> Please don't do that.  See lib/idr.c.  I expect it does exactly what you
> want.

Yes. I think i should be able to use it to generate ids for the associations.
Thanks for pointing it out.
-Sridhar
