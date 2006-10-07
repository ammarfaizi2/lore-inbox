Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932896AbWJHAD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbWJHAD3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 20:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932899AbWJHAD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 20:03:29 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:13960 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932896AbWJHAD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 20:03:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:References:In-Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=dK3peuBlid1GnbFMlf3mJBWs+9lfLD8MRLvr5OaA91KExY2CvF0SNlF/7gwIxIZeWcVwRb2f+9GXYfuH4fNb4SNnF+Kyez9hABKZNCMpnWoBYWb73wPzYsUclK3N5HiOq8PR9IBxHIO7ut/gRTmtjjAc0Eige49gde7LM5FQxT0=  ;
From: David Brownell <david-b@pacbell.net>
To: "Andrea Paterniani" <a.paterniani@swapp-eng.it>
Subject: Re: [patch 2.6.18-git] SPI -- Freescale iMX SPI controller driver
Date: Sat, 7 Oct 2006 16:50:04 -0700
User-Agent: KMail/1.7.1
References: <FLEPLOLKEPNLMHOILNHPAEODCMAA.a.paterniani@swapp-eng.it>
In-Reply-To: <FLEPLOLKEPNLMHOILNHPAEODCMAA.a.paterniani@swapp-eng.it>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610071650.04887.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 October 2006 4:01 am, you wrote:
> > > > ...
> > > > ug.  Why not simply open-code
> > > >
> > > > 	readl(addr + DATA);
> > ...
> 
> What you're saying is clear.
> But I'm a little bit confused...what about the lot of definitions
> that use __REG or __REG2 macros to define registers address 
> (inside imx-regs.h, pxa-regs.h and so on) ?

There are two conventions; accessing chip registers like globals
(matching chip documentation) is a second convention.  The __REG32
style accessors can generate better code in many cases, too.

Thing is, you shouldn't create a third convention.


> > > > The use of loops_per_jiffy seems inappropriate.  That's an IO-space read in
> > > > there, which is slow.  This timeout will be very long indeed.
> > >
> > > Please suggest me what it's more appropriate.
> >
> > Pick a constant, use it.
> 
> How should I choose the value of that costant ?

You could pick the value of loops_per_jiffy at HZ=1000,
for one example.  You're using that limit to avoid
spinning too long with IRQs blocked, so you basically
just need a loop count which, if it's exceeded, will
pretty clearly indicate a hardware bug.

- Dave

