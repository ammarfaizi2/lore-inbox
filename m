Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSFDVkw>; Tue, 4 Jun 2002 17:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316843AbSFDVkv>; Tue, 4 Jun 2002 17:40:51 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:43922
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S316842AbSFDVkt>; Tue, 4 Jun 2002 17:40:49 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200206042140.g54LenZ14184@www.hockin.org>
Subject: Re: Max groups at 32?
To: davem@redhat.com (David S. Miller)
Date: Tue, 4 Jun 2002 14:38:42 -0700 (PDT)
Cc: adrian.sun@sun.com, erik.gilling@sun.com
In-Reply-To: <20020604.142424.63998011.davem@redhat.com> from "David S. Miller" at Jun 04, 2002 02:24:24 PM
X-Mailer: ELM [version 2.5 PL3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    We have a patch floating around that enables unlimited group membership at
>    the kernel level, too.  We've never submitted it because it was suggested
>    that we were crazy and should just bugger off.   If I thought it might be
>    useful and acceptable, we could perhaps make it available in a cleanish
>    form.
> 
> How do it handle userland backwards compatibility with the existing
> stuff?

getgroups/setgroups always use a size.  use sysctl() to get/set the
max ngroups value (default to 32).

It involves some little tweaks at various places, and we keep the groups
list sorted because it can now get very large.  But all the kernel code is
pretty clean.  Patching glibc to do the right thing was straight forward.
Then a well-done app will call sysctl() to get the ngroups, make room for
it and call getgroups().

Old apps that count on NGROUPS being constant will only get the first 32
groups.  System admin can define max NGROUPS at boot time via sysctl.

I think I have accurately described it - I didn't write it, so I CC:ed
Erik, who did.   It'd be super cool to get this pushed back.  I haven't
been trying too hard, but I can definately spend some time prepping it, if
it has better than a snowball's chance. 

Tim

