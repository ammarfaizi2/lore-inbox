Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269495AbUJLGzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269495AbUJLGzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269498AbUJLGzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:55:11 -0400
Received: from dyn3.mc.tuwien.ac.at ([128.130.175.85]:56964 "EHLO
	mail.13thfloor.at") by vger.kernel.org with ESMTP id S269495AbUJLGzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:55:04 -0400
Date: Tue, 12 Oct 2004 09:00:55 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041012070055.GB7003@DUMA.13thfloor.at>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	chrisw@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097502444.31259.19.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 02:47:29PM +0100, Alan Cox wrote:
> On Sul, 2004-10-10 at 11:41, Christoph Hellwig wrote:
> > Your filesystem handling code is completely superflous (and buggy).  Please
> > remove all the code dealing with chroot-lookalikes.  In your userland script
> > you simpl have to clone(.., CLONE_NEWNS) to detach your namespace from your
> > parent, then you can lazly unmount all filesystems and setup your new namespace
> > before starting the jail.  The added advantage is that you don't need any
> > cludges to keep the user from exiting the chroot.
> 
> AF_UNIX socket and fchdir().
> 
> That however requires a co-operator outside the chroot so doesn't seem
> to be a problem. I like the CLONE approach, its a lot cleaner.

and it works well, because we use it for almost
a year now on linux-vserver ;)

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
