Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRHQSf7>; Fri, 17 Aug 2001 14:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRHQSfu>; Fri, 17 Aug 2001 14:35:50 -0400
Received: from roc-24-95-218-9.rochester.rr.com ([24.95.218.9]:26240 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S266688AbRHQSfo>; Fri, 17 Aug 2001 14:35:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Chris Mason <mason@suse.com>
To: Chris Schanzle <chris.schanzle@jhuapl.edu>, linux-kernel@vger.kernel.org
Subject: Re: I/O causes performance problem with 2.4.8-ac3
Date: Fri, 17 Aug 2001 13:50:03 -0400
X-Mailer: KMail [version 1.3]
In-Reply-To: <3B7C08D4.9070303@jhuapl.edu>
In-Reply-To: <3B7C08D4.9070303@jhuapl.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15Xnky-0002ZV-00@roc-24-169-102-121.rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 August 2001 01:54 pm, Chris Schanzle wrote:
> This probably belongs in the "use-once" thread...
>
> I ran into a significant (lack of) performance situation with 2.4.8-ac3
> that does not exist with 2.4.8.  Perhaps someone can shed some light on
> what happened and how to avoid it in the future.
>
>
> Performance was excellent until I decided to "dd bs=1024k </dev/cdrom
>
>  >somefile" a 600+MB cdrom while a kernel build was going on.  It took
>
> nearly 7 minutes to complete the dd and near the end, the cdrom drive
> light was only occasionally flickering activity (not "on" as it was at the
> start), keystrokes were delayed, refreshes were sluggish.  

Most of the current use once code is for the page cache, dd if=/dev/cdrom 
will read from the buffer cache, where the pages will take longer to age out. 
 One of the patches between 2.4.8pre7 and 2.4.8final seems to have helped a 
lot here, but I'm not sure which one it was (check out the 'still buffer 
cache problems' thread).  I'm also not sure if the speedup was intentional, 
so it might go away during future tweaks.

Rik also posted a patch in 2.4.8-ac5 that deactivates buffer cache pages 
after a threshold, which should help as well (and benefit reiserfs/ext3 in 
general).

-chris
