Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbULBSfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbULBSfC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbULBSfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:35:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:51625 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261704AbULBSe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:34:59 -0500
Date: Thu, 2 Dec 2004 10:34:56 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Darrel Goeddel <dgoeddel@trustedcs.com>
Subject: Re: [PATCH 4/6] Add dynamic context transition support to SELinux
Message-ID: <20041202103456.O14339@build.pdx.osdl.net>
References: <1102002189.26015.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1102002189.26015.107.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, Dec 02, 2004 at 10:43:09AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> This patch for 2.6.10-rc2-mm4 adds dynamic context transition support to SELinux via

This is nice to see.

> +		/* Only allow single threaded processes to change context */
> +		if (atomic_read(&p->mm->mm_users) != 1) {
> +			struct task_struct *g, *t;
> +			struct mm_struct *mm = p->mm;
> +			read_lock(&tasklist_lock);
> +			do_each_thread(g, t)
> +				if (t->mm == mm && t != p) {
> +					read_unlock(&tasklist_lock);
> +					return -EPERM;
> +				}
> +			while_each_thread(g, t);
> +			read_unlock(&tasklist_lock);

That's heavy handed.  Can't you track this at clone time?  Or at least
do this after the AVC check, so it's not always locking task list.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
