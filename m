Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312797AbSDKTAQ>; Thu, 11 Apr 2002 15:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312798AbSDKTAP>; Thu, 11 Apr 2002 15:00:15 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:27853 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S312797AbSDKTAO>; Thu, 11 Apr 2002 15:00:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.5.8-pre3 & ext3: cannot chown
Date: Thu, 11 Apr 2002 20:53:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <E16vYXu-0000HV-00@baldrick> <3CB538FE.B97F200E@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16vjhf-0000ad-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 April 2002 9:19 am, Andrew Morton wrote:
> Duncan Sands wrote:
> > The subject just about says it all.  After 12 hours
> > of uptime running 2.5.8-pre3 on an ext3 partition,
> > I noticed that changing the owner of a file had no
> > effect.  Rebooting with 2.4.18, there was no problem
> > in using chown.
>
> How does this look?

It looks good: with this patch I can now chown and chgrp
as usual.

Thanks for fixing this,

Duncan.

> --- linux-2.5.8-pre3/fs/open.c	Tue Apr  9 18:16:40 2002
> +++ 25/fs/open.c	Thu Apr 11 00:15:09 2002
> @@ -524,11 +524,11 @@ static int chown_common(struct dentry *
>  		goto out;
>  	newattrs.ia_valid =  ATTR_CTIME;
>  	if (user != (uid_t) -1) {
> -		newattrs.ia_valid =  ATTR_UID;
> +		newattrs.ia_valid |= ATTR_UID;
>  		newattrs.ia_uid = user;
>  	}
>  	if (group != (gid_t) -1) {
> -		newattrs.ia_valid =  ATTR_GID;
> +		newattrs.ia_valid |= ATTR_GID;
>  		newattrs.ia_gid = group;
>  	}
>  	if (!S_ISDIR(inode->i_mode))
>
> -
