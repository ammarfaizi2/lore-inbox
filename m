Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUGOWGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUGOWGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUGOWGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:06:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:18142 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266352AbUGOWGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:06:20 -0400
Date: Fri, 16 Jul 2004 00:06:18 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jparadis@redhat.com, cagney@redhat.com, discuss@x86-64.org
Subject: Re: [PATCH] x86-64 singlestep through sigreturn system call
Message-Id: <20040716000618.0441d268.ak@suse.de>
In-Reply-To: <200407152113.i6FLDFfB013246@magilla.sf.frob.com>
References: <20040715074618.4c33bd31.ak@suse.de>
	<200407152113.i6FLDFfB013246@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2004 14:13:15 -0700
Roland McGrath <roland@redhat.com> wrote:

> > Anyways, I don't have any plans to change the 64bit behaviour. gdb will
> > have to live with a few minor inconsistencies as price for faster system
> > calls. 
> 
> My patch doesn't slow anything down beyond one comparison and branch not
> taken in the rt_sigreturn system call.  Does that negligible meaning of
> "faster" really warrant the inconsistent user behavior?

I meant as a general side effect of using SYSRET and not always IRET.
In the later case it would be consistently like i386.

Anyways, even if I applied your patch there would be still inconsistency
because there are several other system calls that use IRET. So I don't
see much advantage in adding a special case just for sigreturn.

-Andi
