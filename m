Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUJPVpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUJPVpa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUJPVp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:45:29 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:49029 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S268894AbUJPVoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:44:09 -0400
Subject: Re: Best way to find where a lock is taken and not released?
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041016164646.GD2061@schnapps.adilger.int>
References: <1097919013.4763.55.camel@desktop.cunninghams>
	 <20041016164646.GD2061@schnapps.adilger.int>
Content-Type: text/plain
Message-Id: <1097962858.23471.4.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sun, 17 Oct 2004 07:40:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2004-10-17 at 02:46, Andreas Dilger wrote:
> On Oct 16, 2004  19:30 +1000, Nigel Cunningham wrote:
> > I saw a hang the other day (2.6.8.1) where all other processes except
> > the suspending to disk one were refrigerated and the process doing the
> > suspending was stuck trying to take the dcache_lock via
> > shrink_all_memory. Obviously some path called via shrink_all_memory had
> > taken the lock and not released it, then tried to retake it _or_ another
> > process had taken the lock and then not released it when backing out and
> > entering the refrigator. My question is, what's the best way to find the
> > path on which this occurs? Grepping, I see dcache_lock all over the
> > show, so if there's a more efficient method that reading the files, I'd
> > like to learn it. It occurs to me that I might try wrapping calls to
> > lock and unlock that lock in printks, but I'm wondering if there's some
> > better way I don't yet know.
> 
> Probably the easiest would be to add to the lock struct a pointer to
> the task_struct and the EIP when it gets the lock, and clear them when
> it releases the lock.  That way, when you see processes blocking on the
> lock you can use crash or other tool to examine the lock and see which
> process got the lock and also where.

Okee doke. I saw that kgdb uses that method. I'll give it a go.

Thanks!

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

