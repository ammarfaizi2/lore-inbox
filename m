Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbUCRMDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbUCRMDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:03:21 -0500
Received: from h42n2fls34o811.telia.com ([217.208.99.42]:36405 "EHLO dmac")
	by vger.kernel.org with ESMTP id S262551AbUCRMDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:03:12 -0500
Date: Thu, 18 Mar 2004 13:03:11 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linux-kernel@vger.kernel.org, Micha? Roszka <michal@roszka.pl>
Subject: Re: [.config] CONFIG_THERM_WINDTUNNEL
Message-ID: <20040318120311.GD3686@ibrium.se>
Mail-Followup-To: Giuliano Pochini <pochini@denise.shiny.it>,
	linux-kernel@vger.kernel.org, Micha? Roszka <michal@roszka.pl>
References: <200403180821.44199.michal@roszka.pl> <Pine.LNX.4.58.0403181012300.29633@denise.shiny.it> <20040318112057.GC3686@ibrium.se> <Pine.LNX.4.58.0403181221580.1392@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403181221580.1392@denise.shiny.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:27:28PM +0100, Giuliano Pochini wrote:
> On Thu, 18 Mar 2004, Samuel Rydh wrote:
> 
> > Btw, I would like to get reports about how well this driver works
> > with respect to noise reduction. I'm in particular interested
> > in the dual 1.4 GHz model...
> 
> The author has a dual-1.2 and I tested it on another dual-1.2. I don't
> know if it has been tested on other mathines. The driver writes in
> the system logs the temperature and the fan speed every time they change,
> so you can check what it's doing (and you can unload the module if you
> see it does something wrong).

Yes I know... I wrote it :-)

It should be perfectly safe to use. It contains a (very conservative)
fail safe; if the temperature exceeds the working point by a few
degrees, the hardware overheat protection is programmed to turn
on the fans 100%. This works even if the kernel has locked up
solidly.

I'm mostly concerned that the working point is set too low for
the 1.4 Ghz machine. If it is, then there might be some unnecessary
noise. When the temperature is going down towards the working point,
the fan speed is increased to remove the last extra heat. 
The assumption is that some temporary heat generating operation
has finished (like a CPU intensive calculation or heavy usage of
the graphics card). This is a good strategy if the working point
is correct but not-so-good if the working point is higher than
expected (cyclic fan behavior might occur).

In all cases, it should be an improvement compared to the firmware
setting which is incredibly noisy and usually causes short period
fan speed cycling.

/Samuel
