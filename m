Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVFIJgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVFIJgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 05:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVFIJgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 05:36:36 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:55233 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261307AbVFIJga convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 05:36:30 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Thu, 9 Jun 2005 11:36:42 +0200
From: Frederik Deweerdt <dev.deweerdt@laposte.net>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TTY] exclusive mode question
Message-ID: <20050609093642.GA507@gilgamesh.home.res>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	linux-kernel@vger.kernel.org
References: <20050609084908.82923.qmail@web25805.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050609084908.82923.qmail@web25805.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/06/05 10:49 +0200, moreau francis écrivit:
> Hi
> 
> When a process open a tty in exclusive mode (using ioctl(X, TIOCEXCL)), can the
> process be sure to be the only one using this tty ?
> If so I can't find in kernel code any checks in "tty_open" method for verifying
> that the tty has not been opened previously by another process when
> "TTY_EXCLUSIVE" flag is set.
> 
I've just greped and I found :

if (!retval && test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
	retval = -EBUSY;
in drivers/char/tty_io.c:tty_open

Which sources are you looking at?

Regards,
Frederik Deweerdt

