Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWJPB4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWJPB4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 21:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWJPB4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 21:56:33 -0400
Received: from stella.eotvos.elte.hu ([193.225.226.189]:22028 "EHLO
	stella.eotvos.elte.hu") by vger.kernel.org with ESMTP
	id S1751188AbWJPB4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 21:56:33 -0400
Date: Mon, 16 Oct 2006 03:56:06 +0200 (CEST)
From: Czigola Gabor <czigola@elte.hu>
X-X-Sender: czigola@kamorka
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: root MD array is still in use upon shutdown possible fix
In-Reply-To: <17705.39533.439604.522302@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0610160344100.8154@kamorka>
References: <Pine.LNX.4.64.0610062006460.25341@kamorka>
 <17705.39533.439604.522302@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-EC-Spam-Score: -2.8
X-EC-Spam-Report: spam=No; required=5.9; autolearn=failed; bayesian_score=0.5;
	stars=;
	scanned=stella.eotvos.elte.hu; Mon, 16 Oct 2006 03:56:24 +0200;
	scanner=SpamAssassin 3.0.3 2005-04-27;
	tests=ALL_TRUSTED;
	blacklisted_at=<dns:elte.hu?type=MX> [10 mx2.mail.elte.hu., 10 mx3.mail.elte.hu.]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your answer!

On Mon, 9 Oct 2006, Neil Brown wrote:

> if you get e.g.
>    md: md0 still in use.
> *after* that message then there might be a problem.  Otherwise
> everything should be fine.

Yes, I've got exactly that, and rarely after such a reboot the array 
started to resync.

> That being said, it is possible that your patch is OK.  I've been
> meaning to review the rules for switching an array to read-only for
> ages, but it never got to the top of the todo list.  e.g. do you want
> to be able to switch an array to read-only when a filesystem is
> mounted read-write off it.  If you don't, how do you check?  If you
> do, what about in-flight write requests?  Do you need to wait for them
> to complete? How? It isn't as straight forward as one might like.
>
> NeilBrown

I realised afterwrds, that this patch makes it possible to stop an array 
even it has a rw mounted filesystem on it. But I can easily remember not 
to switch the array to ro before umounting (remouning ro) the 
filesystem(s) on it, in return the array stops surely sync-d.

Of course, this isn't a solution for the kernel. But wouldn't it be 
possible to get the required information from the mount tables of the 
kernel? About pending write request to the md device does the subsystem 
already know.

-- 
Czigola, Gabor
