Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282251AbRKWVod>; Fri, 23 Nov 2001 16:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282253AbRKWVoY>; Fri, 23 Nov 2001 16:44:24 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:46724 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S282251AbRKWVoN>; Fri, 23 Nov 2001 16:44:13 -0500
Message-ID: <001e01c17467$d1deaf10$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Alexander Viro" <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@transmeta.com>,
        "Marcelo Tosatti" <marcelo@conectiva.com.br>
In-Reply-To: <Pine.GSO.4.21.0111231606150.2422-100000@weyl.math.psu.edu>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Date: Fri, 23 Nov 2001 14:42:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Al,

I have seen this as well during testing, except in my case, it results in a
hard hang of sorts that does not respond to signals.  I can make it show up
easily by doing a copy accross mount points in low memory conditions, if any
of this helps.  Sounds like you've got a good handle on it, though.

Jeff

----- Original Message -----
From: "Alexander Viro" <viro@math.psu.edu>
To: <linux-kernel@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@transmeta.com>; "Marcelo Tosatti"
<marcelo@conectiva.com.br>
Sent: Friday, November 23, 2001 2:22 PM
Subject: 2.4.15-pre9 breakage (inode.c)


> Sigh...  Supposed fix to problems with stale inodes was completely
> broken.
>
> What we need is "if we are doing last iput() on fs that is getting
> shut, sync it and don't leave it in cache".  And yes, we have a similar
> path in iput().  Similar, but not quite the same.
>
> Fix is
> * new fs flag: "MS_ACTIVE".
> * set after normal ->read_super().
> * reset after we are done with fsync_super() in kill_super().
> * iput() checking that and if it's set - doing write_inode_now() and
kicking
> it out of hash.
>
> I'll send patch in ~10 minutes.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

