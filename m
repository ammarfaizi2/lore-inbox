Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129512AbRBFOfR>; Tue, 6 Feb 2001 09:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129537AbRBFOfJ>; Tue, 6 Feb 2001 09:35:09 -0500
Received: from winds.org ([207.48.83.9]:51972 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129512AbRBFOe7>;
	Tue, 6 Feb 2001 09:34:59 -0500
Date: Tue, 6 Feb 2001 09:33:22 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: neilb@cse.unsw.edu.au
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS stop/start problems (related to datagram shutdown bug?)
Message-ID: <Pine.LNX.4.21.0102060925260.1065-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There does seem to be a possible problem with sk_inuse not being
> updated atomically, so a race between an increment and a decrement
> could lose one of them.
> svc_sock_release seems to often be called with no more protection than
> the BKL, and it decrements sk_inuse.
>
> svc_sock_enqueue, on the other hand increments sk_inuse, and is
> protected by sv_lock, but not, I think, by the BKL, as it is called by
> a networking layer callback. So there might be a possibility for a
> race here.
>
> The attached patch might fix it, so if you are having reproducable
> problems, it might be worth applying this patch.
>
> NeilBrown

I applied the patch and the problem seems to have gone away, where it was
fairly reproducable beforehand. It waits a little longer (about 4 seconds)
during the NFS daemon shutdown before [  OK  ] pops up, but it could be my
imagination because I was doing it on the 166 and I was used to the 866's.

But what matters is that I can stop and restart NFS just fine now whereas
before I couldn't. Thanks for the patch.

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
