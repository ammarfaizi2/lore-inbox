Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265260AbUE2SZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbUE2SZH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 14:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbUE2SZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 14:25:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:27806 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265260AbUE2SYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 14:24:52 -0400
Date: Sat, 29 May 2004 11:23:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] remove net driver ugliness that sparse complains about
In-Reply-To: <40B8D2F8.6090905@pobox.com>
Message-ID: <Pine.LNX.4.58.0405291117511.1648@ppc970.osdl.org>
References: <40B8D2F8.6090905@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 May 2004, Jeff Garzik wrote:
> 
> I'm a bit curious why sparse complained about taking the _address_ of 
> pointer

It may not complain any more. Al sent me about 20 different test-cases for
things that sparse did wrong, and I've fixed most of them. As of
yesterday, most sparse warnings really _are_ valid (yeah, I'm sure there
are some broken cases still, but if so, now they are in a clear minority).

Note that that doesn't mean that they are all easy to fix. Some code tends
to re-use the same structure for sometimes holding kernel pointers, and
sometimes holding user pointers.

Since the whole point of sparse is to have _static_ typechecking, such
code will never be sparse-clean, and either we have to ignore it, or we
should split up the use into two different kinds of structures (with the
same members apart from the address space) and explicitly convert between
the two.  I'd obviously prefer that approach, but it might be a fair
amount of work (most of it should be really trivial, though, and I suspect
it would clarify pointer usage a lot to know when a "struct msghdr" points
to user space, and when it points to kernel space. Or whatever - maybe 
that was a bad example).

		Linus
