Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbREEJQn>; Sat, 5 May 2001 05:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbREEJQe>; Sat, 5 May 2001 05:16:34 -0400
Received: from smtp.mountain.net ([198.77.1.35]:27396 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S131205AbREEJQU>;
	Sat, 5 May 2001 05:16:20 -0400
Message-ID: <3AF3C4AD.FCC037F0@mountain.net>
Date: Sat, 05 May 2001 05:15:25 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
CC: Seth Goldberg <bergsoft@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Athlon and fast_page_copy: What's it worth ? :)
In-Reply-To: <Pine.LNX.4.10.10105050155020.15185-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> On Fri, 4 May 2001, Seth Goldberg wrote:
> 
> > Hi,
> >
> >   Before I go any further with this investigation, I'd like to get an
> > idea
> > of how much of a performance improvement the K7 fast_page_copy will give
> > me.
> > Can someone suggest the best benchmark to test the speed of this
> > routine?
> 
> Arjan van de Ven did the code, and he wrote a little test harness.
> I've hacked it a bit (http://brain.mcmaster.ca/~hahn/athlon.c);
> on my duron/600, kt133, pc133 cas2, it looks like this:
> 
> clear_page by 'normal_clear_page'        took 7221 cycles (324.6 MB/s)
> clear_page by 'slow_zero_page'           took 7232 cycles (324.1 MB/s)
> clear_page by 'fast_clear_page'          took 6110 cycles (383.6 MB/s)
> clear_page by 'faster_clear_page'        took 2574 cycles (910.6 MB/s)
> 
> copy_page by 'normal_copy_page'  took 7224 cycles (324.4 MB/s)
> copy_page by 'slow_copy_page'    took 7223 cycles (324.5 MB/s)
> copy_page by 'fast_copy_page'    took 4662 cycles (502.7 MB/s)
> copy_page by 'faster_copy'       took 2746 cycles (853.5 MB/s)
> copy_page by 'even_faster'       took 2802 cycles (836.5 MB/s)
> 
> 70% faster!
> 

I've played with this some, too. I find that Arjan's tests are very delicate
about the number of hw interrupts serviced. On UP I see 2-3 interrupts per
page copy on average with my normal workload. On Athlon, interrupts hit 'rep
mov' (looong interruptable vector path insn) much worse than they do mmx
movq (direct path) instructions.

With hands off and no networking, breakeven is about the canonical 512
bytes, and page copy is about 30% better, as Alan says. With ethers up and X
running mmx gets better by comparison -- 40-60% for me. I haven't seen 70%
better, but I'd like to.

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
