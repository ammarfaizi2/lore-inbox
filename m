Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSHaEHJ>; Sat, 31 Aug 2002 00:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSHaEHI>; Sat, 31 Aug 2002 00:07:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6154 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315870AbSHaEHH>; Sat, 31 Aug 2002 00:07:07 -0400
Date: Fri, 30 Aug 2002 21:18:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
In-Reply-To: <15728.7151.27079.551845@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0208302110280.1524-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 31 Aug 2002, Trond Myklebust wrote:
> 
>   Add the COW structure 'vfs_cred'
> 
>   Make VFS changes to replace all instances of
>   current->fsuid/fsgid/ngroups/groups with a single 'vfs_cred' that
>   never can be changed by CLONE_CRED after we call down into the VFS.

Yup, I think I like that plan.

One thing that may be interesting (I certainly think it migth be), would
be to add a "struct user_struct *" pointer to the vfs_cred as well. This
is because I'd just _love_ to have that "user_struct" fed down to the VFS
layer, since I think that is where we may some day want to put things like
user-supplied cryptographic keys etc.

The advantage of "struct user_struct" (as opposed to just a uid_t) is that 
it can have information that lives for the whole duration of a login, and 
it's really the only kind of data structure in the kernel that can track 
that kind of information. 

>      > (I would suggest calling the FS credentials "struct vfs_cred",
>      > while the regular user credentials might just be "struct cred".
>      > Other suggestions?)
> 
> I'm fine about 'vfs_cred', but how about 'struct task_cred' instead
> for the second?

Sounds fine to me.

		Linus

