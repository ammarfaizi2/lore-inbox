Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVFJI3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVFJI3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 04:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVFJI3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 04:29:36 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30378
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262517AbVFJI3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 04:29:34 -0400
Subject: Re: RT and timers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mvista.com
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <42A8EE8C.1010406@mvista.com>
References: <Pine.LNX.4.44.0506091639380.11001-100000@dhcp153.mvista.com>
	 <42A8EE8C.1010406@mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 10 Jun 2005 10:30:31 +0200
Message-Id: <1118392231.13312.53.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 18:36 -0700, George Anzinger wrote:
> > I'm mainly concerned because that loop never breaks . It seems like there 
> > could be a condition when the loop never stops. For instance , a very 
> > accurate timer interrupt, and timers that continually reset themselves.
> 
> As I recall, it is not possible to put a timer in the list for the current time. 
>   It will be put in the next tick slot or, with HRT, be passed to the hrt code. 
>   The only case this might fail is if a kernel hrt user restarts his timer for 
> "now" or prior to "now".  This is bad and hard to correct.  The posix-timers 
> code does not restart timers until the signal is delivered and then from the 
> user thread, not the softirq context.
> 
> Did I miss something here?

No, you're right. Expired timers are inserted into the next slot, so the
loop is not able to starve itself.


tglx


