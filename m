Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUIOQdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUIOQdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUIOQb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:31:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5800 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266796AbUIOQbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:31:07 -0400
Date: Wed, 15 Sep 2004 12:30:51 -0400
From: Alan Cox <alan@redhat.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH: tty locking for 2.6.9rc2
Message-ID: <20040915163051.GA9096@devserv.devel.redhat.com>
References: <20040914163426.GA29253@devserv.devel.redhat.com> <1095265595.2924.27.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095265595.2924.27.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 11:26:35AM -0500, Paul Fulghum wrote:
> I tried this patch and can't change line disciplines.
> The user program waits forever on ioctl(TIOCSETD).
> I am going to add printk statements to

Is the tty currently in use - that implies maybe an ldisc leak

> Each line discipline has a refcount.
> This single refcount is modified by all
> entities using that line discipline.

Nope. tty->ldisc is a -copy- of the ldisc structure rather than a 
pointer. It has always been that way

struct tty_struct {
        int     magic;
        struct tty_driver *driver;
        int index;
	struct tty_ldisc ldisc;

...


