Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUHNTua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUHNTua (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUHNTjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:39:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49122 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264857AbUHNTdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:33:06 -0400
Date: Sat, 14 Aug 2004 15:32:47 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       <neilb@cse.unsw.edu.au>, <viro@parcelfarce.linux.theplanet.co.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][LIBFS] Move transaction file ops into libfs + cleanup
 (update)
In-Reply-To: <20040814182027.GA23293@electric-eye.fr.zoreil.com>
Message-ID: <Xine.LNX.4.44.0408141524530.27390-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2004, Francois Romieu wrote:

> > +static inline void simple_transaction_set(struct file *file, size_t n)
> > +{
> > +	struct simple_transaction_argresp *ar = file->private_data;
> > +	
> > +	BUG_ON(n > SIMPLE_TRANSACTION_LIMIT);
> > +	mb();
> > +	ar->size = n;
> > +}
> 
> Could you add the justification for the 'mb' (or the expected effect on the
> api) as a comment ?

This ensures that ar->size will really remain zero until ar->data is ready
for reading.

- James
-- 
James Morris
<jmorris@redhat.com>


