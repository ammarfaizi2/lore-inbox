Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280763AbRKKBBi>; Sat, 10 Nov 2001 20:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280764AbRKKBBS>; Sat, 10 Nov 2001 20:01:18 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:20522 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280763AbRKKBBR>; Sat, 10 Nov 2001 20:01:17 -0500
Date: Sat, 10 Nov 2001 20:01:13 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Anton Blanchard <anton@samba.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        "David S. Miller" <davem@redhat.com>, jakub@redhat.com,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 2 of the tr-based current
Message-ID: <20011110200113.I17437@redhat.com>
In-Reply-To: <20011108211143.A4797@redhat.com> <20011109041327.T4087@devserv.devel.redhat.com> <3BEBEE0B.BA1FD7EE@colorfullife.com> <20011109.070312.88700201.davem@redhat.com> <3BEBF730.86CAE1CC@colorfullife.com> <20011111110107.A4064@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011111110107.A4064@krispykreme>; from anton@samba.org on Sun, Nov 11, 2001 at 11:01:08AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 11:01:08AM +1100, Anton Blanchard wrote:
> static inline struct Paca *get_paca(void) __attribute__ ((pure));
> static inline struct Paca *get_paca(void)
> {
> 	struct Paca *rval;
> 	__asm__ ("mfspr %0,0x113" : "=r" (rval));
> 	return rval;
> }
> 
> Alan Modra came to the rescue and found that gcc was optimising too much
> and since the function did not touch any global variables, it would
> upgrade the pure to const. This was on gcc 3.0.X.

Hmmm.  Would adding a fake global input help with that?  Something like a 
"g" (aligned_data) input.

		-ben
-- 
Fish.
