Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266913AbUBEWIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266943AbUBEWIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:08:04 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:26245 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266913AbUBEWH7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:07:59 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Thu, 5 Feb 2004 19:08:21 +0000
User-Agent: KMail/1.6
References: <200402041820.39742.wnelsonjr@comcast.net> <200402051517.37466.murilo_pontes@yahoo.com.br> <20040205203840.GA13114@ucw.cz>
In-Reply-To: <20040205203840.GA13114@ucw.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402051908.22071.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui 05 Fev 2004 20:59, você escreveu:
> The exception seems to be coming from
> linux-2.6.2/drivers/input/mouse/psmouse-base.c, specifically from
> 
> if (psmouse->state == PSMOUSE_ACTIVATED &&
>             psmouse->pktcnt && time_after(jiffies, psmouse->last +
> HZ/2)) {
>                 printk(KERN_WARNING "psmouse.c: %s at %s lost
> synchronization, throwing %d bytes away.\n",
>                        psmouse->name, psmouse->phys, psmouse->pktcnt);
>                 psmouse->pktcnt = 0;
>         }
> 
> 
> where (for me) HZ is 1804768000, and therefore HZ/2 is 902384000,  
> psmouse->pktcnt is 3, and (I assume) PSMOUSE_ACTIVATED is non-0 after
> boot.  I assume that pktcnt is fed by interrupt, and the problem then is
> that psmouse->last + HZ/2 blows past the jiffies value, causing the
> warning message to be issued.  When mouse service finally comes back,
> pktcnt is non-zero (and possibly whatever the maximum is that it will
> hold), and when it flushes, the mouse pointer goes nuts for a second. 
> The real problem then, is why does the sum of ps->last + HZ/2 grow to
> beyond the size of jiffies (or what is delaying the mouse service)?
> 
> This is just a rough guesstimate of what is going on, but seems to fit
> the facts.   Cheers!
> 
> Bob
Always in heavy load(like c++ compiling, high volume of VM operations),
kernel jiffies are more large or short delay....

Bug is solved?
I am open to receive patchs for test! 
Please send when avaliable! 

Thanks







