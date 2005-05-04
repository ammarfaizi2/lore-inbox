Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVEDTlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVEDTlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVEDTlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:41:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:59871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261548AbVEDTkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:40:37 -0400
Date: Wed, 4 May 2005 12:41:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: andre@cachola.com.br, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: A patch for the file kernel/fork.c
Message-Id: <20050504124104.3573e7f3.akpm@osdl.org>
In-Reply-To: <1115234213.2562.28.camel@localhost.localdomain>
References: <4278E03A.1000605@cachola.com.br>
	<20050504175457.GA31789@taniwha.stupidest.org>
	<427913E4.3070908@cachola.com.br>
	<20050504184318.GA644@taniwha.stupidest.org>
	<42791CD2.5070408@cachola.com.br>
	<1115234213.2562.28.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@dsv.su.se> wrote:
>
> > [4300748.423000] Call Trace:
> > [4300748.423000]  [<c0104bfa>] show_stack+0x7a/0x90
> > [4300748.423000]  [<c0104d7d>] show_registers+0x14d/0x1b0
> > [4300748.423000]  [<c0104fcc>] die+0x14c/0x2c0
> > [4300748.423000]  [<c0118b6f>] do_page_fault+0x31f/0x638
> > [4300748.423000]  [<c01046df>] error_code+0x4f/0x54
> > [4300748.423000]  [<c02b88fd>] tty_wakeup+0x5d/0x60
> > 
> > I think that maybe it's good to put a:
> >        WARN_ON(!mm);
> > but a BUG_ON or without this patch, the kernel will halt, even if the 
> > problem is not so severe.
> 
> Patching up the kernel hiding things that must not happen is not the way
> to go. All kernel bugs are severe (as you just showed us!). Adding extra
> checks like your original patch did may even cause much more harm
> because it may hide other problems causing silent problems.

If I understand Andre correctly, his patch will prevent infinite recursion
in the oops path - if some process oopses after having run exit_mm().

If so then it's a reasonable debugging aid.  Although there might be better
places to do it, such as

	if (!current->i_tried_to_exit++)
		return;

in do_exit().   Dunno.
