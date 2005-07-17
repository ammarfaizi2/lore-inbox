Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVGQCfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVGQCfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 22:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVGQCf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 22:35:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29113 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261729AbVGQCf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 22:35:27 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <9a874849050716191324d2f8b4@mail.gmail.com>
References: <42D3E852.5060704@mvista.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
	 <1121386505.4535.98.camel@mindpipe>
	 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org> <42D731A4.40504@gmail.com>
	 <Pine.LNX.4.58.0507142158010.19183@g5.osdl.org>
	 <9a874849050715061247ab4fd8@mail.gmail.com>
	 <9a874849050716191324d2f8b4@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 22:35:24 -0400
Message-Id: <1121567725.13990.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-17 at 04:13 +0200, Jesper Juhl wrote:
> Where do we actually program the tick rate we want?
> 

In arch/i386/kernel/timers/timer_pit.c:

    166 void setup_pit_timer(void)
    167 {
    168         unsigned long flags;
    169 
    170         spin_lock_irqsave(&i8253_lock, flags);
    171         outb_p(0x34,PIT_MODE);          /* binary, mode 2, LSB/MSB, ch 0 */
    172         udelay(10);
    173         outb_p(LATCH & 0xff , PIT_CH0); /* LSB */
    174         udelay(10);
    175         outb(LATCH >> 8 , PIT_CH0);     /* MSB */
    176         spin_unlock_irqrestore(&i8253_lock, flags);
    177 }
    178 

Lee

