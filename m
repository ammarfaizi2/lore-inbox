Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154190AbQDLKIX>; Wed, 12 Apr 2000 06:08:23 -0400
Received: by vger.rutgers.edu id <S154240AbQDLKHi>; Wed, 12 Apr 2000 06:07:38 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:4397 "EHLO smtp1.cern.ch") by vger.rutgers.edu with ESMTP id <S154098AbQDLKCE>; Wed, 12 Apr 2000 06:02:04 -0400
Date: Wed, 12 Apr 2000 12:02:44 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Manfred Spraul <manfreds@colorfullife.com>
Cc: Andrea Arcangeli <andrea@suse.de>, "Stephen C. Tweedie" <sct@redhat.com>, "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk, kanoj@google.engr.sgi.com, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com
Subject: Re: zap_page_range(): TLB flush race
Message-ID: <20000412120244.G24128@pcep-jamie.cern.ch>
References: <Pine.LNX.4.21.0004111824090.19969-100000@maclaurin.suse.de> <38F364B3.5A4A45D9@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <38F364B3.5A4A45D9@colorfullife.com>; from Manfred Spraul on Tue, Apr 11, 2000 at 07:45:23PM +0200
Sender: owner-linux-kernel@vger.rutgers.edu

Manfred Spraul wrote:
> Can we ignore the munmap+access case?
> I'd say that if 2 threads race with munmap+access, then the behaviour is
> undefined.
> Tlb flushes are expensive, I'd like to avoid the second tlb flush as in
> Kanoj's patch.

No, you can't ignore it.  A variation called mprotect+access is used by
garbage collection systems that expect to receive SEGVs when access is
to a protected region.

At very least, you'd have to document the race very clearly, and provide
a workaround.

-- Jamie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
