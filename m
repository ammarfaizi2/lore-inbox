Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263159AbSJGWsq>; Mon, 7 Oct 2002 18:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbSJGWsq>; Mon, 7 Oct 2002 18:48:46 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:10283 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S263159AbSJGWsn>; Mon, 7 Oct 2002 18:48:43 -0400
Date: Tue, 8 Oct 2002 00:52:06 +0200 (CEST)
From: Rui Sousa <rui.sousa@laposte.net>
X-X-Sender: rsousa@localhost.localdomain
To: Amol Lad <dal_loma@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: wake_up from interrupt handler
In-Reply-To: <20021007124121.37417.qmail@web12407.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0210080048210.1714-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Amol Lad wrote:

> Hi,
>  I have a kernel thread which did add_to_wait_queue()
> to wait for an event. 
> The event for which above thread is waiting occurs in
> an interrupt handler that calls wake_up() to wake the
> above thread. 
> Now I am faced with a 'lost wakeup' problem, in which
> the    
> kernel thread checks whether event occured, he finds
> it to be 'not-occured' but before calling
> add_to_wait_queue(), interrupt handler detects that
> the event has occured and calls wake_up().
> My thread sleeps forever.

I believe the solution is to simply add_to_wait_queue()
_before_ checking the condition. If the signal arrives between
checking the condition and going to sleep your task will be
immediately awoken.

Rui Sousa

> I know some new APIs are provided in recent 2.5
> kernel, but how to avoid this in 2.4.18
>
> please CC me 
> 
> Thanks
> Amol
> 
> 
> __________________________________________________
> Do you Yahoo!?
> Faith Hill - Exclusive Performances, Videos & More
> http://faith.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

