Return-Path: <linux-kernel-owner+w=401wt.eu-S965138AbWLTPeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWLTPeY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 10:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWLTPeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 10:34:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54279 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964963AbWLTPeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 10:34:23 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Arjan van de Ven <arjan@infradead.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20061220152701.GA22928@dspnet.fr.eu.org>
References: <20061219185223.GA13256@srcf.ucam.org>
	 <200612191959.43019.david-b@pacbell.net>
	 <20061220042648.GA19814@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de>
	 <20061220055209.GA20483@srcf.ucam.org>
	 <1166601025.3365.1345.camel@laptopd505.fenrus.org>
	 <20061220125314.GA24188@srcf.ucam.org>
	 <1166621931.3365.1384.camel@laptopd505.fenrus.org>
	 <20061220152701.GA22928@dspnet.fr.eu.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 16:34:17 +0100
Message-Id: <1166628858.3365.1425.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 16:27 +0100, Olivier Galibert wrote:
> On Wed, Dec 20, 2006 at 02:38:51PM +0100, Arjan van de Ven wrote:
> > [1] What kind of latency would be allowed? Would an implementation be
> > allowed to power up the phy say once per minute or once per 5 minutes to
> > see if there is link? The implementation could do this progressively;
> > first poll every X seconds, then after an hour, every minute etc.
> 
> I suspect that the hard maximum latency is the time needed by the user
> to start the network himself, be it opening a root xterm and doing the
> appropriate invocation or pulling up and clicking where appropriate in
> a GUI.  That's probably around 5 seconds.  Over that, and they won't
> even notice there is an autodetection running.
> 
> But still, 5 seconds is probably too much too, because it's going to
> look like it's unreliable.  The user has to see something happen
> within half-a-second or so, otherwise he's going to start doing it by
> hand.  The "see" part is distribution/desktop-dependant and not the
> kernel problem, but the top chrono happens when the rj45 is plugged
> in.

5 seconds is unfair and unrealistic though. The *hardware* negotiation
before link is seen can easily take upto 45 seconds already.
That's a network topology/hardware issue (spanning tree fun) that
software or even the hardware in your PC can do nothing about.

this means that the "power up time" needs to be at least 45 seconds, if
it's then down 5 seconds inbetween... that's not real power savings.

> .
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

