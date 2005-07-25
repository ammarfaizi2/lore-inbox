Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVGYFaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVGYFaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVGYFaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:30:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:34062 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261706AbVGYFaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:30:19 -0400
Date: Mon, 25 Jul 2005 07:18:48 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Florin Malita <fmalita@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 speed
Message-ID: <20050725051848.GT8907@alpha.home.local>
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com> <1122248869.10835.25.camel@localhost.localdomain> <f8994115050724211071a3dbe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8994115050724211071a3dbe1@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 12:10:15AM -0400, Florin Malita wrote:
> On 7/24/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > time() isn't a hot
> > path in the real world.
> 
> That's what you would expect but I've straced stuff calling
> gettimeofday() in huge bursts every other second. Obviously braindead
> stuff but so is "the real world" most of the time() ... :)

gettimeofday() is known to be called very often (after any select() or
poll() returns), and is optimized for such conditions. There was even
an implementation, which I don't know if it finally became mainstream,
which optimized this particular system call. Some networking applications
might call it tens of thousands of times per second.

But as Alan said, time() (not to be confused with gettimeofday()) is
not a hot path.

Willy

