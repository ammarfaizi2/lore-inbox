Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSHaQZ5>; Sat, 31 Aug 2002 12:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSHaQZ5>; Sat, 31 Aug 2002 12:25:57 -0400
Received: from mons.uio.no ([129.240.130.14]:32693 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317673AbSHaQZ4>;
	Sat, 31 Aug 2002 12:25:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15728.61204.381468.238609@charged.uio.no>
Date: Sat, 31 Aug 2002 18:30:12 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
In-Reply-To: <Pine.LNX.4.44.0208302110280.1524-100000@home.transmeta.com>
References: <15728.7151.27079.551845@charged.uio.no>
	<Pine.LNX.4.44.0208302110280.1524-100000@home.transmeta.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > One thing that may be interesting (I certainly think it migth
     > be), would be to add a "struct user_struct *" pointer to the
     > vfs_cred as well. This is because I'd just _love_ to have that
     > "user_struct" fed down to the VFS layer, since I think that is
     > where we may some day want to put things like user-supplied
     > cryptographic keys etc.

     > The advantage of "struct user_struct" (as opposed to just a
     > uid_t) is that it can have information that lives for the whole
     > duration of a login, and it's really the only kind of data
     > structure in the kernel that can track that kind of
     > information.

No problem at all with this. Indeed I agree it makes a lot of sense...

The only thing is if you'd allow me to do it as an incremental patch
to the initial one?
I don't see 'struct user_struct *' as replacing the existing 'uid'
entry, so there should be no need to change the existing API. Instead,
we can just add in the necessary call to alloc_uid() to
vfscred_create() and/or setfsuid()...

Cheers,
  Trond
