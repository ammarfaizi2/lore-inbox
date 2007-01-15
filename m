Return-Path: <linux-kernel-owner+w=401wt.eu-S1750821AbXAOPaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbXAOPaL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 10:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbXAOPaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 10:30:10 -0500
Received: from twin.jikos.cz ([213.151.79.26]:48701 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbXAOPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 10:30:09 -0500
Date: Mon, 15 Jan 2007 16:30:05 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: linux-kernel@vger.kernel.org
cc: Pavel Machek <pavel@ucw.cz>
Subject: Re: [announce] ipwireless_cs 3G PCMCIA network driver
In-Reply-To: <Pine.LNX.4.64.0701121633130.16747@twin.jikos.cz>
Message-ID: <Pine.LNX.4.64.0701151513100.16747@twin.jikos.cz>
References: <Pine.LNX.4.64.0701121633130.16747@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2007, Jiri Kosina wrote:

> This card is correctly detected by this driver, is able to send and 
> receive AT commands, dial and connect, but after the ppp connection is 
> established, the LCP frames that the card is passing to the driver are 
> broken (one byte per frame). We are currently trying, together with 
> authors of original driver, to identify an exact cause of this behavior 
> (seems like PPP framer on the card is somehow misconfigured or 
> unitialized).

Just for the lkml archives and google to have it - I have just committed 
to ipwireless_cs git tree a patch that makes the driver work also with V3 
cards.

commit 490828d4ced805410d08acc46e56410a3aacdaeb
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Mon Jan 15 15:09:11 2007 +0100

    ipwireless_cs: make the V3 card ppp connections work

    V3 card requires the dial commands to be sent on RAS channel and
    not DIAL channel - when being sent on DIAL channel, the ppp framer
    on the card is not configured properly.

    Signed-off-by: Jiri Kosina <jkosina@suse.cz>

-- 
Jiri Kosina
