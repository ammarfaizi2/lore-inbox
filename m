Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbUK3HoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbUK3HoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 02:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbUK3HoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 02:44:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:59830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262001AbUK3HoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 02:44:20 -0500
Date: Mon, 29 Nov 2004 23:43:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RLIMIT_MEMLOCK accounting of shmctl() SHM_LOCK is
 broken
Message-Id: <20041129234353.378586a9.akpm@osdl.org>
In-Reply-To: <1101800060.2640.21.camel@laptop.fenrus.org>
References: <200411292204.iATM4o4C005049@hera.kernel.org>
	<1101800060.2640.21.camel@laptop.fenrus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Mon, 2004-11-29 at 21:38 +0000, Linux Kernel Mailing List wrote:
> > ChangeSet 1.2251, 2004/11/29 13:38:43-08:00, mtk-lkml@gmx.net
> >  
> > -	spin_lock(&shmlock_user_lock);
> > -	locked = size >> PAGE_SHIFT;
> > +	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> >  	lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
> >  	lock_limit >>= PAGE_SHIFT;
> > +	spin_lock(&shmlock_user_lock);
> 
> after this change... isn't the use to the
> current->signal->rlim[RLIMIT_MEMLOCK] entirely unlocked and thus racey ?

It always was - we don't modify rlimits under shmlock_user_lock.

If some other thread goes and changes RLIMIT_MEMLOCK under your feet then
this test will use either the old value or the new one, which is to be
expected.

(I get the feeling that I'm missing your point here)

