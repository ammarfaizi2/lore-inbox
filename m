Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbRFCOsR>; Sun, 3 Jun 2001 10:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263160AbRFCOm5>; Sun, 3 Jun 2001 10:42:57 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:49661 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S263127AbRFCOmo>; Sun, 3 Jun 2001 10:42:44 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106031442.f53EgNRv003295@webber.adilger.int>
Subject: Re: query
In-Reply-To: <7FADCB99FC82D41199F9000629A85D1A01C67B31@dcmtechdom.dcmtech.co.in>
 "from Chanchal Chawla at Jun 2, 2001 03:38:45 pm"
To: Chanchal Chawla <chanchalx.chawla@dcmtech.co.in>
Date: Sun, 3 Jun 2001 08:42:23 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chanchal Chawla writes:
>     i'm writing a file system code, i've a query regarding that, i want you
> to help me out if possible, 
>   
>     is it possible to get the absolute mount point of a device at run time
> in that code ? if it is possible then how we can get it ?

It was possible in 2.2 with a minor hack.  I did it by passing mountpoint
dentry via sb->s_root to filesystem, and using d_path() to do the path
lookup inside the filesystem.  s_root is overwritten by the filesystem
to hold the new fs root dentry, so you need to get the path and store it
elsewhere before s_root is overwritten.

In 2.4 I was trying to get Al Viro to tell me the best way to do this, but
because it is _possible_ to mount a filesystem multiple times under 2.4 it
raises a question about which mountpoint you should use.  In 2.4 you need
to supply an additional vfsmnt parameter to d_path(), and I never did get
an answer out of Al as to how to get a vfsmnt inside the filesystem, even
if there is only one mount of the filesystem.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
