Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131206AbRCRLxg>; Sun, 18 Mar 2001 06:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131209AbRCRLx2>; Sun, 18 Mar 2001 06:53:28 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29070 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131206AbRCRLxV>;
	Sun, 18 Mar 2001 06:53:21 -0500
Message-ID: <3AB4A162.17FD434A@mandrakesoft.com>
Date: Sun, 18 Mar 2001 06:52:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 28 potential interrupt errors
In-Reply-To: <Pine.GSO.4.31.0103162216360.10409-100000@elaine24.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang wrote:
> [BUG] error path
> 
> /u2/acc/oses/linux/2.4.1/drivers/net/appletalk/cops.c:776:cops_rx: ERROR:INTR:763:804: Interrupts inconsistent, severity `20':804

Fixed.

Request:  can the checker check for skb's being freed correctly?  The
rules:

If an skb is in interrupt context, call dev_kfree_skb_irq.
If an skb might be in interrupt context, call dev_kfree_skb_any.
If an skb is not in interrupt context, call dev_kfree_skb.

I also found and fixed an error of this sort on cops.c as well.

> [BUG] error path. this bug is interesting
> 
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/wavelan_cs.c:2561:wavelan_get_wireless_stats: ERROR:INTR:2528:2561: Interrupts inconsistent, severity `20':2561
> 
>   /* Disable interrupts & save flags */
> Start --->
>   spin_lock_irqsave (&lp->lock, flags);
> 
>   if(lp == (net_local *) NULL)
>     return (iw_stats *) NULL;

Fixed.

I dunno WTF the programmer was thinking here...  Your de-ref checker
should have caught this too:  check 'lp' for NULL after de-referencing
lp->lock.

> [BUG] error path
> 
> /u2/acc/oses/linux/2.4.1/drivers/net/tokenring/smctr.c:3655:smctr_open_tr: ERROR:INTR:3594:3661: Interrupts inconsistent, severity `20':3661

Seems to be fixed already.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
