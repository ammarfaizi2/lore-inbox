Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTB0Thy>; Thu, 27 Feb 2003 14:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTB0Thy>; Thu, 27 Feb 2003 14:37:54 -0500
Received: from daimi.au.dk ([130.225.16.1]:29352 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S266434AbTB0ThD>;
	Thu, 27 Feb 2003 14:37:03 -0500
Message-ID: <3E5E6B39.3DD1C6A@daimi.au.dk>
Date: Thu, 27 Feb 2003 20:47:05 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Kubla <dominik@kubla.de>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Miles Bader <miles@gnu.org>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <200302271600.h1RG0Cdh011948@eeyore.valparaiso.cl> <200302271740.06139.dominik@kubla.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla wrote:
> 
> So there are quite some differences between the Linux proc file and
> the Solaris mntfs filesystem.  If these differences justify us doing it the
> same way is debateable.
> 
> The strongest argument i see is: It's already been done this way by one
> major Unix version, so why should Linux reinvent the wheel. Again.

The reason for implementing that would IMHO not be to just get the features
that solaris has, but rather to get rid of /etc/mtab. I guess we all agree,
that a kernel implementation, that being a misc char device or a proc pseudo
file would be better than the current /etc/mtab file. But I think a kernel
implementation is also the most tricky. Bind mounting /proc/mounts onto
/etc/mtab would to some extent resemble the solaris implementation, but
there are noticable differences. I think one major question is if we can
actually make a kernel implementation that without help from userspace will
provide all the information that we have usually gotten from /etc/mtab. If
that is possible, I think we should aim for that and thereby make /etc/mtab
obsolete. Then we can eventually replace /etc/mtab with a symlink pointing
to /proc/mtab, /proc/self/mtab, or /proc/1/mtab. The fact that solaris makes
a snapshot of the mountpoints might be convenient, but really not that
important. The correct size reported by stat is also just a convenience. The
exact reporting of mtime is as already pointed out of real value to some
applications. And the ioctl to get major and minor is certainly helpful if
the device field is reused for other purposes in the case of bind mounts and
loopback mounts. Does solaris actually have those features, and what does
mnttab report in those cases? And while we are discussing bind mounts, there
is one feature that I have sometimes missed: A possibility to directly mount
a subdirectory of a filesystem without having to mount the root of that
filesystem first and use a bindmount afterwards.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
