Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWFSPQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWFSPQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWFSPQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:16:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35789 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932178AbWFSPQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:16:12 -0400
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [autofs] [RFC:VFS] autofs4 needs to force fail return
 revalidate
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <Pine.LNX.4.64.0606191332510.5732@raven.themaw.net>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Mon, 19 Jun 2006 11:15:39 -0400
In-Reply-To: <Pine.LNX.4.64.0606191332510.5732@raven.themaw.net> (Ian Kent's
 message of "Mon, 19 Jun 2006 13:51:14 +0800 (WST)")
Message-ID: <x491wtljhwk.fsf@segfault.boston.redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding [autofs] [RFC:VFS] autofs4 needs to force fail return revalidate; Ian Kent <raven@themaw.net> adds:

raven> Hi all,

raven> For a long time now I have had a problem with not being able to
raven> return a lookup failure on an existsing directory. In autofs this
raven> corresponds to a mount failure on a autofs managed mount entry that
raven> is browsable (and so the mount point directory exists).

raven> While this problem has been present for a long time I've avoided
raven> resolving it because it was not very visible. But now that autofs v5
raven> has "mount and expire on demand" of nested multiple mounts, such as
raven> is found when mounting an export list from a server, solving the
raven> problem cannot be avoided any longer.

raven> I've tried very hard to find a way to do this entirely within the
raven> autofs4 module but have not been able to find a satisfactory way to
raven> achieve it.

raven> So, I need to propose a change to the VFS.

raven> Please offer comments and suggestions or if anyone has an idea how
raven> this could be done within the autofs4 filesystem then I'm all ears.

> --- linux-2.6.17/include/linux/dcache.h.dcache-revalidate-return-fail	2006-06-19 13:26:27.000000000 +0800
> +++ linux-2.6.17/include/linux/dcache.h	2006-06-19 13:29:25.000000000 +0800
> @@ -163,6 +163,7 @@ d_iput:		no		no		no       yes
>  #define DCACHE_UNHASHED		0x0010	

>  #define DCACHE_INOTIFY_PARENT_WATCHED	0x0020 /* Parent inode is watched */
> +#define DCACHE_REVAL_FORCE_FAIL 0x0040	/* Force revalidate fail on valid dentry */

>  extern spinlock_t dcache_lock;

This looks like the right approach to me.  I'd ack it.

-Jeff
