Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVGGJra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVGGJra (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 05:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVGGJr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 05:47:29 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:27800 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261262AbVGGJqk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 05:46:40 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Thu, 7 Jul 2005 10:46:41 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507062047.26855.s0348365@sms.ed.ac.uk> <20050706204429.GA1159@elte.hu>
In-Reply-To: <20050706204429.GA1159@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071046.41938.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jul 2005 21:44, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > here's an updated patch - it will print out all timestamps too. (you'll
> > > have to revert all previous softlockup patches first, via patch -R.)
> >
> > Yep, thanks, that fixed it. I don't know why it only shows up on my
> > configuration, but it was a bug, and this patch fixes it. I also took
> > the liberty of upgrading to -06 while I was doing it, so I think you
> > can probably release -07 with the specified changes.
>
> great.
>
> > So far no lockups, either, but I'm not convinced they're gone forever.
> > I'll let you know how it goes.
>
> the ACPI-idle bug's primary effects were the missed wakeups, but they
> should not cause lockups, because timer interrupts should always occur
> and should eventually 'fix up' such missed wakeups.

Okay, when I brought my laptop back into work today for audio work, it locked 
up again within two minutes. I realise now what the problem is, but I don't 
have a serial cable here, so I'll have to rely on capturing the oops from the 
console.

The only difference between work and home is that I connect over an OpenVPN 
connection at work, which is a userspace program that creates a "tun" device 
as a virtual network adaptor.

I'm convinced this is the problem, because I enabled IPMASQ on the company 
server today and bypassed the VPN, and I'm happily typing this email from the 
same computer on the same network, just with no VPN started.

It's a bizarre problem, but my guess is that your user test bed don't end up 
using tap/tun very often, which means it's poorly tested.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
