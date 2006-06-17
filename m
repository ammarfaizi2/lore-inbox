Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWFRNhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWFRNhL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 09:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWFRNhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 09:37:11 -0400
Received: from kanga.kvack.org ([66.96.29.28]:28549 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932230AbWFRNhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 09:37:10 -0400
Date: Sat, 17 Jun 2006 16:55:43 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Grant Coady <gcoady.lk@gmail.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060617195543.GA26972@dmt>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <6bffcb0e0606161538w41036b4ajdb394ef5a36eebd2@mail.gmail.com> <q5f69219dre4fufq44jgo76msqe3btch1g@4ax.com> <20060617051356.GA23202@1wt.eu> <il57929b81lja4bb24sj77575vqibu19ev@4ax.com> <20060617071000.GA23498@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060617071000.GA23498@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Willy, this worked.  
> 
> OK Fine. However, I don't understand. From you oops, it looks like
> dentry->d_inode suddenly gets NULL before calling this line :
> 
>         double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
> 
> I'm wondering if the unlink(dir, dentry) above can produce this. If this
> is the case, the Vadim's fix is terribly broken. I also think that in
> vfs_link(), we can encounter the same problem that Marcelo had to fix,
> because double_down() is performed without prior checking that
> old_dentry->d_inode is valid.

Right, it should just check for the NULL case. 

> Marcelo, do you have Vadim's email somewhere ? I think he should help us
> on this otherwise it would be better to revert his fix, as it has introduced
> lots of sensible changes in the error path.

The patch fixes a serious SMP race.

> 
> > Grant.
> 
> Thanks for the tests, Grant.
> Willy
