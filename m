Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUGNXzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUGNXzD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUGNXzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:55:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:31106 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265228AbUGNXy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:54:58 -0400
Date: Wed, 14 Jul 2004 15:39:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Message-Id: <20040714153943.31f3c60e.akpm@osdl.org>
In-Reply-To: <40F5C42E.1060708@pobox.com>
References: <200407141751.i6EHprhf009045@harpo.it.uu.se>
	<40F57D14.9030005@pobox.com>
	<20040714143508.3dc25d58.akpm@osdl.org>
	<40F5C42E.1060708@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > Yeah, but doing:
> > 
> > 	static inline foo(void);
> > 
> > 	bar()
> > 	{
> > 		...
> > 		foo();
> > 	}
> > 
> > 	static inline foo(void)
> > 	{
> > 		...
> > 	}
> > 
> > is pretty dumb too.  I don't see any harm if this compiler feature/problem
> > pushes us to fix the above in the obvious way.
> 
> 
> ???  C does not require ordering of function _implementations_, except 
> for this gcc brokenness.

Well.  Other compilers had that restriction iirc, and it's a pretty natural
thing to do.

> The above example allows one to do what one normally does with 
> non-inlines:  order code to enhance readability

I always expect to find those little helper functions earlier in the
compilation unit than their callsites.  Pascal-style.  Plus you don't have
the hassle of keeping the declaration and definition in sync.
