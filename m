Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUCIRku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbUCIRku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:40:50 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:1213 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262071AbUCIRkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:40:40 -0500
Message-ID: <404E00B5.5060603@pacbell.net>
Date: Tue, 09 Mar 2004 09:36:53 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Grant Grundler <iod00d@hp.com>, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <20031028013013.GA3991@kroah.com>	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>	<3FA12A2E.4090308@pacbell.net>	<16289.29015.81760.774530@napali.hpl.hp.com>	<16289.55171.278494.17172@napali.hpl.hp.com>	<3FA28C9A.5010608@pacbell.net>	<16457.12968.365287.561596@napali.hpl.hp.com>	<404959A5.6040809@pacbell.net>	<16457.26208.980359.82768@napali.hpl.hp.com>	<4049FE57.2060809@pacbell.net>	<20040308061802.GA25960@cup.hp.com>	<16460.49761.482020.911821@napali.hpl.hp.com>	<404CEA36.2000903@pacbell.net> <16461.35657.188807.501072@napali.hpl.hp.com>
In-Reply-To: <16461.35657.188807.501072@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> How about something along the following lines?  The patch is relative
> to 2.6.4-rc1.  What it does is add a new state ED_DESCHEDULED, which
> is treated exactly like ED_IDLE, except that in this state, the HC may
> still be referring to the ED in question.  Thus, if

Sounds exactly like ED_UNLINK -- except maybe that it's not
been put onto ed_rm_list (with ED_DEQUEUE set).

Why add another state?


The parts of this patch that came from the one I sent earlier
are obviously correct (what were your test results for that?),
and there's non-worrisome noise (printks etc).

But some parts worry me.  Like changing that code to BUG()
on a driver behavior that's perfectly reasonable; and removing
some of the PCI posting, which makes it easier for the HC
and its driver to disagree about schedule status.


> The BTC keyboard, however, still does NOT work.  I'm fairly certain
> now that this is indeed a separate problem in the HID.  The reason

That was my original suspicion, you may recall ... :)

- Dave

