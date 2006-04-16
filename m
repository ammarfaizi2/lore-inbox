Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWDPOTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWDPOTz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 10:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWDPOTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 10:19:55 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:35560 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750729AbWDPOTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 10:19:54 -0400
Date: Sun, 16 Apr 2006 18:19:47 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Libor Vanek <libor.vanek@gmail.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
Message-ID: <20060416141947.GA16818@2ka.mipt.ru>
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com> <20060414192634.697cd2e3.rdunlap@xenotime.net> <1145070437.28705.73.camel@stark> <20060415091801.GA4782@2ka.mipt.ru> <369a7ef40604160426s301dcd52r4c9826698d3d2f79@mail.gmail.com> <20060416114017.GA30180@2ka.mipt.ru> <369a7ef40604160509xcf2caadi782b90da956639d5@mail.gmail.com> <20060416132515.GA25602@2ka.mipt.ru> <369a7ef40604160632t16f6aab9u687a6b359997d7ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <369a7ef40604160632t16f6aab9u687a6b359997d7ea@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 16 Apr 2006 18:19:48 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2006 at 03:32:02PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:

> It's really strange... Maybe when I'm trying to send from kernel
> module to user space and kernel moduele is registred with same group
> ID, then it's taken as listener (even when it's not delivered in the
> end...). Maybe I should have one group ID for user => kernel and
> different ID for kernel => user messages?

Message should be received only when it is sent to the same group as
specified at bind(subscribe actually) time, 
I need to investigate this strange issue more
deeply. Current symptom is that netlink messages are delivered  to any
group which process is bound to no matter which one is specified in
netlink header (tested with userspace socket subscribed to group 17, and
kernel sets group number to 1,3,4,5,17 if group number is set to 2 or more
than 5 message is not delivered as expected).

Btw, you need to not only bind to specified group but also to subscribe
to it. This step is described in Documentation/connector/ and requires
one setsockopt call.

> Libor Vanek

-- 
	Evgeniy Polyakov
