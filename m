Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWDWVlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWDWVlT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWDWVlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 17:41:19 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:43889 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932069AbWDWVlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 17:41:19 -0400
Message-ID: <BAYC1-PASMTP03483DA1245CA85CBD8376B9B90@CEZ.ICE>
X-Originating-IP: [70.50.30.131]
X-Originating-Email: [johnmccuthan@sympatico.ca]
Subject: Re: [RFC: 2.6 patch] fs/inotify.c: possible cleanups
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Adrian Bunk <bunk@stusta.de>
Cc: ttb@tentacle.dhs.org, rml@novell.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060423114703.GL5010@stusta.de>
References: <20060423114703.GL5010@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 23 Apr 2006 17:41:20 -0400
Message-Id: <1145828480.32357.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-OriginalArrivalTime: 23 Apr 2006 21:41:18.0112 (UTC) FILETIME=[A75BAA00:01C6671E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.



On Sun, 2006-04-23 at 13:47 +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make the following needlessly global variables static:
>   - inotify_max_user_instances
>   - inotify_max_user_watches
>   - inotify_max_queued_events
> - remove the following unused EXPORT_SYMBOL_GPL's:
>   - inotify_get_cookie
>   - inotify_unmount_inodes
>   - inotify_inode_is_dead
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  fs/inotify.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.17-rc1-mm3-full/fs/inotify.c.old	2006-04-23 12:12:52.000000000 +0200
> +++ linux-2.6.17-rc1-mm3-full/fs/inotify.c	2006-04-23 12:18:46.000000000 +0200
> @@ -45,9 +45,9 @@
>  static struct vfsmount *inotify_mnt __read_mostly;
>  
>  /* these are configurable via /proc/sys/fs/inotify/ */
> -int inotify_max_user_instances __read_mostly;
> -int inotify_max_user_watches __read_mostly;
> -int inotify_max_queued_events __read_mostly;
> +static int inotify_max_user_instances __read_mostly;
> +static int inotify_max_user_watches __read_mostly;
> +static int inotify_max_queued_events __read_mostly;
>  
>  /*
>   * Lock ordering:
> @@ -627,7 +627,6 @@
>  {
>  	return atomic_inc_return(&inotify_cookie);
>  }
> -EXPORT_SYMBOL_GPL(inotify_get_cookie);
>  
>  /**
>   * inotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
> @@ -706,7 +705,6 @@
>  		spin_lock(&inode_lock);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(inotify_unmount_inodes);
>  
>  /**
>   * inotify_inode_is_dead - an inode has been deleted, cleanup any watches
> @@ -725,7 +723,6 @@
>  	}
>  	mutex_unlock(&inode->inotify_mutex);
>  }
> -EXPORT_SYMBOL_GPL(inotify_inode_is_dead);
>  
>  /* Device Interface */
>  
> 
> 
-- 
John McCutchan <john@johnmccutchan.com>
