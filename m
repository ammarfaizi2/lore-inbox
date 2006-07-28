Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161141AbWG1Mgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbWG1Mgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWG1Mgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:36:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:39257 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161141AbWG1Mga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:36:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=kMVGgOD+nenVYpmOLQSUHWyeesBsh7YNnPdkG0Ma6j4FMVV0j0E4bjSqoq9R1QonmUYNiO1wNnelE/fM7RVHXRlqkQQSrrCod0+5uQGHQwDXd2ZUAdVOgcxzlXbkWwY5qcqQ123/aCi19j9e4QtrdNwjwpOwN9UZ4r64niGofEg=
Date: Fri, 28 Jul 2006 14:36:25 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, jet@gyve.org
Subject: Re: [mm-patch] bluetooth: use GFP_ATOMIC in *_sock_create's sk_alloc
Message-ID: <20060728123625.GC311@slug>
References: <20060727015639.9c89db57.akpm@osdl.org> <20060728083532.GA311@slug> <1154077209.2298.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154077209.2298.9.camel@localhost>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 11:00:09AM +0200, Marcel Holtmann wrote:
> Hi Frederik,
> 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
> > > 
> > 
> > I think that the bluetooth-guard-bt_proto-with-rwlock.patch introduced the following
> > BUG:
> > [   43.232000] BUG: sleeping function called from invalid context at mm/slab.c:2903
> > [   43.232000] in_atomic():1, irqs_disabled():0
> > [   43.232000]  [<c0104114>] show_trace_log_lvl+0x197/0x1ba
> > [   43.232000]  [<c010415e>] show_trace+0x27/0x29
> > [   43.232000]  [<c010426e>] dump_stack+0x26/0x28
> > [   43.232000]  [<c011ad1c>] __might_sleep+0xa2/0xaa
> > [   43.232000]  [<c0173085>] __kmalloc+0x9c/0xb3
> > [   43.232000]  [<c02f9295>] sk_alloc+0x1bc/0x1de
> > [   43.232000]  [<c036d689>] hci_sock_create+0x42/0x8a
> > [   43.236000]  [<c0366f40>] bt_sock_create+0xb5/0x154
> > [   43.236000]  [<c02f69dc>] __sock_create+0x131/0x356
> > [   43.236000]  [<c02f6c2f>] sock_create+0x2e/0x30
> > [   43.236000]  [<c02f6c88>] sys_socket+0x27/0x53
> > [   43.240000]  [<c02f7db5>] sys_socketcall+0xa9/0x277
> > [   43.240000]  [<c0103131>] sysenter_past_esp+0x56/0x8d
> > [   43.240000]  [<b7f38410>] 0xb7f38410
> 
> the comment from Max Krasnyansky (the original author) I got was this:
> 
>   As far as I remember there was some upper level locking that ensured
>   that protected registration stuff. But it's been awhile so I may be
>   completely wrong.
> 
> And Masatake YAMATO mentioned:
> 
>   It seems that lock_kernel/unlock_kernel was used in sys_init_module.
>   However, now it is gone.
> 
> I haven't looked at the new module loading code to verify if we really
> need to protect our socket registration or not.
> 
I'm really not an expert here, but from what I read, the only obvious
locking done in sys_init_module is involves 'module_mutex'. And that
mutex is released at the time 'mod->init()' is called.

Regards,
Frederik
