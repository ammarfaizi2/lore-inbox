Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSDKO3y>; Thu, 11 Apr 2002 10:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314076AbSDKO3x>; Thu, 11 Apr 2002 10:29:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:55233 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314075AbSDKO3w>;
	Thu, 11 Apr 2002 10:29:52 -0400
Date: Thu, 11 Apr 2002 10:29:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-pre3 & ext3: cannot chown
In-Reply-To: <3CB538FE.B97F200E@zip.com.au>
Message-ID: <Pine.GSO.4.21.0204111028390.18886-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Apr 2002, Andrew Morton wrote:

> Duncan Sands wrote:
> > 
> > The subject just about says it all.  After 12 hours
> > of uptime running 2.5.8-pre3 on an ext3 partition,
> > I noticed that changing the owner of a file had no
> > effect.  Rebooting with 2.4.18, there was no problem
> > in using chown.
> 
> How does this look?
> 
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


Good catch.  Linus, please apply.

