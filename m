Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292657AbSCSUUJ>; Tue, 19 Mar 2002 15:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSCSUUB>; Tue, 19 Mar 2002 15:20:01 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33328 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S292589AbSCSUTx>; Tue, 19 Mar 2002 15:19:53 -0500
To: "Martin K. Petersen" <mkp@mkp.net>
Cc: Andrew Morton <akpm@zip.com.au>, Joel Becker <jlbec@evilplan.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au>
	<3C945D7D.8040703@mandrakesoft.com>
	<5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
	<20020318080531.W4836@parcelfarce.linux.theplanet.co.uk>
	<3C95A1DB.CA13A822@zip.com.au> <yq1bsdmq6so.fsf@austin.mkp.net>
	<3C963CD5.8E371FF@zip.com.au> <yq17ko9r7bc.fsf@austin.mkp.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Mar 2002 13:08:48 -0700
Message-ID: <m1it7swca7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin K. Petersen" <mkp@mkp.net> writes:

> >>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:
> 
> Andrew> If that's really the only way in which we can solve this
> Andrew> problem, would it not be better to pass information up to the
> Andrew> higher layer, telling it when the BIO which is currently under
> Andrew> assembly cannot be grown further?  Say,
> Andrew> blk_can_i_add_more_stuff_to_this_bio()?

Please let's extend BIOs and not break them up.
 
> We tried different approaches.  One of them was to be able to signal
> to upper layers that your I/O was too big and please submit smaller
> chunks.  Running with that, however, the I/O size converged against
> small requests because you'd often start an I/O - say 4K - from a
> stripe boundary.  And that would kill it right off.
> 
> So unless the filesystem knows about stripe/device boundaries it's
> really hard to get the size signalling right.  And then what happens
> when you stack LVM and MD?
> 
> In the end, cloning the kiobuf from the above and adjusting
> offset/length in the children turned out to be the best approach.

Unless I am mistaken this interacts very badly with the writing data
out to disk to free up memory, because you must allocate memory to
split the bio.  Which is the last place you want to allocate memory
if you can avoid it.

It's been a while but I believe there was a similiar thread about
splitting request to disk and the idea was shot down for similiar
reasons. 

Eric


