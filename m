Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbUCIUnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUCIUnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:43:04 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:50602 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261427AbUCIUm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:42:58 -0500
Message-ID: <404E2B98.6080901@pacbell.net>
Date: Tue, 09 Mar 2004 12:39:52 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Grant Grundler <iod00d@hp.com>, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <20031028013013.GA3991@kroah.com>	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>	<3FA12A2E.4090308@pacbell.net>	<16289.29015.81760.774530@napali.hpl.hp.com>	<16289.55171.278494.17172@napali.hpl.hp.com>	<3FA28C9A.5010608@pacbell.net>	<16457.12968.365287.561596@napali.hpl.hp.com>	<404959A5.6040809@pacbell.net>	<16457.26208.980359.82768@napali.hpl.hp.com>	<4049FE57.2060809@pacbell.net>	<20040308061802.GA25960@cup.hp.com>	<16460.49761.482020.911821@napali.hpl.hp.com>	<404CEA36.2000903@pacbell.net>	<16461.35657.188807.501072@napali.hpl.hp.com>	<404E00B5.5060603@pacbell.net> <16462.1463.686711.622754@napali.hpl.hp.com>
In-Reply-To: <16462.1463.686711.622754@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> 
>   > David Mosberger wrote:
>   >> ...  add a new state
>   >> ED_DESCHEDULED, which is treated exactly like ED_IDLE, except
>   >> that in this state, the HC may still be referring to the ED in
>   >> question.  Thus, if
> 
>   David.B> Sounds exactly like ED_UNLINK -- except maybe that it's not
>   David.B> been put onto ed_rm_list (with ED_DEQUEUE set).
>   David.B> Why add another state?
> 
> So you can tell them apart.  See ohci_endpoint_disable().

Not informative.  Why doesn't UNLINK work as-is?
If there's a bug in how that's handled, better to fix it.
I'd be willing to believe there is one, given proof.


> You seem to think small races are OK.  I disagree.  The smaller the

I certainly didn't say that, any more than you said
that there's no such thing as an engineering tradeoff!

(With which statement I'd likewise disagree.)

But I certainly did mean to say that I was skeptical
you were actually running into one particular race,
which I've had an eye on for some time.  (And which
shouldn't have the failure mode you reported, though
some other things might...)


>   David.B> But some parts worry me.  Like changing that code to BUG()
>   David.B> on a driver behavior that's perfectly reasonable;
> 
> With my patch, the only reason you enter ED_UNLINK state is
> ohci_endpoint_disable().  If you try to ohci_urb_enqueue() on an ED in
> this state, it will fail, so I don't there is a problem (I see now

It's entered in usb_unlink_urb() as always.  So as I
noted, your patch would make drivers BUG() in cases
that are perfectly reasonable according to the API.


> that I forgot to set the error-code for this case, that's obviously
> something that needs to be fixed).  But perhaps you had different
> semantics in mind for ED_UNLINK?

As I've said more than once on this thread.

- Dave

