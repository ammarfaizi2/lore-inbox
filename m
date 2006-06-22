Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751782AbWFVMrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWFVMrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 08:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWFVMrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 08:47:03 -0400
Received: from web33314.mail.mud.yahoo.com ([68.142.206.129]:29108 "HELO
	web33314.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751782AbWFVMrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 08:47:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ucdLxYUVnqS1HQ1VtbUcuI3Q+z7JvTKxOlufYtvfZVRE36b4/QtL1w/mxbeykfyMVV83GxtOQ7JiVLgWyeMtXzTPo7U+WBpS2p+L342dwu0NfHWpimeKQG0rUSWVvYrMgL04L1Hfq94T4IPuI7i7buM5JvMELOxm7MggqVscHdU=  ;
Message-ID: <20060622124700.4700.qmail@web33314.mail.mud.yahoo.com>
Date: Thu, 22 Jun 2006 05:47:00 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Dropping Packets in 2.6.17
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1150977316.3120.26.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Arjan van de Ven <arjan@infradead.org> wrote:

> On Thu, 2006-06-22 at 04:31 -0700, Danial Thom
> wrote:
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
> Hi Danial,
> 
> the most likely tunable that will help you is
> 
> /proc/sys/vm/min_free_kbytes
> 
> For the router kind of device that one usually
> needs bumping a bit;
> without the bumping the VM doesn't see enough
> "normal" activity to tune
> it's emergency/interrupt handling buffers (and
> most networking
> allocations happen in interrupt context), and
> then ends up failing
> allocations in interrupt context, which leads
> to dropped packets.

I don't think thats the problem, as I've tracked
the problem to packets being dropped because of
excessive backlog (ie, they are being dropped
gracefully). However with a backlog of 20000, and
a traffic level of about 75,000pps, that means
almost 1/3 of a second that the system doesn't
process packets, which is just unacceptable.

I'll try changing the setting, but running out of
memory doesn't seem to be the issue. I think what
I need is some mechanism to make interrupts a
priority, like it was back in the days when
networking was more important then mp3 playback.

Danial

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
