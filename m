Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVFOLPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVFOLPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVFOLPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:15:21 -0400
Received: from animx.eu.org ([216.98.75.249]:12697 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261398AbVFOLPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:15:12 -0400
Date: Wed, 15 Jun 2005 07:31:59 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Problem found: kaweth fails to work on 2.6.12-rc[456]
Message-ID: <20050615113159.GA10188@animx.eu.org>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050612004136.GA8107@animx.eu.org> <200506121722.09813.oliver@neukum.org> <20050615010238.GA9215@animx.eu.org> <200506150829.52765.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506150829.52765.oliver@neukum.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Very well.
> 
> > Results (after ifconfig up, ethernet cable was plugged in at the time):
> > Jun 14 20:50:25 gonzales kernel: [80756.691742] kaweth: begin callback
> > Jun 14 20:50:25 gonzales kernel: [80756.691754] kaweth: u->status: 0
> > Jun 14 20:50:25 gonzales kernel: [80756.691759] kaweth: Link state change.  kaweth->linkstate: 0 act_state: 2
> > Jun 14 20:50:25 gonzales kernel: [80756.691764] kaweth: netif_carrier_off
> 
> OK, that should not happen.
> 
> Could you remove the "!" at 'if (!act_state) {' and retest?
> The documentation I got says that it should be there, but who knows
> how accurate it is for all devices.

Ok, I removed the ! and it now says "netif_carrier_on" and still blasting
the messages.  I'm unable to ping the other end when configured.

> > Jun 14 20:50:25 gonzales kernel: [80756.691769] kaweth: new link state: 2
> > Jun 14 20:50:25 gonzales kernel: [80756.691776] kaweth: end callback
> > 
> > the next thing was:
> > Jun 14 20:50:25 gonzales kernel: [80756.819793] kaweth: begin callback
> > Jun 14 20:50:25 gonzales kernel: [80756.819800] kaweth: u->status: 0
> > Jun 14 20:50:25 gonzales kernel: [80756.819807] kaweth: end callback
> > many times, last occurence:
> > Jun 14 20:50:36 gonzales kernel: [80767.576134] kaweth: begin callback
> > Jun 14 20:50:36 gonzales kernel: [80767.576143] kaweth: u->status: 0
> > Jun 14 20:50:36 gonzales kernel: [80767.576157] kaweth: end callback
> > 
> > then I ifconfig down since it was spewing that information:
> > Jun 14 20:50:36 gonzales kernel: [80767.618157] kaweth: begin callback
> > Jun 14 20:50:36 gonzales kernel: [80767.618172] kaweth: u->status: -2
> > 
> > I assume it didn't print the end since the status was -2 (not sure what -2 is)
> 
> Killing the URB due to ifconfig.

I meant I didn't know the name to number translation.

For the next tests, I think it would be best to remove the 3 printks I added
to show beginning, u->status, and ending.  Spews too much stuff =)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
