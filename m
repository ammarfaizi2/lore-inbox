Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUGBQjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUGBQjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUGBQjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:39:53 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:34524 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S264649AbUGBQjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:39:47 -0400
Date: Fri, 2 Jul 2004 09:39:40 -0700 (PDT)
From: Yichen Xie <yxie@cs.stanford.edu>
X-X-Sender: yxie@kaki.stanford.edu
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
In-Reply-To: <20040702011903.6360d43b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0407020933300.23611-100000@kaki.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

indeed, the code looks different in 2.6.7. definitely not a double unlock
any more, but it seems the new version exit w/ client_sema unheld at line
1616, and w/ the lock held at line 1625. is there a correlation between
the return value with the lock state? -yichen

On Fri, 2 Jul 2004, Andrew Morton wrote:

> Yichen Xie <yxie@cs.stanford.edu> wrote:
> >
> >     http://glide.stanford.edu/linux-lock/err1.html (69 errors)
> 
> nfsd4_open_confirm() looks to be a false positive - judging by the comment:
> 
> /*
>  * nfs4_unlock_state(); called in encode
>  */
> 
> the caller of this function is supposed to do nfs4_unlock_state() later on.
> 

