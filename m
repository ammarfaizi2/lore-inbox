Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSFDV5r>; Tue, 4 Jun 2002 17:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSFDV5q>; Tue, 4 Jun 2002 17:57:46 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:54162
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S316851AbSFDV5p>; Tue, 4 Jun 2002 17:57:45 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200206042157.g54LvbS15220@www.hockin.org>
Subject: Re: Max groups at 32?
To: davem@redhat.com (David S. Miller)
Date: Tue, 4 Jun 2002 14:57:37 -0700 (PDT)
Cc: thockin@hockin.org, kloczek@rudy.mif.pg.gda.pl, jgarzik@mandrakesoft.com,
        austin@coremetrics.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020604.142424.63998011.davem@redhat.com> from "David S. Miller" at Jun 04, 2002 02:24:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I screwed up sending this out - just in case it didn't go properly to the
list...


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

