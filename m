Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVDJSH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVDJSH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVDJSH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:07:56 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:7112 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261544AbVDJSHo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:07:44 -0400
Date: Sun, 10 Apr 2005 20:07:39 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Bodo Eggert <7eggert@gmx.de>, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com
Subject: Re: [RFC][PATCH] Simple privacy enhancement for /proc/<pid>
In-Reply-To: <20050410153855.GA24905@lsrfire.ath.cx>
Message-ID: <Pine.LNX.4.58.0504101910270.4413@be1.lrz>
References: <20050410153855.GA24905@lsrfire.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Apr 2005, Rene Scharfe wrote:

> First, configuring via kernel parameters is sufficient.

I don't remember: Would a mount option be equally easy to implement?
(Kernel parameters are OK for me, too.)

> I have another idea: let's keep the details of _every_ process owned by
> user root readable by anyone.

What about SUID processes acting on behalf of users?

> -	processor.max_cstate=   [HW, ACPI]
> -			Limit processor to maximum C-state
> -			max_cstate=9 overrides any DMI blacklist limit.
> -

This seems to belong into another patch



(in pid_revalidate:)
What about moving the things around? (just editing in the MUA)

> +		if (IS_PID_DIR(proc_type(inode)) || task_dumpable(task)) {
>  			inode->i_uid = task->euid;
> +			inode->i_gid = proc_gid;
> +			if (!proc_privacy || IS_PID_DIR(proc_type(inode)))
>  				inode->i_gid = task->egid;
>  		} else {
>  			inode->i_uid = 0;
>  			inode->i_gid = 0;
>  		}
>  		security_task_to_inode(task, inode);
>  		return 1;
>  	}

BTW: You might be able to cache IS_PID_DIR(). It looks like being a gain.

> @@ -1454,6 +1468,11 @@ static struct dentry *proc_pident_lookup

> +		if (proc_privacy == 2 || task->euid != 0)
                                                   ^^^^^
redundand.
-- 
Funny quotes:
27. If people from Poland are called Poles, why aren't people from Holland
    called Holes?
Friﬂ, Spammer: Gould@wedocraffix.com winer@brennsoftware.org
