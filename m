Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317857AbSGKQhY>; Thu, 11 Jul 2002 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317858AbSGKQhY>; Thu, 11 Jul 2002 12:37:24 -0400
Received: from relay1.pair.com ([209.68.1.20]:29711 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S317857AbSGKQhX>;
	Thu, 11 Jul 2002 12:37:23 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D2DB5F3.3C0EF4A2@kegel.com>
Date: Thu, 11 Jul 2002 09:44:35 -0700
From: dank@kegel.com
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Periodic clock tick considered harmful (was: Re: HZ, preferably as small 
 as possible)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke <mark@mark.mielke.cc> wrote:
> 
> On Wed, Jul 10, 2002 at 04:09:21PM -0600, Cort Dougan wrote:
> > Yes, please do make it a config option.  10x interrupt overhead makes me
> > worry.  It lets users tailor the kernel to their expected load.
> 
> All this talk is getting to me.
> 
> I thought we recently (1 month ago? 2 months ago?) concluded that
> increases in interrupt frequency only affects performance by a very
> small amount, but generates an increase in responsiveness. The only
> real argument against that I have seen, is the 'power conservation'
> argument. The idea was, that the scheduler itself did not execute
> on most interrupts. The clock is updated, and that is about all.

On UML and mainframe Linux, *any* periodic clock tick 
is heavy overhead when you have a large number of 
(mostly idle) instances of Linux running, isn't it?   
I think I once heard those architectures went to great lengths 
to avoid periodic clock ticks.  (My memory is rusty, though.)

How about this: let's apply the high-resolution timer patch,
which adds explicit timer events inbetween the normal 100 Hz
events when needed to satisfy precise sleep requests.  Then
let's increase the interval between the normal periodic clock
events from 10ms to infinity.  Everything will keep working,
as the high-resolution timer patch code will schedule timer
events as needed -- but suddenly we'll have power consumption 
as low as possible, snappier performance, and the thousands-of-instances
case will no longer have this huge drain on performance from
periodic timer events that do nothing but update jiffiers.

OK, so I'm just an ignorant member of the peanut gallery, but
I'd like to hear a real kernel hacker explain why this isn't
the way to go.

- Dan
