Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131165AbRAQAFu>; Tue, 16 Jan 2001 19:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbRAQAFa>; Tue, 16 Jan 2001 19:05:30 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:27411 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S130663AbRAQAF2>;
	Tue, 16 Jan 2001 19:05:28 -0500
Date: Tue, 16 Jan 2001 16:05:38 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: console spin_lock
Message-ID: <Pine.LNX.4.21.0101161554550.450-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some time ago a intel i810 framebuffer driver was written. It only worked
for 2.2.X. With 2.4.X a spinlock is used in the upper layers of the
console system. Sooner or later we are going to run into the situtation
where we will have graphics hardware which has no vga core and wih be
purely DMA/irq based (i.e i810). In this case using the current
console_lock will block the driver itself. I have thought about a
possible solution. A semaphore can't be used since their is a spin_lock 
in the console_softirq. Since this is in a interrupt context a
semaphore can't be used. Another idea was to do a 

void get_vc_lock(void)
{
        while (test_and_set_bit(0, &vc_var))
                ;
}

Any better ideas?





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
