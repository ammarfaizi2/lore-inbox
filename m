Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUBPRNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265710AbUBPRNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:13:50 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:17602 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265682AbUBPRMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:12:08 -0500
Subject: Re: kthread, signals and PF_FREEZE (suspend)
From: Christophe Saout <christophe@saout.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
       pavel@suse.cz
In-Reply-To: <20040216165329.GB17323@mail.shareable.org>
References: <1076890731.5525.31.camel@leto.cs.pocnet.net>
	 <20040216034251.0912E2C0F8@lists.samba.org>
	 <20040216165329.GB17323@mail.shareable.org>
Content-Type: text/plain
Message-Id: <1076951524.5881.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 18:12:05 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Jamie Lokier um 17:53:

> Rusty Russell wrote:
> > > That means that signal_pending() will return true for that process which
> > > will make kthread stop the thread.
> > 
> > Yes, the way they are currently coded.  I had assumed that spurious
> > signals do not occur.
> 
> Yowch.  Does suspend mean this warning in futex_wait is wrong?
> 
> 	/* A spurious wakeup should never happen. */
> 	WARN_ON(!signal_pending(current));
> 	return -EINTR;

I just tried it on my notebook. It works, no warning.

I don't know how things work exactly. There is some stuff in the arch
signal.c in do_signal that also handles PF_FREEZE.


