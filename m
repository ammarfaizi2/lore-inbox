Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTHUClE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 22:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbTHUClE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 22:41:04 -0400
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:51909 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S262361AbTHUCk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 22:40:59 -0400
Date: Wed, 20 Aug 2003 21:40:41 -0500 (CDT)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sleeping function called from invalid context include/linux/rwsem.h:43
In-Reply-To: <20030820180347.GC23889@waste.org>
Message-ID: <Pine.LNX.4.21.0308202130460.2720-100000@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.8, required 9,
	IN_REP_TO, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The trace is just a debug trace not an oops. It just happens that the
system crashes and reboots(sometimes) if the trace shows up I didn't build
it with preempt. Here's a link to the oops that follows the trace:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=106132947001233&w=2

Sorry about this late reply. I couldn't access my email for a while.

thanks

On Wed, 20 Aug 2003, Matt Mackall wrote:

> On Wed, Aug 20, 2003 at 01:38:09AM -0500, Hmamouche, Youssef wrote:
> > 
> > Hi,
> > 
> > I get this debug message right before the oops(Oops linux-2.6.0-test3
> > sound) that I sent earlier to the list. When this Debug message happens
> > before the oops, the system freezes. All of this is related to the
> > Maestro3.c sound card. I've ran 2.4{16, 20, 21, 22-pre8} without a
> > problem. I searched through the list archive for a similar problem, in
> > vain. Can someone please tell what's causing this?  
> 
> Could you post the oops together with the might_sleep trace? This is
> something calling down_read in a context where its not safe to sleep.
> The rest of the backtrace doesn't make much sense..
> 
> Did you build with preempt enabled?
> 
> > 
> > Thanks 
> > 
> >  Debug: sleeping function called from invalid context at
> > include/linux/rwsem.h:43
> > Aug 19 23:59:34 darkstar kernel: Debug: sleeping function called from
> > invalid context at include/linux/rwsem.h:43
> > 
> > Call Trace:
> >  [<c012722e>] __might_sleep+0x5e/0x70
> >  [<c0127b20>] autoremove_wake_function+0x0/0x50
> >  [<c0122869>] do_page_fault+0x79/0x4dc
> >  [<c01c71ad>] ext2_get_inode+0xdd/0x140
> >  [<c022973c>] avc_has_perm+0x6c/0x7b
> >  [<c01227f0>] do_page_fault+0x0/0x4dc
> >  [<c010b1b9>] error_code+0x2d/0x38
> >  [<c03dabe1>] m3_open+0x131/0x390
> >  [<c0159b94>] check_poison_obj+0x54/0x1d0
> >  [<c03d4d25>] soundcore_open+0x1e5/0x4e0
> >  [<c0186c90>] exact_match+0x0/0x10
> >  [<c0186696>] chrdev_open+0x156/0x3e0
> >  [<c017a388>] get_empty_filp+0x98/0x100
> >  [<c017823c>] dentry_open+0x12c/0x1c0
> >  [<c0178106>] filp_open+0x66/0x70
> >  [<c0178855>] sys_open+0x55/0x90
> >  [<c010b00f>] syscall_call+0x7/0xb
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> Matt Mackall : http://www.selenic.com : of or relating to the moon
> 

