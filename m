Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270325AbTGRTaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270334AbTGRTaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:30:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:39109 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270325AbTGRTaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:30:01 -0400
Date: Fri, 18 Jul 2003 12:37:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: petero2@telia.com, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
Message-Id: <20030718123728.1ff12b51.akpm@osdl.org>
In-Reply-To: <20030718175045.GA195@elf.ucw.cz>
References: <m2wueh2axz.fsf@telia.com>
	<20030717200039.GA227@elf.ucw.cz>
	<20030717130906.0717b30d.akpm@osdl.org>
	<m2d6g8cg06.fsf@telia.com>
	<20030718032433.4b6b9281.akpm@osdl.org>
	<20030718152205.GA407@elf.ucw.cz>
	<m2el0nvnhm.fsf@telia.com>
	<20030718094542.07b2685a.akpm@osdl.org>
	<20030718175045.GA195@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> > It would be much better to freeze kernel threads _after_ doing the big
> > memory shrink.
> 
> I wanted to avoid that: we do want user threads refrigerated at that
> point so that we know noone is allocating memory as we are trying to
> do memory shrink.

	freeze(threads which have task->mm)
	shrink_memory();
	freeze(threads which have !task->mm)

That's pretty simple.

> I'd like to avoid having refrigerator run in two phases....

The whole thing can deadlock without kernel thread services.

