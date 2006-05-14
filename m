Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWENLQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWENLQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 07:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWENLQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 07:16:25 -0400
Received: from ns2.suse.de ([195.135.220.15]:27032 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751394AbWENLQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 07:16:24 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Sun, 14 May 2006 21:15:35 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17511.4439.350553.687518@cse.unsw.edu.au>
Cc: Paul Clements <paul.clements@steeleye.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to
 use bmap to file blocks.
In-Reply-To: message from Andrew Morton on Saturday May 13
References: <20060512160121.7872.patches@notabene>
	<1060512060809.8099@suse.de>
	<20060512104750.0f5cb10a.akpm@osdl.org>
	<17509.22160.118149.49714@cse.unsw.edu.au>
	<20060512235934.4f609019.akpm@osdl.org>
	<4465FB5C.6070808@steeleye.com>
	<20060513084208.0857ff52.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday May 13, akpm@osdl.org wrote:
> Paul Clements <paul.clements@steeleye.com> wrote:
> >
> > Andrew Morton wrote:
> > 
> > > The loss of pagecache coherency seems sad.  I assume there's never a
> > > requirement for userspace to read this file.
> > 
> > Actually, there is. mdadm reads the bitmap file, so that would be 
> > broken. Also, it's just useful for a user to be able to read the bitmap 
> > (od -x, or similar) to figure out approximately how much more he's got 
> > to resync to get an array in-sync. Other than reading the bitmap file, I 
> > don't know of any way to determine that.
> 
> Read it with O_DIRECT :(

Which is exactly what the next release of mdadm does.
As the patch comment said:

: With this approach the pagecache may contain data which is inconsistent with 
: what is on disk.  To alleviate the problems this can cause, md invalidates
: the pagecache when releasing the file.  If the file is to be examined
: while the array is active (a non-critical but occasionally useful function),
: O_DIRECT io must be used.  And new version of mdadm will have support for this.

