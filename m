Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUHOWeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUHOWeI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUHOWeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:34:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:50120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267189AbUHOWeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:34:05 -0400
Date: Sun, 15 Aug 2004 15:32:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: romieu@fr.zoreil.com, sds@epoch.ncsc.mil, neilb@cse.unsw.edu.au,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][LIBFS] Move transaction file ops into libfs + cleanup
 (update)
Message-Id: <20040815153211.1367066f.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0408141524530.27390-100000@dhcp83-76.boston.redhat.com>
References: <20040814182027.GA23293@electric-eye.fr.zoreil.com>
	<Xine.LNX.4.44.0408141524530.27390-100000@dhcp83-76.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> On Sat, 14 Aug 2004, Francois Romieu wrote:
> 
> > > +static inline void simple_transaction_set(struct file *file, size_t n)
> > > +{
> > > +	struct simple_transaction_argresp *ar = file->private_data;
> > > +	
> > > +	BUG_ON(n > SIMPLE_TRANSACTION_LIMIT);
> > > +	mb();
> > > +	ar->size = n;
> > > +}
> > 
> > Could you add the justification for the 'mb' (or the expected effect on the
> > api) as a comment ?
> 
> This ensures that ar->size will really remain zero until ar->data is ready
> for reading.

I updated the patch to include this important detail in a comment. 
Shouldn't it be an smb_mb()?
