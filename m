Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWJIIYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWJIIYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWJIIYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:24:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:64981 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932189AbWJIIYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:24:11 -0400
From: Neil Brown <neilb@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Mon, 9 Oct 2006 18:24:03 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17706.1827.174148.860144@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       steved@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] lockdep: annotate nfs/nfsd in-kernel sockets
In-Reply-To: message from Peter Zijlstra on Monday October 9
References: <1160146860.2792.111.camel@taijtu>
	<17705.40741.552103.194329@cse.unsw.edu.au>
	<1160381521.2792.129.camel@taijtu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 9, a.p.zijlstra@chello.nl wrote:
> On Mon, 2006-10-09 at 11:00 +1000, Neil Brown wrote:
> > On Friday October 6, a.p.zijlstra@chello.nl wrote:
> > > 
> > > Stick NFS sockets in their own class to avoid some lockdep warnings.
> > > NFS sockets are never exposed to user-space, and will hence not trigger
> > > certain code paths that would otherwise pose deadlock scenarios.
> > 
> > I'm a bit bothered that the changelog entry does mention what sort of
> > lockdep warning are begin avoided, 
> 
> These:
>   http://lkml.org/lkml/2006/7/13/84

Wouldn't have hurt to have that link in the changelog... or maybe an
excerpt?

That is very much an nfs-client issue, so reclassifying the
server-side sockets seems irrelevant.  Doesn't cause any harm though I
suppose.

> 
> > and that 'svc_reclassify_socket'
> > doesn't contain the work 'lock', yet is it really the locks that are
> > being reclassified.
> 
> Hmm, good point, shall I do s/reclassify_socket/reclassify_sock_lock/ ?
> 

If you want to keep that function, then yes.

Thanks,
NeilBrown
