Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264363AbTCXRLN>; Mon, 24 Mar 2003 12:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264356AbTCXRKs>; Mon, 24 Mar 2003 12:10:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15803 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264345AbTCXRJ6>;
	Mon, 24 Mar 2003 12:09:58 -0500
Date: Mon, 24 Mar 2003 18:21:06 +0100
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: current BK boot failure, d_alloc()
Message-ID: <20030324172106.GT2371@suse.de>
References: <20030324115048.GA2371@suse.de> <20030324120217.GB2371@suse.de> <33047.4.64.238.61.1048525736.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33047.4.64.238.61.1048525736.squirrel@www.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24 2003, Randy.Dunlap wrote:
> > On Mon, Mar 24 2003, Jens Axboe wrote:
> >> Hi,
> >>
> >>
> [snip]
> >> craps out in memcpy() due to name->name == NULL
> >
> > smells like a compiler problem, with the following patch:
> >
> > ===== fs/dcache.c 1.43 vs edited =====
> > --- 1.43/fs/dcache.c	Sat Mar 22 05:05:21 2003
> > +++ edited/fs/dcache.c	Mon Mar 24 12:58:19 2003
> > @@ -784,7 +784,8 @@
> >  	struct dentry *res = NULL;
> >
> >  	if (root_inode) {
> > -		res = d_alloc(NULL, &(const struct qstr) { "/", 1, 0 });
> > +		struct qstr name = { .name = "/", .len = 1, .hash = 0 };
> > +		res = d_alloc(NULL, &name);
> >  		if (res) {
> >  			res->d_sb = root_inode->i_sb;
> >  			res->d_parent = res;
> >
> > --
> 
> what compiler, please?

gcc 3.3 pre-release, I cannot reproduce it in userspace though. I'll try
and take a look at the generated code.

-- 
Jens Axboe

