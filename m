Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267316AbTGHNjI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267308AbTGHNjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:39:07 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:39687 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S267323AbTGHNhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:37:14 -0400
Date: Tue, 8 Jul 2003 23:50:23 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Christoph Hellwig <hch@infradead.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
In-Reply-To: <20030708123304.A17486@infradead.org>
Message-ID: <Mutt.LNX.4.44.0307082337350.8438-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Christoph Hellwig wrote:

> We use this callbacks in a bunch opf places, maybe add hash_value_t
> and keycmp_t typedefs for them to avoid typing the prototypes all
> the time?

I think this is a good idea in general, but am not sure if others agree.

> > +	p = kmalloc(sizeof(*p), GFP_KERNEL);
> 
> Pass the GFP_ mask down to hashtab_create() maybe?

Would someone need to allocate a hashtab in interrupt context?

> > +		if (prev) {
> > +			newnode->next = prev->next;
> > +			prev->next = newnode;
> 
> Use hlists?

They're overkill for this, I think.

> > +config HASHTAB
> > +	tristate "Generic hash table support"
> 
> Should this really be a user option or rather implicitly selected
> by it's users?

As with the crc32 module, we don't know if any out of tree modules will 
need to use it.

(The rest of the suggestions I agree with).

> > + -fno-strict-aliasing -fno-common -g
> 
> accident?

Yes.

Thanks for the feedback.


- James
-- 
James Morris
<jmorris@intercode.com.au>


