Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUBYTxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUBYTvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:51:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:7126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261413AbUBYTuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:50:23 -0500
Date: Wed, 25 Feb 2004 11:50:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: jlcooke@certainkey.com, christophe@saout.de, linux-kernel@vger.kernel.org,
       adam@yggdrasil.com
Subject: Re: cryptoapi highmem bug
Message-Id: <20040225115027.580cc2ed.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0402250825110.28907-100000@thoron.boston.redhat.com>
References: <20040224220030.13160197.akpm@osdl.org>
	<Xine.LNX.4.44.0402250825110.28907-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> On Tue, 24 Feb 2004, Andrew Morton wrote:
> 
> > Jean-Luc Cooke <jlcooke@certainkey.com> wrote:
> > >
> > > How do I check for equal real addresses from two virtual ones?
> > 
> > I don't think there is a practical way of doing this.  It would involve
> > comparing the virtual address with the kmap and atomic kmap regions,
> > performing a pagetable walk, extracting the pageframe.  If the page is not
> > in a kmap area generate the pageframe directly.  Make that work on all
> > architectures.  Very yuk.
> > 
> > If practical this API should have been defined in terms of
> > (page/offset/len) and it should have kmapped the pages itself.  I guess
> > it's too late for that.
> 
> Do you mean that the crypt() function should do kmapping?

Passing the page* down one more level would permit cbc_process() to get at
the pageframes themselves, so it can sanely determine if src and dest
overlap.  (I assume this is for encryption-in-place).

Or maybe it's sufficient for crypt() to pass a simple boolean down to the
prfn() callout which says "this is in-place encryption".

