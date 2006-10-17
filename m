Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWJQNDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWJQNDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWJQNDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:03:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35783 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750867AbWJQNDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:03:05 -0400
Subject: Re: [RFC][PATCH] ->signal->tty locking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <20061017123307.GA209@oleg>
References: <1160992420.22727.14.camel@taijtu> <20061017081018.GA115@oleg>
	 <1161080221.3036.38.camel@taijtu>  <20061017123307.GA209@oleg>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Oct 2006 14:29:40 +0100
Message-Id: <1161091781.24237.161.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-17 am 16:33 +0400, ysgrifennodd Oleg Nesterov:
> I sent a patch,
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=114268787415193
> 
> but it was ignored. Probably I should re-send it.

Definitely - we still see reports of tty slab scribbles

> > Right, use tty_mutex when using the tty, use ->sighand when changing
> > signal->tty.
> 
> I think that things like do_task_stat()/do_acct_process() do not need
> global tty_mutex, they can use ->siglock.

Please keep the tty_mutex as it will protect against other stuff later.
Once tty is a bit saner then someone brave can refcount it properly and
that'll make it much prettier.

