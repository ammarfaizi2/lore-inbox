Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUDSXVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUDSXVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 19:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUDSXVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 19:21:33 -0400
Received: from outmx016.isp.belgacom.be ([195.238.2.115]:56778 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261236AbUDSXVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 19:21:32 -0400
Subject: Re: [PATCH 2.6.6rc1-mm1] NFS sysctlized - readahead tunable
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1082408907.3360.14.camel@lade.trondhjem.org>
References: <1082407753.18853.12.camel@bluerhyme.real3>
	 <1082408907.3360.14.camel@lade.trondhjem.org>
Content-Type: text/plain
Message-Id: <1082410183.19241.12.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 23:29:43 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx016.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-19 at 23:08, Trond Myklebust wrote:
> On Mon, 2004-04-19 at 16:49, Fabian Frederick wrote:
> > Trond,
> > 
> > 	Here is a patch to have nfs to sysctl although Maxreadahead is tunable
> > under nfs init only.Do you have an idea and do you think it's acceptable
> > to make it applicable directly i.e. would it be readahead reduction
> > tolerant ?
> > 
> > btw, is this inode.c an issue for V4 ?
> > 
> 
> The lockd module has already registered the name /proc/sys/fs/nfs, so
> your scheme will end up corrupting the sysctl list. Sorting out the
> /proc namespace issue is the main reason why this hasn't been done
> before.
> Personally, I'd prefer renaming the lockd module into
> /proc/sys/fs/lockd, but it will have to be up to Andrew to decide
> whether he wants to allow that during a stable kernel cycle.
AFAICS one of the first sysctl concepts is to be redundancy tolerant.
If you take fs for instance, it's being declared here and there.
It means "if it doens't exist yet, we create it with mode (555) else
 go cycle to the sub-branch (fs-nfs....) btw, we have a register(fs) so
no problem for me.Lockd has to do with nfs so it should be preserved at
the same place IMHO.

> 
> Also note that putting initializers into a ".h" file is horrible style.
> ".h" files should be for forward declarations only.
I used both ntfs, coda fs scheme having in mind independant sysctl
registering in forthcoming releases.

But hey ! "I'm an absolute beginner" :) Maybe you and Andrew can tell me
what to do with this ugly patch ;) e.g. no sysctl.h -> include stuff in
inode.c ...

Regards,
FabianF


