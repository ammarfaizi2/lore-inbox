Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSHaAiG>; Fri, 30 Aug 2002 20:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSHaAiF>; Fri, 30 Aug 2002 20:38:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8200 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315388AbSHaAiE>; Fri, 30 Aug 2002 20:38:04 -0400
Date: Fri, 30 Aug 2002 17:49:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
In-Reply-To: <15728.3233.550886.99549@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0208301741430.5561-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 31 Aug 2002, Trond Myklebust wrote:
> 
> task->ucred is not the unit for implementing shared creds between
> threads.

Fair enough, but some solution to this has to be found. I do not want to 
apply something that simply cannot work sanely, and I want to have at 
least a _plan_ on the table.

> struct pcred {
>        atomic_t	count;
>        uid_t	uid, euid, suid;
>        gid_t	gid, egid, sgid;
>        struct ucred  *cred;
>        kernel_cap_t ... capabilities ...
>        struct user_struct *user;
> };

Ok, that sounds reasonable, except the naming just has to go. Yes, things
like "pcred/ucred" may be what BSD uses, but BSD uses things like "uarea"  
too, which just isn't the Linux way. The names should make sense _without_
having to have single-letter differences.

This really ties in with the patches Dave has done (which are equivalent
to your "pcred"), and I'd like to see them work together in practice.

(I would suggest calling the FS credentials "struct vfs_cred", while the
regular user credentials might just be "struct cred".  Other suggestions?)

		Linus

