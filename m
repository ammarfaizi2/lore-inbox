Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVBTVLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVBTVLG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 16:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVBTVLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 16:11:06 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:47358 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261154AbVBTVLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 16:11:02 -0500
Message-ID: <4218FCE7.1040403@tiscali.de>
Date: Sun, 20 Feb 2005 22:11:03 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Der Herr Hofrat <der.herr@hofr.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: proc path_walk glitch ?
References: <200502202009.j1KK9um25139@hofr.at>
In-Reply-To: <200502202009.j1KK9um25139@hofr.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Der Herr Hofrat wrote:

>HI !
>
> I noticed a slight proc filesystem strangness in the 2.4.2X and 2.6.X 
> (atleast up to 2.6.8).  Assuming that process 8655 exists and is running 
> long enough (ls -lR / or so)
>
>cd /proc/8655
>kill -9 8655
>ls
>/usr/bin/ls: .: Stale NFS file handle
>
>open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ESTALE (Stale NFS file handle)  from  fs/namei.c -> link_path_walk :
>
>int fastcall link_path_walk(const char * name, struct nameidata *nd)
>{
>	struct dentry *dentry;
>	struct inode *inode;
>	int err;
>	unsigned int lookup_flags = nd->flags;
>
>	while (*name=='/')
>		name++;
>	if (!*name)
>		goto return_reval;
>	...
>
>return_reval:
>		/*
>		 * We bypassed the ordinary revalidation routines.
>		 * Check the cached dentry for staleness.
>		 */
>		dentry = nd->dentry;
>		if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
>			err = -ESTALE;
>			if (!dentry->d_op->d_revalidate(dentry, 0)) {
>				d_invalidate(dentry);
>				break;
>			}
>		}
>
>
> Why does return_reval return -ESTALE instead of -ENOENT here - might need an
>extra check on what filesystem this is working on ?
>
>/usr/bin/ls: .: no such file or directory
>
> would seem more meaningfull to me when I find it in a logfile.
>
>thx !
>hofrat
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Does it happen in 2.6.10 or are you sing 2.6.8?

Matthias-Christian Ott
