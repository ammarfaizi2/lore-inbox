Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263969AbUECXrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbUECXrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbUECXrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:47:09 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:65421 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263969AbUECXrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:47:07 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Nikita Danilov <Nikita@Namesys.COM>
Date: Tue, 4 May 2004 09:46:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.55791.696323.84539@cse.unsw.edu.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
In-Reply-To: message from Nikita Danilov on Friday April 30
References: <16521.5104.489490.617269@laputa.namesys.com>
	<16529.56343.764629.37296@cse.unsw.edu.au>
	<16530.21623.588293.347094@laputa.namesys.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday April 30, Nikita@Namesys.COM wrote:
> 
> Also, Al Viro pointed to me that it's not clear why DCACHE_DISCONNECTED
> dentry is DCACHE_HASHED at all. If it were unhashed, last dput (done by
> nfsd thread) would destroy it, truncating file if necessary.
> 

This causes other problems (I vaguely remember).
It means that every NFS request on such a file would cause the dentry
to be created and then destroyed.  If the filesystem is keeping state
in the dentry, this gets lost.  I think some filesystems discard
preallocated space when the dentry is destroyed.  Even if not, there
is a performance hit. 

NeilBrown
