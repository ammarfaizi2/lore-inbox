Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbULNQ7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbULNQ7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbULNQ5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:57:48 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:33558 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261560AbULNQ4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:56:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=W/zqM0AtN8FRBgZoMaLWM7dhT0722Oe6G9k0BSXH33baR18MrEDNTdovXPq8A3BevOZG320/1Mk9kdixLF+FtxRjjB41BCEeyieAMioSEEkCHKivVSnPXmkoTvx7aJ6J8zfv2FIL3aofmY0z05Xz/ASPYLOPi1Yj+kwlVxhY44g=
Message-ID: <29495f1d04121408567a144fc6@mail.gmail.com>
Date: Tue, 14 Dec 2004 08:56:12 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Domen Puncer <domen@coderock.org>
Subject: Re: dynamic-hz
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       kernel@kolivas.org, pavel@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20041214100123.GD6569@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random>
	 <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org>
	 <20041213111741.GR16322@dualathlon.random>
	 <20041213032521.702efe2f.akpm@osdl.org>
	 <29495f1d041213195451677dab@mail.gmail.com>
	 <20041214100123.GD6569@nd47.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004 11:01:23 +0100, Domen Puncer <domen@coderock.org> wrote:
> On 13/12/04 19:54 -0800, Nish Aravamudan wrote:
> > On Mon, 13 Dec 2004 03:25:21 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > > Andrea Arcangeli <andrea@suse.de> wrote:
> > > >
> > > > The patch only does HZ at dynamic time. But of course it's absolutely
> > > >  trivial to define it at compile time, it's probably a 3 liner on top of
> > > >  my current patch ;). However personally I don't think the three liner
> > > >  will worth the few seconds more spent configuring the kernel ;).
> > >
> > > We still have 1000-odd places which do things like
> > >
> > >         schedule_timeout(HZ/10);
> > 
> ...
> > Many drivers use
> >
> > set_current_state(TASK_{UN,}INTERRUPTIBLE);
> > schedule_timeout(1); // or some other small value < 10
> > 
> ...
> > If they really meant to use schedule_timeout(1) in the sense of
> > highest resolution delay possible (the latter above), then they
> > probably should just call schedule() directly.
> 
> Um... no (and you should remember this from our discussions), schedule()
> gives up cpu until waitqueue wakeup or signal is received, and that can
> be a really long delay :-)

True; sorry about that, Domen, completely forgot about that. Will
think on it further.

-Nish
