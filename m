Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268870AbUIMTS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268870AbUIMTS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIMTS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:18:28 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:35852 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268870AbUIMTS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:18:26 -0400
Date: Mon, 13 Sep 2004 21:18:10 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Paul Jakma <paul@clubi.ie>, Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Message-ID: <20040913191810.GE2780@alpha.home.local>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf> <1095008692.11736.11.camel@localhost.localdomain> <20040912192331.GB8436@hout.vanvergehaald.nl> <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org> <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org> <20040913041846.GD2780@alpha.home.local> <20040913190741.GD19399@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913190741.GD19399@thundrix.ch>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 09:07:41PM +0200, Tonnerre wrote:
> Salut,
> 
> On Mon, Sep 13, 2004 at 06:18:47AM +0200, Willy Tarreau wrote:
> > > The BGP state machine should instead, in normal operation, have 
> > > only treated Hold time expired as the definitive sign of "peer is 
> > > down" and allowed reconnects.
> > 
> > It should not necessarily wait for the time-out, but at least wait for
> > a few reconnect errors.
> 
> Problem  there: you  can fake  connection errors  almost as  easily as
> sending an RST packet, so the DoS might reappear, might it not?
> 

No, as long as you don't keep the routes from the old session until the
new one establishes and fills up (or you reach the timeout). And when I
spoke about "connection errors", I really spoke about connection
establishment. I bet you'll have more difficulties trying to send the
right RST just after a SYN (or an ICMP unreachable with the right payload)
than sending them once the session is already established. It does make
a big difference.

Willy

