Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272989AbTHFAO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272992AbTHFAO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:14:29 -0400
Received: from [163.118.102.59] ([163.118.102.59]:37797 "EHLO
	mail.drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S272989AbTHFAO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:14:26 -0400
Date: Tue, 5 Aug 2003 20:10:56 -0400
From: s0be <s0be@DrunkenCodePoets.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops in 2.6.0-test2-mm4
Message-Id: <20030805201056.2b8c9f22.s0be@DrunkenCodePoets.com>
In-Reply-To: <20030806000524.GC26701@waste.org>
References: <20030805170558.3ee38204.s0be@DrunkenCodePoets.com>
	<20030806000524.GC26701@waste.org>
Organization: DrunkenCodePoets.com
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 19:05:24 -0500
Matt Mackall <mpm@selenic.com> wrote:

> On Tue, Aug 05, 2003 at 05:05:58PM -0400, s0be wrote:
> > here's the oops from dmesg and the surrounding messages.  I'm guessing it was caused by smb, but I can't confirm it.  trying to recreate it.
..snip..
> > Debug: sleeping function called from invalid context at include/asm/uaccess.h:512Call Trace:
> >  [<c011fd3c>] __might_sleep+0x5c/0x5e
> >  [<c010da1a>] save_v86_state+0x6a/0x200
> >  [<c010e565>] handle_vm86_fault+0xa5/0x8c0
> >  [<c0170a23>] dput+0x23/0x200
> >  [<c010c030>] do_general_protection+0x0/0xa0
> >  [<c032519f>] error_code+0x2f/0x38
> >  [<c0324733>] syscall_call+0x7/0xb
..snip..
> 
> Actually, Samba seems unconnected.
> 
> This is not an oops, just a debug trace that says something tried to
> do something unsafe (namely calling copy_from_user while in_atomic()
> was true). 
> 
> Looks like we've got:
> 
>  do_general_protection
>   handle_vm86_fault
>    return_to_32bit
>     save_v86_state
>      copy_to_user   
> 
> and the destination of the copy is current->thread.vm86_info->regs,
> which is labelled __user. Presuming this is actually in userspace,
> this could be a problem.
> 
> -- 
> Matt Mackall : http://www.selenic.com : of or relating to the moon
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I'd have to agree.  I wrote a script that sits here mounting a samba mount, then, either writing to it, and unmount, write to it and no,unmount, just unmount it, or nothing, pseudo randomly, and it pissed off my windows machine it was connecting to, but could NOT reproduce this problem.  I can't seem to get it to happen again though.  I'm sort of at a loss.  I can provide any extra info that might help.

pat

-- 
