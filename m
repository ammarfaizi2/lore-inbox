Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUA1BDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 20:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUA1BDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 20:03:15 -0500
Received: from [66.35.79.110] ([66.35.79.110]:7825 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S265780AbUA1BCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 20:02:32 -0500
Date: Tue, 27 Jan 2004 17:02:22 -0800
From: Tim Hockin <thockin@hockin.org>
To: Andrew Morton <akpm@osdl.org>
Cc: thockin@sun.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: NGROUPS 2.6.2rc2
Message-ID: <20040128010222.GA32323@hockin.org>
References: <20040127225311.GA9155@sun.com> <20040127164615.38fd992e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127164615.38fd992e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 04:46:15PM -0800, Andrew Morton wrote:
> > Attached is a patch to remove the NGROUPS limit (again).
> +/* export the group_info to a user-space array */
> +static int groups_to_user(gid_t *grouplist, struct group_info __user *info)

> This had me thorougly confused for a while ;) The __user tag here should
> apply to grouplist, not to info.

indeed.

> +static int groups16_to_user(old_gid_t __user *grouplist,
> +    struct group_info *info)
> +{
> +	int i;
> +	old_gid_t group;
> +
> +	if (info->ngroups > TASK_SIZE/sizeof(group))
> +		return -EFAULT;
> +	if (!access_ok(VERIFY_WRITE, grouplist, info->ngroups * sizeof(group)))
> +		return -EFAULT;
> 
> Why are many functions playing with TASK_SIZE?

Not sure - I thought it was maybe a paranoid check, Rusty included it in his
version of a similar patch a while ago.

> +extern asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist);
> 
> rant.  We have soooo many syscalls declared in .c files.  We had a bug due
> to this a while back.  Problem is, we have no anointed header in which to
> place them.  include/linux/syscalls.h would suit.  And unistd.h for
> arch-specific syscalls.  But that's not appropriate to this patch.

Agreed.
