Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUAMFBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 00:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUAMFBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 00:01:44 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:40430 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S263697AbUAMFBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 00:01:42 -0500
Date: Tue, 13 Jan 2004 00:09:55 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Piotr Kaczuba <pepe@attika.ath.cx>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: tulip driver: errors instead TX packets?
Message-ID: <20040113000955.A15596@mail.kroptech.com>
References: <20040110144831.GA16080@orbiter.attika.ath.cx> <400035F5.3040300@pobox.com> <4000607D.1020102@attika.ath.cx> <20040110222038.A4817@mail.kroptech.com> <40013E83.6070108@attika.ath.cx> <20040111122736.A16869@mail.kroptech.com> <40031B3C.1090602@attika.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40031B3C.1090602@attika.ath.cx>; from pepe@attika.ath.cx on Mon, Jan 12, 2004 at 11:10:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 11:10:04PM +0100, Piotr Kaczuba wrote:
> Adam Kropelin wrote:
> > On Sun, Jan 11, 2004 at 01:16:03PM +0100, Piotr Kaczuba wrote:
> > 
> >>Here is the output of dmesg after setting TULIP_DEBUG to 4 and starting 
> >>pppd (eth0 is used by PPPoE). I agree that the code looks okay but 
> > 
> > <snip>
> > 
> >>eth0: Transmit error, Tx status 1a078c80.
> > 
> > 
> > That would be heartbeat failure, no carrier, and loss of carrier. It's
> > interesting that you seem to be able to get valid packets on the wire
> > because the latter two errors are usually quite fatal. I suspect either
> > the Comet is just buggy and those error bits aren't to be trusted or
> > there is something wrong with the PHY config. I don't have docs on the
> > Comet PHY so there's not much I can do.
> > 
> > On whim, does the patch below change anything for you?

<snip patch that disables SQE test>

> Unfortunately, not. The errors are still there, but the status code has 
> changed. Below is an excerpt from kern.log after applying the patch.

<snip>

> Jan 12 21:35:09 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.

Yep...we told it to disable the SQE test so the heartbeat error no
longer appears. The carrier errors are still present, though. This
definitely smells like a configuration problem, but without docs and a
card to test with there's not much else I can do. I'll poke thru the
code and see if anything else leaps out at me.  If anybody out there
has Comet docs or a NIC that exhibits this problem they'd be willing to
loan I'll take a deeper look.

--Adam

