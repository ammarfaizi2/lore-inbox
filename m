Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUIOUnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUIOUnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUIOUlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:41:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267415AbUIOUkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:40:46 -0400
Date: Wed, 15 Sep 2004 16:40:28 -0400
From: Alan Cox <alan@redhat.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH: tty locking for 2.6.9rc2
Message-ID: <20040915204028.GA25740@devserv.devel.redhat.com>
References: <20040914163426.GA29253@devserv.devel.redhat.com> <1095265595.2924.27.camel@deimos.microgate.com> <20040915163051.GA9096@devserv.devel.redhat.com> <1095274482.2686.16.camel@deimos.microgate.com> <20040915200856.GA8000@devserv.devel.redhat.com> <1095279799.2958.11.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095279799.2958.11.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:23:19PM -0500, Paul Fulghum wrote:
> Here is a patch against your last patch that clears
> up both the per tty refcount initialization and
> the remove_dev() global refcount leak.

Thanks

>  	/* Now set up the new line discipline. */
>  	tty->ldisc = *ld;
> +	tty->ldisc.refcount = 0;

What do you think about

	tty_ldisc_get(tty, ldisc_num)

That seems to remove the whole mess ?

