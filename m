Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264863AbUFAAwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264863AbUFAAwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 20:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbUFAAwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 20:52:18 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:24232 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264863AbUFAAwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 20:52:15 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Colin Gibbs <colin@gibbsonline.net>
Date: Tue, 1 Jun 2004 10:52:08 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16571.54072.719572.522225@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsd readahead
In-Reply-To: message from Colin Gibbs on Monday May 31
References: <20040531190525.GA20916@alpha.gibbsonline.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 31, colin@gibbsonline.net wrote:
> Hi,
> 
> I was having problems with slow streaming reads over nfs. After much
> investigation, I found that nfsd uses its own cache of readahead
> parameters and that:
> (1) they were not being reused
> (2) they were not being initialized properly

Thanks a lot Colin. (I did get your earlier person email, but it
didn't get to the top of the priority queue until today).

The current code is a bit of a mess isn't it!!!

I have one question about your patch:

> +	file_ra_state_init(&ra->p_ra, file->f_mapping);

I note that the corresponding code in fs/open.c(dentry_open) reads

	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);

i.e. there is an extra level of indirection.  Is there a reason that
you didn't copy that.

I am seriously thinking of getting rid of the "open_private_file"
stuff, and using dentry_open to open files for nfsd, and just allow it
to init the ra_state, so that nfsd doesn't do it itself.
However that patch touches 13 files, so I want to see it get a bit of
testing first.

Thanks again,
I'll make sure this fix gets through Andrew to Linus,

NeilBrown
