Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUIOULg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUIOULg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUIOUK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:10:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48821 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267367AbUIOUJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:09:09 -0400
Date: Wed, 15 Sep 2004 16:08:56 -0400
From: Alan Cox <alan@redhat.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH: tty locking for 2.6.9rc2
Message-ID: <20040915200856.GA8000@devserv.devel.redhat.com>
References: <20040914163426.GA29253@devserv.devel.redhat.com> <1095265595.2924.27.camel@deimos.microgate.com> <20040915163051.GA9096@devserv.devel.redhat.com> <1095274482.2686.16.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095274482.2686.16.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 01:54:42PM -0500, Paul Fulghum wrote:
> There are 6 places where this needs to be done:
> 3 in tty_set_ldisc
> 2 in release_dev
> 1 in initialize_tty_struct

Argh I thought I'd fixed that after I turned it into one refcount field
from two.

> Switching back to N_TTY ldisc in release_dev() of tty_io.c
> takes a global ldisc reference (tty_ldisc_get) but
> then frees the tty structure. This causes a reference
> leak (global ldisc refcount) on N_TTY because there
> is no corresponding tty_ldisc_put.

Thanks will look

