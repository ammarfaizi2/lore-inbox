Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280775AbRKKCar>; Sat, 10 Nov 2001 21:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280777AbRKKCai>; Sat, 10 Nov 2001 21:30:38 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:7953 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280775AbRKKCa3>;
	Sat, 10 Nov 2001 21:30:29 -0500
Date: Sun, 11 Nov 2001 13:27:28 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        "David S. Miller" <davem@redhat.com>, jakub@redhat.com,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 2 of the tr-based current
Message-ID: <20011111132727.A4793@krispykreme>
In-Reply-To: <20011108211143.A4797@redhat.com> <20011109041327.T4087@devserv.devel.redhat.com> <3BEBEE0B.BA1FD7EE@colorfullife.com> <20011109.070312.88700201.davem@redhat.com> <3BEBF730.86CAE1CC@colorfullife.com> <20011111110107.A4064@krispykreme> <20011110200113.I17437@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011110200113.I17437@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Hmmm.  Would adding a fake global input help with that?  Something like a 
> "g" (aligned_data) input.

Yep thats what Alan ended up doing, it needed a dummy memory constraint
to prevent gcc over optimising:

        __asm__ ("mfspr %0,0x113; #%1"
	: "=r" (rval)
	: "m" ((int *) 0));

Anton
