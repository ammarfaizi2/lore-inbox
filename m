Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbULNRGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbULNRGI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbULNRE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:04:56 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:45713 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S261560AbULNRB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:01:59 -0500
Subject: Re: bind() udp behavior 2.6.8.1
From: Adam Denenberg <adam@dberg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr>
References: <1103038728.10965.12.camel@sucka>
	 <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
	 <1103042538.10965.27.camel@sucka>
	 <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr>
Content-Type: text/plain
Message-Id: <1103043716.10965.40.camel@sucka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Dec 2004 12:01:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

any firewall must keep some sort of state table even if it is udp.  How
else do you manage established connections?  It must know that some high
numbered port is making a udp dns request, and thus be able to allow
that request back thru to the high numbered port client b/c the
connection is already established.

what does any fireawall do if it sees one ip with the same high numbered
udp port make a request in a _very_ short amount of time (under 60ms for
this example)?  It must make a distintion between an attack and legit
traffic.  So if it sees one ip/port make multiple requests in too short
of a time frame, it will drop the traffic, as it probably should.  This
is causing erratic behavior when traffic traverses the firewall b/c the
linux kernel keeps allocating the same source high numbered ephemeral
port.  I would like to know if there is a way to alter this behavior b/c
it is breaking applications.

thanks
adam

please CC me as I am not on this list.

On Tue, 2004-12-14 at 11:44, Jan Engelhardt wrote:
> >sorry "closed" was the wrong term here.  We are using a PIX Firewall
> >Module and it keeps a state table of all connections (tcp and udp). 
> >Thus when a new udp connection comes in with same high numbered source
> 
> UDP does not know connections. As such, _nobody_ can tell whether an UDP 
> packet belongs to a logically existing "connection" or not.
> 
> >port and the firewall has not removed that connection from its state
> >table, the firewall drops the packet.  The firewall needs about 60ms in
> >order to clear that connection from the state table, so if a second udp
> >request with the same high number port/ip comes thru before the firewall
> >clears the connection from the state table, it will drop the connection
> >(which is what we are seeing).
> >
> >FreeBSD seems to increment future udp requests which prevents this
> >problem.  It just seems strange that the kernel would not randomize or
> >increment these source ports for udp requests.
> 
> The kernel does not have problems with UDP, it's probably your firewall.
> 

