Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbULPGVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbULPGVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 01:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbULPGVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 01:21:11 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:41738 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261893AbULPGVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 01:21:06 -0500
Date: Thu, 16 Dec 2004 07:03:46 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Adam Denenberg <adam@dberg.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: bind() udp behavior 2.6.8.1
Message-ID: <20041216060346.GH17946@alpha.home.local>
References: <1103038728.10965.12.camel@sucka> <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka> <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com> <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 09:23:43PM -0500, Adam Denenberg wrote:
> i think you guys are all right.  However there is one concern.  Not 
> clearing out a UDP connection in a firewall coming from a high port is 
> indeed a security risk.  Allowing a high numbered udp port to remain 
> open for a prolonged period of time would definitely impose a security 
> risk which is why the PIX is doing what it does.

Absolutely NO ! it is not "keeping the port open", it is "keeping a SESSION
open". The firewall should allow traffic from the same ip:port to the other
ip:port and from no other server on the net. You new session is totally
unrelated to the old one.

>  The linux server is 
> "reusing" the same UDP high numbered socket however it is doing so 
> exactly as the firewall is clearing its state table (60 ms) from the 
> first connection which is what is causing the issue.

it is not the same session if you connect to a different remote server,
and there is absolutely no reason to arbitrary prevent an internal server
from connecting to two external ones from the same IP:port. Of course, if
you reconnect to the same destIP:port, it should work because in this case
it is a continuation of the same session.

> I think a firewall ought to be aware of such behavior, but at the same 
> time be secure enough to not just leave high numbered udp ports wide 
> open for attack.  I am trying to find out why the PIX chose 60 ms to 
> clear out the UDP state table.  I think that is a random number and 
> probably too short of a span for this to occur however i am still 
> researching it.

it is not the timing which causes trouble, it is the way it confuses new
and already established sessions. Although 60 ms may seem short (you can
probably never resolve anything on ADSL with a loaded link), it may be
perfectly valid if the firewall agrees to open several sessions when you
connect to several servers. And if you connect several times to the same
server, of course it must re-open the session.

> Any other insight would be greatly appreciated.

unfortunately, googling for "pix udp problem" returns 25600 responses...

Regards,
willy
 
