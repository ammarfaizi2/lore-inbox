Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWFVPD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWFVPD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWFVPD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:03:59 -0400
Received: from web33302.mail.mud.yahoo.com ([68.142.206.117]:59261 "HELO
	web33302.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751813AbWFVPD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:03:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vzL4/Lj7mSUnBQWSl/YP/CglS5jN6YlrPgkYncY7cV2tDKHPW1CwPF7Dj54Q+AlLSIzx5089pQPp/keYwrsIh7T6A8BnwvzTa2PTVjOWYyzAXAelKP7FpQV10Vpq/X0tbseEawFnKDjSAQoiiOWCWT1V7xeQdAY2m6iKXh8nGZs=  ;
Message-ID: <20060622150357.37194.qmail@web33302.mail.mud.yahoo.com>
Date: Thu, 22 Jun 2006 08:03:57 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Dropping Packets in 2.6.17
To: =?ISO-8859-1?Q?=20=22P=E1draig=22?= Brady <P@draigBrady.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <449A9ADC.9070800@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Pádraig Brady <P@draigBrady.com> wrote:

> Danial Thom wrote:
> > I'm trying to make a case for using linux as
> a
> > network appliance, but I can't find any
> > combination of settings that will keep it
> from
> > dropping packets at an unacceptably high
> rate.
> > The test system is a 1.8Ghz Opteron with
> intel
> > gigE cards running 2.6.17. I'm passing about
> 70K
> > pps through the box, which is a light load,
> but
> > userland activities (such as building a
> kernel)
> > cause it to lose packets, even with backlog
> set
> > to 20000. I had the same problem with 2.6.12
> and
> > abandoned the effort. Has anything been done
> > since to give priority to networking? You
> can't
> > have a network appliance drop packets when
> some
> > application is gathering stats or a user is
> > looking at a graph. What tunings are
> available?
> 
> For reference with 2.4.20 on a dual 3.4GHz xeon
> and 2 x e1000 cards, I was able to capture,
> classify
> and do sophisticated statistical calculations
> on
> 625Kpps per interface (1.3 million packets per
> second).
> The bottleneck at this point was memory
> bandwidth.
> Allowing some drops the average rate went up to
> the
> PCI bottleneck of about 850kpps/port.
> Classification and Computation was done in
> userspace.
> 
> Note there is a max interrupt rate of around
> 80K/s
> on x86 at least (not sure about opteron), so
> make
> sure you're using NAPI. /proc/interrupts will
> show your interrupt rate.
> 
> If the packets go to userspace, make sure
> you're using
> CONFIG_PACKET_MMAP

Unfortunately I can do that much with FreeBSD 4.x
with 1 2.0Ghz opteron, so its not a very
compelling case to have to spend twice as much on
hardware to use LINUX. However 2.4 seemed much
better than 2.6 in this regard. 2.6 wants to drop
a lot more packets. The goal of using 2.6 is to
utilize DP better, but it obviously has to
perform better than a UP Freebsd box.

What ITR setting are using for the e1000 driver?

># Lots of kernel memory needed for e1000 
>vm.min_free_kbytes = 65535 

I'm curious as to why a vm setting is useful, as
it doesn't seem that the e1000 driver uses
virtual memory? Since rings are replenished with
sk_buffs, and sk_buffs have to be contiguous, how
does vm come into play?

DT


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
