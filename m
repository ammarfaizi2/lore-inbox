Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272566AbRHaDZ5>; Thu, 30 Aug 2001 23:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272501AbRHaDZr>; Thu, 30 Aug 2001 23:25:47 -0400
Received: from mail.mesatop.com ([208.164.122.9]:37391 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S272496AbRHaDZg>;
	Thu, 30 Aug 2001 23:25:36 -0400
Message-Id: <200108310325.f7V3Pge00680@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Albert Cranford <ac9410@bellsouth.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch]: incorrect e2fsprog data from ver_linux script
Date: Thu, 30 Aug 2001 21:24:19 -0400
X-Mailer: KMail [version 1.2.3]
In-Reply-To: <3B8EF06D.24BAB4AF@bellsouth.net>
In-Reply-To: <3B8EF06D.24BAB4AF@bellsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 August 2001 10:03 pm, Albert Cranford wrote:
> Hello Alan/Linus,
> Ted suggested I pass this onto your for 2.2 and 2.4
> Please apply small patch to both releases.
> Thanks,
> Albert
>
>
> -------- Original Message --------
> Subject: incorrect e2fsprog data from ver_linux script
> Date: Thu, 30 Aug 2001 10:08:27 -0400
> From: Albert Cranford <ac9410@bellsouth.net>
> To: tytso@valinux.com, tytso@mit.edu
>
> Hello Ted,
> I'm not sure when incorrect e2fsprog info started popping
> up from the linux/scripts/ver_linux script, but what do
> you think about submitting this patch to Linus?
> Later,
> Albert
>

Hmm, this worked for e2fsprogs 1.22, e2fsprogs 1.23 was released
8-15-01 according to Sourceforge.

I applied your fix, and yes it now works for 1.23:

[root@localhost linux]# sh scripts/ver_linux
[irrelevant stuff snipped]
modutils               2.4.3
e2fsprogs              1.23
reiserfsprogs          3.x.0i

Ok, so far so good.  Now checking ver_linux shipped with 2.4.9-ac5
[root@localhost linux]# sh scripts/ver_linux.ac5
[irrelevant stuff snipped]
modutils               2.4.3
e2fsprogs              tune2fs
reiserfsprogs          3.x.0i

Yep, it's broken for e2fsprogs 1.23 all right.

Now, I installed e2fsprogs 1.22, and your new version breaks:

[root@localhost linux]# sh scripts/ver_linux  <--- with your patch
[irrelevant stuff snipped]
modutils               2.4.3
e2fsprogs              tune2fs
reiserfsprogs          3.x.0i

and the old version (old as in 2.4.9-ac5) works for e2fsprogs 1.22
[root@localhost linux]# sh scripts/ver_linux.ac5
[irrelevant stuff snipped]
modutils               2.4.3
e2fsprogs              1.22
reiserfsprogs          3.x.0i

So, this patch breaks the ver_linux script for 1.22, and 1.21 (I checked
this too).  If someone wants to fix this right, please jump in.

Steven
