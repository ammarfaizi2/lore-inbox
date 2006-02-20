Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWBTNHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWBTNHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWBTNHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:07:15 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:19377 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1030199AbWBTNHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:07:13 -0500
Date: Mon, 20 Feb 2006 14:07:12 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: David Vrabel <dvrabel@cantab.net>, Adrian Bunk <bunk@stusta.de>,
       Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Bowler <jbowler@acm.org>
Subject: Re: [RFC] [PATCH 1/2] Driver to remember ethernet MAC values: maclist
Message-ID: <20060220130712.GA24784@xi.wantstofly.org>
References: <20060220010113.GA19309@deprecation.cyrius.com> <20060220014735.GD4971@stusta.de> <20060220030146.11f418dc@inspiron> <43F9B32B.3090203@cantab.net> <20060220135718.038b675b@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220135718.038b675b@inspiron>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 01:57:18PM +0100, Alessandro Zummo wrote:

>  you're certainly right on the ixp4xx, but the are other uses
> for this driver which we are working on.. for example,
> some Cirrus Logic ARM based chips (ep93xx) have an ethernet device
> that could benefit from that.

Many platforms have the same problem (esp. embedded ones), but that
doesn't mean that maclist is necessarily the best solution.

The main problem I see with maclist (correct me if I'm wrong) is that
there can be multiple devices in the system that need to get their
MAC address from somewhere, and maclist doesn't make the distinction
which address belongs to what.  The main issue I have with it is that
it's too general, and that it's lots of code.

I don't think something as complex as maclist is necessary to solve
the problem.  For example, why don't you just have an unsigned char
ixp4xx_mac_addr[6] in the ixp4xx core code, have the ixp4xx board code
fill that in, and have the ixp4xx ethernet driver use that?

Or just pass the MAC along in platform device style.  What I did in
drivers/net/ixp2000/ was to have enp2611.c (board-specific code) read
the MAC from the board, and pass it to ixpdev.c (generic code) in the
net_device structure.


cheers,
Lennert
