Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSGFUdz>; Sat, 6 Jul 2002 16:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSGFUdy>; Sat, 6 Jul 2002 16:33:54 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:63493 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S310190AbSGFUdx>;
	Sat, 6 Jul 2002 16:33:53 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207062036.g66KaMx160715@saturn.cs.uml.edu>
Subject: Re: Is 'transname' still alive ?
To: jamagallon@able.es (J.A. Magallon)
Date: Sat, 6 Jul 2002 16:36:22 -0400 (EDT)
Cc: bproc-users@lists.sourceforge.net (Lista Linux-BProc),
       linux-cluster@nl.linux.org (Lista Linux-Cluster),
       linux-kernel@vger.kernel.org (Lista Linux-Kernel)
In-Reply-To: <20020706184855.GA8343@werewolf.able.es> from "J.A. Magallon" at Jul 06, 2002 08:48:55 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon writes:

> I was looking info about ClusterNFS, and I found some info on 'transname',
> ie, do the same as cNFS but on the kernel server.
> 
> Is that project still alive ? Is there any patch for 2.4 ?

The transname+omirr patch went in with kernel 2.1.43, but
only a few identifiable scraps remain in recent kernels.

That patch was of major importance to the history of Linux.
It is the reason why Linux has the dcache stuff, which lets
us have multiple mount points, per-process namespaces, pathnames
in /proc symlinks, and an efficient getcwd() system call.
It made the 2.1.44 kernel horribly bad. It used to provide
the POSIX-prohibited ability to do rmdir(".") safely.

You can see bits of the patch in the 2.4 kernel source:

--- fs/namei.c ---
/* [Feb-1997 T. Schoebel-Theuer]
 * Fundamental changes in the pathname lookup mechanisms (namei)
 * were necessary because of omirr.  The reason is that omirr needs
 * to know the _real_ pathname, not the user-supplied one, in case
 * of symlinks (and also when transname replacements occur).
------------------

--- include/linux/dcache.h ---
/* appendix may either be NULL or be used for transname suffixes */
extern struct dentry * d_lookup(struct dentry *, struct qstr *);
------------------------------

--- Documentation/Configure.help ---
LocalWords:  prio Micom xIO dwmw rimi OMIRR omirr omirrd unicode ntfs cmu NIC
------------------------------------

The actual transname stuff never made it into the kernel.
We just have some of the support code. Prior to the patch,
our filesystem code was like what BSD uses. Now we have
something which is more like UnixWare, but likely better.
I think Bill Hawes was responsible for this code after it
got in.

You might be able to make up for the missing functionality
with file-on-file mounts:

touch /tmp/mtab
mount --bind /tmp/mtab /etc/mtab
