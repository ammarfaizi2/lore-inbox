Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVCFGEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVCFGEK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 01:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVCFGEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 01:04:10 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:8167 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261325AbVCFGED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 01:04:03 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Sun, 6 Mar 2005 17:03:46 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16938.40258.932869.915285@cse.unsw.edu.au>
Cc: "J.A. Magallon" <jamagallon@able.es>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11
In-Reply-To: message from Trond Myklebust on Sunday March 6
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org>
	<1110068394l.11446l.1l@werewolf.able.es>
	<1110088096.16110.3.camel@lade.trondhjem.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday March 6, trond.myklebust@fys.uio.no wrote:
> su den 06.03.2005 Klokka 00:19 (+0000) skreiv J.A. Magallon:
> 
> > static int __init init_nfsd(void)
> > {
> > ...
> >     if (proc_mkdir("fs/nfs", NULL)) {
> >         struct proc_dir_entry *entry;
> >         entry = create_proc_entry("fs/nfs/exports", 0, NULL);
> >         if (entry)
> >             entry->proc_fops =  &exports_operations;
> >     }
> > ...
> > 
> > But nfs-utils 1.0.7 say that you can mount nfsd at /proc/fs/nfsd.
> > What 'exports' would kernel use ? Just duplicate info or a bug ?
> 
> Not sure why /proc/fs/nfs was originally chosen (perhaps Neil
> knows?),

No, before my time.
/proc/fs/nfs/exports has "always" been a file listing the kernels
current understanding of the exports table.
The same information is provided by the "/exports" file in the nfsd
filesystem which (obviously) can be mounted anywhere you like, but
nfs-utils will only work with it if it is mounted on /proc/fs/nfsd
(the preferred location) or /proc/fs/nfs (because for a little while
/proc/fs/nfsd didn't exist).

> but the above code has nothing to do with where you mount the "nfsd"
> filesystem. It is rather part of the legacy support for older versions
> of nfs-utils.
> 
> We should aim to deprecate it at some point soon.

I would like to deprecate the nfssvc system call and /proc/fs/nfs, and
I was planning to do it when 2.7 came out .....
Maybe June 2005 would be a good time to mark it 'deprecated' and June
2006 would be a good time to remove it.

NeilBrown
