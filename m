Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbRAEU0o>; Fri, 5 Jan 2001 15:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbRAEU0e>; Fri, 5 Jan 2001 15:26:34 -0500
Received: from [24.65.192.120] ([24.65.192.120]:32248 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S130329AbRAEU03>;
	Fri, 5 Jan 2001 15:26:29 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101052026.f05KQGx20058@webber.adilger.net>
Subject: Re: More better in mount(2)
In-Reply-To: <3A55DF78.F92AC570@innominate.de> "from Daniel Phillips at Jan 5,
 2001 03:51:36 pm"
To: Daniel Phillips <phillips@innominate.de>
Date: Fri, 5 Jan 2001 13:26:16 -0700 (MST)
CC: Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> [re strtok for mount option parsing]
> 
> BUGS        Never use this function. If you do, note that:  
>             This function modifies its first argument.  
>             The identity of the delimiting character is lost.  
>             This functions cannot be used on constant  strings.  
>             The  strtok() function uses a static buffer while
>             parsing, so it's not thread safe. Use  strtok_r()
>             if this matters to you.

Luckily, when mount(8) is trying to mount a filesystem, it passes the
mount options into the kernel each time, which does copy_from_user(),
so the fact that strtok() breaks the data is OK.  The only time this
is bad is with Stephen's ext3 rootflags option...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
