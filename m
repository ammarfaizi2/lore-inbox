Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVHWUuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVHWUuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVHWUuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:50:39 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:4367 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932393AbVHWUuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:50:39 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050823203356.GF9322@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Tue, 23 Aug 2005 21:33:56 +0100)
Subject: Re: [PATCH 2/8] namei cleanup
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu> <20050823203356.GF9322@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1E7fil-0006KO-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Aug 2005 22:50:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bad names, IMO.
>   

You're probably right.  Can you suggest better ones?

Thanks,
Miklos

> > +static inline void dput_path(struct path *path, struct nameidata *nd)
> > +{
> > +	dput(path->dentry);
> > +	if (path->mnt != nd->mnt)
> > +		mntput(path->mnt);
> > +}
> > +
> > +static inline void path_to_nameidata(struct path *path, struct nameidata *nd)
> > +{
> > +	dput(nd->dentry);
> > +	if (nd->mnt != path->mnt)
> > +		mntput(nd->mnt);
> > +	nd->mnt = path->mnt;
> > +	nd->dentry = path->dentry;
> > +}
