Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbRESPL1>; Sat, 19 May 2001 11:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261827AbRESPLS>; Sat, 19 May 2001 11:11:18 -0400
Received: from smtp1.libero.it ([193.70.192.51]:25287 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S261821AbRESPLM>;
	Sat, 19 May 2001 11:11:12 -0400
Message-ID: <3B068D00.95338099@alsa-project.org>
Date: Sat, 19 May 2001 17:10:56 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.GSO.4.21.0105190940310.5339-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
>         Folks, before you get all excited about cramming side effects into
> open(2), consider the following case:
> 
> 1) opening "/dev/zero/start_nuclear_war" has a certain side effect.
> 
> 2) Local user does the following:
>         ln -sf /dev/zero/start_nuclear_war bar
>         while true; do
>                 mkdir foo
>                 rmdir foo
>                 ln -sf bar foo
>                 rm foo
>         done
> 
> 3) Comes the night and root runs (from crontab) updatedb(8). Said beast
> includes find(1). With sufficiently bad timing find _will_ be tricked
> into attempt to open foo. It will honestly lstat() it, all right. But
> there's no way to make sure that subsequent open() on the found directory
> will get the same object.
> 
> 4) Side effect happens...
> 
> Similar scenarios can be found for other programs run by/as root, but I
> think that the point is obvious - side effects on open() are not a good
> idea. Yes, we can play with checking for O_DIRECTORY, yodda, yodda, but
> I wouldn't bet a dime on security of a system with such side effects.
> A lot of stuff relies on the fact that close(open(foo, O_RDONLY)) is a
> no-op. Breaking that assumption is a Bad Thing(tm).

Can't this easily avoided if the needed action is not

< /dev/zero/start_nuclear_war 
or
> /dev/zero/start_nuclear_war

but

echo "I'm evil" > /dev/zero/start_nuclear_war

?

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
