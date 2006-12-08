Return-Path: <linux-kernel-owner+w=401wt.eu-S1425596AbWLHQBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425596AbWLHQBc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425595AbWLHQBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:01:32 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:36318 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425588AbWLHQBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:01:31 -0500
Date: Fri, 8 Dec 2006 11:00:38 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 26/35] Unionfs: Privileged operations workqueue
Message-ID: <20061208160038.GA17707@filer.fsl.cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu> <1165235471170-git-send-email-jsipek@cs.sunysb.edu> <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr> <20061205195013.GE2240@filer.fsl.cs.sunysb.edu> <20061206173245.GA23405@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0612061939340.16042@yvahk01.tjqt.qr> <20061208021714.GA14363@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0612081134360.12227@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612081134360.12227@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 11:38:13AM +0100, Jan Engelhardt wrote:
> 
> On Dec 7 2006 21:17, Josef Sipek wrote:
> >> >> > >+void __unionfs_mknod(void *data)
> >> >> > >+{
> >> >> > >+	struct sioq_args *args = data;
> >> >> > >+	struct mknod_args *m = &args->mknod;
> 
> ...
> ||||| vfs_mknod(m->parent, m->dentry, m->mode, m->dev);
> 
> >> >If I make the *args = data line const, then gcc (4.1) yells about modifying
> >> >a const variable 3 lines down..
> >> >
> >> >args->err = vfs_mknod(m->parent, m->dentry, m->mode, m->dev);
> >> >
> >> >Sure, I could cast, but that seems like adding cruft for no good reason.
> >> 
> >> No I despise casts more than missing consts. Why would gcc throw a warning?
> >> Let's take this super simple program
> >
> >No, this program doesn't tickle the problem.. Try to compile this one:
> 
> The members of m (i.e. m->*) are not modified as for as __unionfs_mknod goes.
> vfs_mknod may only modify the members of m->parent (i.e. m->parent->*)
 
Yes they are. The return value is passed through a member of m.
 
Josef "Jeff" Sipek.

-- 
The box said "Windows XP or better required". So I installed Linux.
