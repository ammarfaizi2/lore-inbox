Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbWFVXhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWFVXhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWFVXhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:37:45 -0400
Received: from web33314.mail.mud.yahoo.com ([68.142.206.129]:11109 "HELO
	web33314.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932672AbWFVXhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:37:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aHD4sAXpqyfRWrzw0oTIvJeYjtmMen1nKXP2rZiVUKLfMhYTIpuFkmgjyc1U8TghcfCOoObbOjo+Pu0qttOM/EVusdm9DijrzYl3H+oqbiUs31ajEXil4hZJJUVX7txn+SzNobanJst77rBodf4svLb62SShs0/ZSa7e9YdexF8=  ;
Message-ID: <20060622233744.99206.qmail@web33314.mail.mud.yahoo.com>
Date: Thu, 22 Jun 2006 16:37:44 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Measuring tools - top and interrupts
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060622173128.GD14682@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Erik Mouw <erik@harddisk-recovery.com> wrote:

> On Thu, Jun 22, 2006 at 09:58:08AM -0700,
> Danial Thom wrote:
> > --- Erik Mouw <erik@harddisk-recovery.com>
> wrote:
> > > 75K packets/s isn't too hard for modern
> NICs,
> > > especially when using
> > > NAPI.
> > 
> > Well thats just a ridiculous answer, so why
> > bother? 
> > 
> > You polling guys just crack me up. There
> isn't
> > much less work to be done with polling. The
> only
> > reason you THINK its less work is because the
> > measuring tools don't work properly. You
> still
> > have to process the same number of packets
> when
> > you poll, and you have polls instead of
> > interrupts. Since you can control the # of
> > interrupts with most cards, there is zero
> > advantage to polling, and more negatives.
> 
> There certainly is less work to be done with
> polling. Less IRQs means
> less expensive context switches, which means a
> lower system load. See
> Documentation/NAPI_HOWTO.txt for information
> and a link to the Linux
> NAPI paper.
> 
> > And 75K pps may not be "much", but its still
> at
> > least 10% of what the system can handle, so
> it
> > should measure around a 10% load. 2.4
> measures
> > about 12% load. So the only conclusion is
> that
> > load accounting is broken in 2.6.
> 
> Network traffic is usually IO bound, not CPU
> bound. The load figures
> top shows tell something about the amount of
> work the CPU has to do,
> not about how busy your PCI bus (or whatever
> bus the NIC lives on) is.
> 
> IIRC the networking layer in 2.6 differs quite
> a lot from 2.4, so the
> load average figures can be quite misleading.

I'm sorry, but you're being an idiot if you think
that 16K interrupts per second and forwarding 75K
pps generate no cpu load. Its just that simple.
It also means that you've never profiled a kernel
because you don't understand where the loads are
generated. You've probably been on too many lists
with too many people who have no idea what
they're talking about.

The NAPI paper is complete rubbish because its
based on a principle which no longer exists: that
is the assumption that you'll get an interrupt
for every packet. Not only is that hardly ever
the case, modern controllers (such as Intel's
GigE controllers) can precisely mitigate the
interrupts in hardware. You *could* tune this on
the fly, but there is really no reason to,
because at low interrupt loads cpu overhead is
not a concern and lower latencies are preferred.
You'll never get an interrupt for consecutive
packets, and since packets usually arrive in
bursts, the mitigation model works even better
than if they arrived randomly.

With simple tuning the controller is more
efficient with hardware interrupts. None of the
arguments in the NAPI paper hold true when using
a modern GigE controller. 

Of course you folks could never really know that,
because the tools to measure things don't work,
and you all seem to be using systems that are so
kludged up that you don't even know what you're
measuring.

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
