Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbUDAVYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUDAVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:24:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:20614 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263200AbUDAVNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:13:52 -0500
Date: Thu, 1 Apr 2004 16:15:50 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sridhar Samudrala <sri@us.ibm.com>
cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_DEBUG_PAGEALLOC and virt_addr_valid()
In-Reply-To: <Pine.LNX.4.58.0404011236200.5095@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0404011611430.29860@chaos>
References: <Pine.LNX.4.58.0404011105120.1956@localhost.localdomain>
 <20040401204407.A24608@infradead.org> <Pine.LNX.4.58.0404011236200.5095@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Sridhar Samudrala wrote:

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
>
> When an SCTP association is established, the pointer to the association
> structure is passed to the user as an identifier of the association. This
> identifier is used in the later calls by the user.
>
> -Sridhar

Are you now moving the protocol out of user-space and into the
kernel?  If so, you should use the Unix/Linux methods of reading/
writing user memory.

Any protection is on a per-page basis. If you give a user some
pointer into the kernel, he can destroy a whole page before it
is detected! So, even if virt_addr_valid() did the "right" thing
you'd be in a lot of trouble using it.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


