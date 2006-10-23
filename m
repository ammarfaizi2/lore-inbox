Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbWJWGlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWJWGlQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWJWGlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:41:16 -0400
Received: from web32403.mail.mud.yahoo.com ([68.142.207.196]:62869 "HELO
	web32403.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751604AbWJWGlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:41:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=X9UG4furSC1JTQfmZR2iN0Fz0QpO7K4bszCc8xnWNCj06qSwnEfz/UBHFcrKJaP3FIi9srLF1e6ksDkaH44MLkh9a7T8ED7SQ3nCsCSxEKHZ4beSvqR6Iy/S1S0F9o3mGMV9nW7m7sSPVd7lNPd89bblLWEQx7eY/D7uYT7tpAU=  ;
Message-ID: <20061023064114.49794.qmail@web32403.mail.mud.yahoo.com>
Date: Sun, 22 Oct 2006 23:41:14 -0700 (PDT)
From: Giridhar Pemmasani <pgiri@yahoo.com>
Subject: Re: incorrect taint of ndiswrapper
To: Chase Venters <chase.venters@clientec.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200610230126.10773.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Chase Venters <chase.venters@clientec.com> wrote:

> On Monday 23 October 2006 00:40, Giridhar Pemmasani wrote:
> > It seems that the kernel module loader taints ndiswrapper module as
> > proprietary, but it is not - it is fully GPL: see
> > http://directory.fsf.org/sysadmin/hookup/ndiswrapper.html
> 
> Indeed. 'ndiswrapper' is intentionally tainted by kernel/module.c because
> it 
> is used to load and run unknown binary / proprietary code in kernel-space.
> If 
> this unknown binary / proprietary code were to contain a bug (which all
> code 
> of that complexity tends to), it might write to memory it doesn't own, or 
> coerce a device to do so on its behalf, making a kernel crash dump analysis
> 
> into a wild goose chase (hence the reason for kernel taint).

Yes, I agree on the purpose of tainting the kernel.

> > Note that when a driver is loaded, ndiswrapper does taint the kernel (to
> be
> > more accurate, it should check if the driver being loaded is GPL or not,
> > but that is not done).
> 
> Are you saying ndiswrapper voluntarily calls add_taint() whenever it loads
> an 
> NDIS driver?

Exactly - the loader within ndiswrapper taints kernel versions 2.6.10 and
newer (older kernels don't have a way of tainting the kernel). The code is in
loader.c in ndiswrapper.

> Are there even any examples of GPL-licensed NDIS drivers?

I don't remember off hand, but sometime back there was discussion on related
topic of weather ndiswrapper should be in debian-main or not, and someone
pointed out a GPL ndis driver. (BTW, after much discussion on debian devel
list, the developers agreed that ndiswrapper belongs in debian-main.)

Giri

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
