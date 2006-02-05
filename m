Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWBEDSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWBEDSV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 22:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWBEDSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 22:18:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29853 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932394AbWBEDSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 22:18:20 -0500
Date: Sat, 4 Feb 2006 19:18:03 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 4/5] cpuset memory spread slab cache optimizations
Message-Id: <20060204191803.10a3a4bb.pj@sgi.com>
In-Reply-To: <20060204155019.47f313d7.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071927.10021.75308.sendpatchset@jackhammer.engr.sgi.com>
	<20060204155019.47f313d7.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> perhaps a weaselly comment would cover that worry.

Well ... the comment was there, but the problem with comments
is no one reads them ;)

+ * The task struct 'p' should either be current or a newly
+ * forked child that is not visible on the task list yet.
+ */
+
+void mpol_set_task_struct_flag(struct task_struct *p)


> this function's interface really does invite that
> race and hence is not very good

Agreed.  I'm still scratching my head coming up with a better way.

Hmmm ... except for the call from fork, all calls to this are from
within mm/mempolicy.c.  I could make the routine within mempolicy.c
static, and provide an exported wrapper with a name like:

	mpol_fix_fork_child_flag()

that wrapped it.  With a name like that, there seems less risk of
abusing this.

Any other suggestions?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
