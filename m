Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267537AbUIJP7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267537AbUIJP7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUIJP4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:56:37 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:22537 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267490AbUIJPzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:55:21 -0400
Date: Fri, 10 Sep 2004 16:55:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: tty ldisc locking/ordering
Message-ID: <20040910165520.A25852@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <20040910153810.GA7431@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040910153810.GA7431@devserv.devel.redhat.com>; from alan@redhat.com on Fri, Sep 10, 2004 at 11:38:10AM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 11:38:10AM -0400, Alan Cox wrote:
> +In order to remove a line discipline call tty_register_ldisc passing NULL.
> +In ancient times this always worked. In modern times the function will
> +return -EBUSY if the ldisc is currently in use. Since the ldisc referencing
> +code manages the module counts this should not usually be a concern.

So what is a module supposed to do if this fails?  It's usually called from
module_exit so there's no way to recover.

> +Three calls are now provided
> +
> +	ldisc = tty_ldisc_ref(tty);
> +
> +takes a handle to the line discipline in the tty and returns it. If no ldisc
> +is currently attached or the ldisc is being closed and re-opened at this
> +point then NULL is returned. While this handle is held the ldisc will not
> +change or go away.
> +
> +	tty_ldisc_deref(ldisc)

We tend to call these _get/_put just about everywhere else in the kernel,
maybe some consisteny is a good idea?

