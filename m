Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUIIUxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUIIUxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUIIUum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:50:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:30924 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266137AbUIIUtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:49:31 -0400
Date: Thu, 9 Sep 2004 13:48:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Roger Luethi <rl@hellgate.ch>, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909134854.B1924@build.pdx.osdl.net>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, Sep 09, 2004 at 04:01:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> Well, it isn't that easy, or at least I don't think it is.  The problem
> is that there is no way presently to convey the sender's security
> credentials (beyond the existing uid, cap information), since the LSM
> patches for adding security fields and hooks for managing skb security
> fields were rejected.  The best we can do at present is pass along the
> sender pid, uid, and cap, and the security module can look up the pid if
> it chooses to get the security field (but is naturally subject to races
> in that situation).
> 
> Most obvious place to hook would be nproc_ps_get_task; we could then
> perform a check based on the sender's credentials and the target task's
> credentials, and simply return NULL if permission is not granted for
> that pair, thus skipping that task as if it didn't exist.  That requires
> propagating the sender's credentials down to that function.
> 
> Untested patch below.
> 
> Index: linux-2.6/include/linux/security.h
> ===================================================================
> RCS file: /nfshome/pal/CVS/linux-2.6/include/linux/security.h,v
> retrieving revision 1.37
> diff -u -p -r1.37 security.h
> --- linux-2.6/include/linux/security.h	16 Jun 2004 14:49:42 -0000	1.37
> +++ linux-2.6/include/linux/security.h	9 Sep 2004 19:38:23 -0000
> @@ -632,6 +632,13 @@ struct swap_info_struct;
>   * 	security attributes, e.g. for /proc/pid inodes.
>   *	@p contains the task_struct for the task.
>   *	@inode contains the inode structure for the inode.
> + * @task_getstate:
> + * 	Check permission before getting the state of a task.
> + *      @pid contains the pid of the requesting process.
> + *	@p contains the task_struct for the target task.
> + *      @uid contains the uid of the requesting process.
> + *      @caps contains the capability set of the requesting process.
> + *      Return 0 if permission is granted.

Why caps?


thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
