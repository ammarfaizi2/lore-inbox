Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVGONM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVGONM5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 09:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVGONM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 09:12:57 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:12655 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261358AbVGONM4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 09:12:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IyH1d7C3YWB+Mazsy2SsgJDPA0GFo23NaLgwbOjnKnQl1DiMsd9HH6XfRAzSUWOCvn1PeAg+4putWK8y1a5CTkIc8COAgipJRA1o1cEOtbQE8YK1nZpXiCCli/UXnET82iRu90ByfSxpoKaEgrK7A8jNQsBRixCLXhRh0i4Y9MQ=
Message-ID: <9a874849050715061247ab4fd8@mail.gmail.com>
Date: Fri, 15 Jul 2005 15:12:51 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Cc: Lee Revell <rlrevell@joe-job.com>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507142158010.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42D3E852.5060704@mvista.com>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe>
	 <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
	 <1121386505.4535.98.camel@mindpipe>
	 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
	 <42D731A4.40504@gmail.com>
	 <Pine.LNX.4.58.0507142158010.19183@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> On Fri, 15 Jul 2005, Jesper Juhl wrote:
> >
> > It's buggy, that I know. setting kernel_hz (the new boot parameter) to
> > 250 causes my system clock to run at something like 4-5 times normal
> > speed
> 
> 4 times normal. You don't actually make the timer interrupt happen at
> 250Hz, so the timer will be programmed to run at the full 1kHz.
> 
Right, that's the basic problem. I increase jiffies at a higher rate
but didn't slow the timer interrupt down at the same time.

> You also need to actually change the LATCH define (in
> include/linux/jiffies.h) to take this into account (there might be
> something else too).
> 
[...]
> and you might be getting closer.
> 
> Of course, you need to make sure that LATCH is used only after
> jiffies_increment is set up. See "setup_pit_timer(void)" in
> arch/i386/kernel/timers/timer_pit.c for more details.
> 

Thank you for all the pointers and hints. This is a new area of code
for me, so I'll need some time to poke around - the above helps a lot.
Unfortunately I won't have any time to work on this today, but I'll
see if I can get a working implementation together tomorrow.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
