Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWIBHZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWIBHZP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 03:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWIBHZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 03:25:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15336 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750836AbWIBHZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 03:25:13 -0400
Subject: Re: Access Control Lists for tmpfs
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@namei.org>, Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20060901145203.d3880d1d.akpm@osdl.org>
References: <20060901221421.968954146@winden.suse.de>
	 <20060901221458.148480972@winden.suse.de>
	 <20060901145203.d3880d1d.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 02 Sep 2006 09:24:47 +0200
Message-Id: <1157181887.2881.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 14:52 -0700, Andrew Morton wrote:
> On Sat, 02 Sep 2006 00:14:23 +0200
> Andreas Gruenbacher <agruen@suse.de> wrote:
> 
> > +static void
> > +shmem_set_acl(struct inode *inode, int type, struct posix_acl *acl)
> > +{
> > +	spin_lock(&inode->i_lock);
> > +	switch(type) {
> > +		case ACL_TYPE_ACCESS:
> > +			if (SHMEM_I(inode)->i_acl)
> > +				posix_acl_release(SHMEM_I(inode)->i_acl);
> > +			SHMEM_I(inode)->i_acl = posix_acl_dup(acl);
> > +			break;
> 
> i_lock is "general-purpose, innermost per-inode lock".  Calling kfree()
> under it makes it no longer "innermost".  But kfree() is surely atomic wrt
> everything which filesystems and the VFS will want to do, so that's OK.

and lockdep probably will yell loudly if there's a problem.



-- 
VGER BF report: H 0
