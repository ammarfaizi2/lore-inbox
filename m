Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268105AbUHNHQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268105AbUHNHQx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 03:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUHNHPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 03:15:46 -0400
Received: from mail.xor.ch ([212.55.210.163]:24845 "HELO mail.xor.ch")
	by vger.kernel.org with SMTP id S266185AbUHNHPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 03:15:35 -0400
Message-ID: <411DBC0C.7FE46F9C@orpatec.ch>
Date: Sat, 14 Aug 2004 09:15:24 +0200
From: Otto Wyss <otto.wyss@orpatec.ch>
Reply-To: otto.wyss@orpatec.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: "Theodore Ts'o" <tytso@mit.edu>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: New concept of ext3 disk checks
References: <411BAFCA.92217D16@orpatec.ch> <20040812223907.GA7720@thunk.org> <20040813003403.GK18216@schnapps.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 12, 2004  18:39 -0400, Theodore Ts'o wrote:
> > - Instead of checks forced during startup checks are done during runtime
> > (at low priority). It has to be determined if these checks are _only_
> > checks or if they also include possible fixes. Possible solution might
> > distinct between the severity of any discovered problem.
>
> This is something that doesn't require any kernel patches, or any
> other C coding for that matter, so it would be a great first project
> for someone who wanted to learn how to use the device-mapper snapshot
> feature. Basically, what you do is the following in a shell script
> which is fired off by cron once a week at 3am (or some other
> appropriate time):

Instead of a daily cron job I envision a solution where writes to the
disk are checked for correctness within a short time lag after they have
been done. Assume this time lag is set to a few minutes, on a high
performance system not each write of a certain node gets checked while
on a desktop system most probably each single write is. Choosing the
right time lag gives a balance of discovering problems fast against
additional disk access.

Okay, such tests could be done by a constantly running background task
in user space. But since journalling just should guarantee that any disk
access is done correct, even in case of problems, it should be
considered if such test can be integrated there. This has the advantage
that if journalling is able to guarantee correctness by other means
these test aren't needed at all and may be completely remove.

What I want to achieve with this new concept is that the file system
itself not only tries to prevent any data corruption but also tries to
detect and report it if corruption still has happened anyway. 

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"
