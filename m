Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUGDPOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUGDPOd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 11:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUGDPOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 11:14:32 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:13923 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265724AbUGDPOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 11:14:31 -0400
Message-ID: <2ff2162804070408142348de6b@mail.gmail.com>
Date: Sun, 4 Jul 2004 11:14:27 -0400
From: BAIN <bainonline@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: set_fs() preemption safety? [was sys_fs() safety oops !]
In-Reply-To: <200407041653.55816.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2ff21628040704073632ffa1c9@mail.gmail.com> <200407041653.55816.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > is the following block safe to be used in preemptible kernels?
> >
> > old_fs = get_fs();
> > set_fs(KERNEL_DS);
> >
> > do_your_things here; (usually call sys calls stuff from kernel space)
> >
> > set_fs(old_fs);
> 
> On most architectures, this should not be a problem, because set_fs()
> only modifies the state of the current task, not any actual processor
> registers as the name suggests.
> 
> However, on s390 the state is actually kept in cpu control register cr7
> and not in the task_struct. Martin, can you comment on how this is
> maintained over a schedule() or if this is a real bug?
Ok this is new info for me,...

I was under impression that i am banned from calling schedule between
the two calls to set_fs.

This answers my question. Thanks,

BAIN
