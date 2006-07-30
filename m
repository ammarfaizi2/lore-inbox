Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWG3WC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWG3WC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWG3WC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 18:02:28 -0400
Received: from host-84-9-202-16.bulldogdsl.com ([84.9.202.16]:22465 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932475AbWG3WC1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 18:02:27 -0400
Date: Sun, 30 Jul 2006 23:02:00 +0100
From: Ben Dooks <ben@fluff.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Chris Boot <bootc@bootc.net>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
Message-ID: <20060730220200.GB8907@home.fluff.org>
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730130811.GI10495@pengutronix.de>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 03:08:11PM +0200, Robert Schwebel wrote:
> Chris,
> 
> On Fri, Jul 28, 2006 at 09:44:40PM +0100, Chris Boot wrote:
> > I propose to develop a common way of registering and accessing GPIO pins on 
> > various devices.
> 
> I've attached the gpio framework we have developed a while ago; it is
> not ready for upstream, only tested on pxa and has probably several
> other drawbacks, but may be a start for your activities. One of the
> problems we've recently seen is that for example on PowerPCs you don't
> have such a clear "this is gpio pin x" nomenclature, so the question
> would be how to do the mapping here.

Right, my $0.02 worth:

1) The system does not currently allow for other GPIO sources
   than the CPU. There are a variety of GPIOs, that could come
   from expansion chips, on board CPLDs, etc.

2) The GPIO configuration from my last thought experiment have the
   following properties for each pin:

   input:
	- input
	- inverted input

   output:
	- normal output
	- inverted output
	- tristatable output
	- open collector (can only pull to zero)
	- open emmitor (can only pull to high)

   The allowance of inverted outputs, is very useful to allow
   drivers to assume either '0' or '1' is an active signal, allowing
   per-board fixups when the designer suddely decides the best way
   of connecting device A to B is via a spare inverter...

   The other way would be to allow the mapping of '0' and '1' states
   to either of the states:

	- output 1
	- output 0
	- tri-state

   The classing of tri-state as a seperate from input, is in case the
   hardware does not see input as a valid state, or that input and
   output are somehow different. 
  
   pull resistor:
	- tristate (no resistor)
	- pull low
	- pull high

   The input and output are seperate, assuming that there is the
   possiblity the system can read back the line even if the GPIO
   is set as an output.

3) The sysfs interface should be configurable, as systems
   with lots of GPIO would end up with large numbers of
   files and directories in sysfs.

4) you probably want to ensure pull-up resistors are off if the
   output is being driven. 

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
