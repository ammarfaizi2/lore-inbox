Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTB0Xny>; Thu, 27 Feb 2003 18:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbTB0Xny>; Thu, 27 Feb 2003 18:43:54 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:57607 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S267275AbTB0Xnx>; Thu, 27 Feb 2003 18:43:53 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: About /etc/mtab and /proc/mounts
Date: Thu, 27 Feb 2003 23:54:13 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b3m8f5$i9d$2@news.cistron.nl>
References: <200302271600.h1RG0Cdh011948@eeyore.valparaiso.cl> <3E5E6B39.3DD1C6A@daimi.au.dk> <200302272213.h1RMDQJT017937@turing-police.cc.vt.edu> <3E5E91B2.8EACF7D0@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1046390053 18733 62.216.29.200 (27 Feb 2003 23:54:13 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E5E91B2.8EACF7D0@daimi.au.dk>,
Kasper Dupont  <kasperd@daimi.au.dk> wrote:
>The only case that couldn't be done from userspace is mounting of the
>root. Now some people might say nobody would need that feature, and it
>could be done using initrd and some pivot_root stuff anyway.

Well, the kernel already has a simple rootfs built-in, on top of
which the real root filesystem gets mounted at boot-time.

Also POSIX makes a difference between '/' and '//'. '//' might
point to a different namespace.

So why not mount rootfs on '//', mount the real rootfilesystem
on //root, then chroot to //root (while keeping it possible to
chdir("//") ).

If mkdir and rmdir is added to rootfs, you could even mount //mtab.d
there, or //proc, or //devfs, whatever you want to have available
when the root filesystem is being fscked or not even mounted yet.
Perhaps the kernel should mount all those pseudofilesystems there
by default even.

Apollo/DomainOS had this '//' thing, used for something different
(it was the equivalent of their /net autofs mountpoint) but it
worked quite well and didn't get in the way of normal '/' operation.

Mike.
-- 
Anyone who is capable of getting themselves made President should
on no account be allowed to do the job -- Douglas Adams.

