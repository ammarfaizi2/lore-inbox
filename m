Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTB0WXr>; Thu, 27 Feb 2003 17:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTB0WXr>; Thu, 27 Feb 2003 17:23:47 -0500
Received: from daimi.au.dk ([130.225.16.1]:4058 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S267241AbTB0WVB>;
	Thu, 27 Feb 2003 17:21:01 -0500
Message-ID: <3E5E91B2.8EACF7D0@daimi.au.dk>
Date: Thu, 27 Feb 2003 23:31:14 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <200302271600.h1RG0Cdh011948@eeyore.valparaiso.cl> <200302271740.06139.dominik@kubla.de>
	            <3E5E6B39.3DD1C6A@daimi.au.dk> <200302272213.h1RMDQJT017937@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> 
> On Thu, 27 Feb 2003 20:47:05 +0100, Kasper Dupont said:
> 
> > mnttab report in those cases? And while we are discussing bind mounts, there
> > is one feature that I have sometimes missed: A possibility to directly mount
> > a subdirectory of a filesystem without having to mount the root of that
> > filesystem first and use a bindmount afterwards.
> 
> Hmm.. so what you mean is being able to have a filesystem called (for example)
> /somewhere, and being able to mount /somewhere/deep/path/like/this on a
> mountpoint /wherever/else, but without having /somewhere mounted itself?

Yes.

> That looks *almost* doable, except that things like quotas or the free
> block list would be a hassle if then you also went and mounted
> /somewhere/deep/other/path on /something/else

It is doable. And you don't need to change the filesystems themselves.
In fact VFS has most of the support right now. It can be done in
userspace, I can do it by first mounting /somewhere then use --bind
and finally unomount /somewhere. The reason I brought it up is that
if we are going to change mount, we might want to add this feature,
and we should find some better strings for the device field in mtab.
Right now the sequence of commands I suggested would leave the name
of an unmounted filesystem in a device field in the mtab file. Perhaps
rather than writing the oldparth, it would be wiser to write
device:path in the device field, where path would be path relative to
the root of the filesystem. Then that same notation could be supported
by mount, and implemented by temporarily mounting the root of that
filesystem.

The only case that couldn't be done from userspace is mounting of the
root. Now some people might say nobody would need that feature, and it
could be done using initrd and some pivot_root stuff anyway. But in
fact a very similar feature already exists in the umsdos filesystem.
IMHO that feature should be removed from umsdos and reimplemented
using pivot_root instead. Then at the same time the hardcoded paths
could be changable through boot options, and the feature could become
filesystem independend.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
