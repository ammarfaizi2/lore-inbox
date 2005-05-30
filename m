Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVE3QHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVE3QHq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 12:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVE3QHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 12:07:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10189 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261481AbVE3QHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 12:07:37 -0400
Date: Mon, 30 May 2005 08:24:49 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, julien@cr0.org
Subject: Re: Linux-2.4.30-hf3
Message-ID: <20050530112449.GA5046@logos.cnet>
References: <20050529223739.GA27341@exosec.fr> <20050530050746.GK18600@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530050746.GK18600@alpha.home.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 07:07:46AM +0200, Willy Tarreau wrote:
> Hi again,
> 
> Julien corrected me on the points below :
> 
> >   - a NULL dereference in serial.c found by Julien Tinnes which could lead
> >     to an oops.
> 
> Could possibly be exploited by mapping the first page of a program and
> watching the kernel eat the data instead of oopsing.

Huh? I fail to see how that one is exploitable, given that no in-tree callers 
should pass "tty" as NULL to any of the affected functions (that is impossible, 
AFAICS).

No? Julien?

> >   - an off-by-one in mtrr.c found by Brad Spengler and reported by J.Tinnes
> >     which could lead to a panic.
> 
> This is inexact. I've checked several other archs :
>  - sparc, sparc64, x86_64, alpha, mips all assume that (n) is unsigned and
>    will overflow, possibly executing user-controlled code.
>  - ppc and ppc64 explicitly check that (n) is < TASK_SIZE and should be safe.

You refer to copy_from_user() right?  I suppose so, because there's no mtrr 
outside i386.

>  - x86 will BUG_ON((long)n < 0) (=> oops/panic).
>  - others not checked. 

Well, it requires root priveledges:

+    if (!len) return -EINVAL;
     if ( !suser () ) return -EPERM;   <---------------

So, its "safe".

> >   - a few unchecked strcpy() in ipvs fixed in PaX which I'm not absolutely
> >     sure are exploitable, but are definitely dirty and risky.
> 
> They are exploitable by anyone with enough privilege to manipulate IPVS.
> Think of a user front-end for example.

Ok. Great Willy!
