Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUJGUbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUJGUbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUJGU3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:29:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33545 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267958AbUJGU11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:27:27 -0400
Date: Thu, 7 Oct 2004 21:27:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sebastien.hinderer@libertysurf.fr
Subject: Re: [Patch] new serial flow control
Message-ID: <20041007212722.G8579@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	sebastien.hinderer@libertysurf.fr
References: <200410051249_MC3-1-8B8B-5504@compuserve.com> <20041005172522.GA2264@bouh.is-a-geek.org> <1097176130.31557.117.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1097176130.31557.117.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 07, 2004 at 08:08:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 08:08:56PM +0100, Alan Cox wrote:
> On Maw, 2004-10-05 at 18:25, Samuel Thibault wrote:
> > No: data actually pass _after_ CTS and RTS are lowered back: the flow control
> > only indicate the beginning of one frame.
> 
> Ok I've pondered this somewhat. I don't think the hack proposed is the
> right answer for this. I believe you should implement a simple line
> discipline for this device so that it stays out of the general code.
> 
> Right now that poses a challenge but if drivers were to implement
> ldisc->modem_change() or a similar callback for such events an ldisc
> could then handle many of the grungy suprises and handle them once and
> in one place.

To me at least that sounds like a good solution.  I can't help but
wonder whether moving some of the usual modem line status change
processing should also be moved into the higher levels.  This will
probably make more sense if the "block till ready" code also moves,
which I think Ted was considering at one point.

However, that's probably something to think about later.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
