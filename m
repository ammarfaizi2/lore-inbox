Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbUJZHCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUJZHCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUJZHCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:02:19 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:3284 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262137AbUJZHAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:00:31 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 26 Oct 2004 08:37:36 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace bug in -rc2+
Message-ID: <20041026063735.GG3127@bytesex>
References: <20041014174952.GA29335@bytesex> <200410260504.i9Q54Es8010423@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410260504.i9Q54Es8010423@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:04:14PM -0700, Roland McGrath wrote:
> Sorry it took a while for me to get back to you on this problem.
> 
> > The introduction of the new TASK_TRACED state in 2.6.9-rc2 changed the
> > behavior of the kernel in a IMHO buggy way.  Sending a SIGKILL to a
> > process which is traced _and_ stopped doesn't work any more.  user mode
> > linux kernels do that on shutdown, thats why I ran into this.
> 
> This is a change that I explained when I posted the ptrace cleanup patches.
> In general it is not safe to do any non-ptrace wakeup of a thread in
> TASK_TRACED, because the waking thread could race with a ptrace call that
> could be doing things like mucking directly with its kernel stack.  AFAIK
> noone has established that whatever clobberation ptrace can do to a running
> thread is safe even if it will never return to user mode, so we can't allow
> this even for SIGKILL.

Yes, some days later after studing the source code for some time (and
learing alot about ptrace) I figured that myself as well ;)

> Your particular test program is the one special case where we could make
> the SIGKILL work immediately: the caller of kill is the ptracer, so we know
> noone else can be using ptrace at the same time.  But I am not in favor of
> adding this special case.  If you use ptrace yourself, you should cope.

I agree, that can easily fixed in the app, either first SIGKILL then
PTRACE_CONT, or just PTRACE_KILL directly ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
