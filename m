Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315187AbSEHVUO>; Wed, 8 May 2002 17:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315190AbSEHVUN>; Wed, 8 May 2002 17:20:13 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:14088 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S315187AbSEHVUN>; Wed, 8 May 2002 17:20:13 -0400
Date: Wed, 8 May 2002 22:20:00 +0100 (BST)
From: <chris@scary.beasts.org>
X-X-Sender: <cevans@sphinx.mythic-beasts.com>
To: Dax Kelson <dax@gurulabs.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Completely honor prctl(PR_SET_KEEPCAPS, 1)
In-Reply-To: <Pine.LNX.4.44.0205081341160.10496-100000@mooru.gurulabs.com>
Message-ID: <Pine.LNX.4.33.0205082210310.17893-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 May 2002, Dax Kelson wrote:

> With the current behaviour an app has to link against libcap and do:
>
> prtctl(PR_SET_KEEPCAPS, 1)
> pre_caps = (capgetp(0, cap_init())  // save our caps into a struct
> setuid(uid)
> setgid(gid)
> capsetp(0,pre_caps)  // Restore them
>
> With this patch, the app does:
>
> prtctl(PR_SET_KEEPCAPS, 1)
> setuid(uid)
> setgid(gid)

Are you sure about the current behaviour? Taking vsftpd as an example, it
does

prctl()
setuid()
setgid()
cap_set_proc()

i.e. it only fiddles with capabilities after dropping euid == 0. Of
course, someone is welcome to fiddle with capabilities while euid == 0.
But, euid == 0 is hugely privileged even without any capabilities. So, the
benefit of running with euid == 0 and less than full capabilities is a bit
limited.

Cheers
Chris

