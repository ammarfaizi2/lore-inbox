Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264811AbUFACBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264811AbUFACBO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 22:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264856AbUFACBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 22:01:13 -0400
Received: from scanmail3.cableone.net ([24.116.0.123]:15631 "EHLO
	mail.cableone.net") by vger.kernel.org with ESMTP id S264811AbUFACBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 22:01:11 -0400
Subject: Re: nfsd readahead
From: Colin Gibbs <colin@gibbsonline.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16571.54072.719572.522225@cse.unsw.edu.au>
References: <20040531190525.GA20916@alpha.gibbsonline.net>
	 <16571.54072.719572.522225@cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1086055267.15496.55.camel@athlon.rexburg.gibbsonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 31 May 2004 20:01:07 -0600
X-Server: High Performance Mail Server - http://surgemail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-31 at 18:52, Neil Brown wrote:

> Thanks a lot Colin. (I did get your earlier person email, but it
> didn't get to the top of the priority queue until today).

Well I sent it to the nfs list first (it seems to have been eaten by
some moderation queue) and forgot I also sent it to you.

> The current code is a bit of a mess isn't it!!!
> 
> I have one question about your patch:
> 
> > +	file_ra_state_init(&ra->p_ra, file->f_mapping);
> 
> I note that the corresponding code in fs/open.c(dentry_open) reads
> 
> 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
> 
> i.e. there is an extra level of indirection.  Is there a reason that
> you didn't copy that.

Looks like that was in a patch after 2.6.6. Another good reason to avoid
duplicate code paths. 

> I am seriously thinking of getting rid of the "open_private_file"
> stuff, and using dentry_open to open files for nfsd, and just allow it
> to init the ra_state, so that nfsd doesn't do it itself.
> However that patch touches 13 files, so I want to see it get a bit of
> testing first.
> 
> Thanks again,
> I'll make sure this fix gets through Andrew to Linus,
> 
> NeilBrown

Thanks for taking care of this. 


Colin
