Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbULNRww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbULNRww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbULNRwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:52:06 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27798 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261576AbULNRtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:49:55 -0500
Date: Tue, 14 Dec 2004 18:49:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adam Denenberg <adam@dberg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: bind() udp behavior 2.6.8.1
In-Reply-To: <1103045881.10965.48.camel@sucka>
Message-ID: <Pine.LNX.4.61.0412141846020.1838@yvahk01.tjqt.qr>
References: <1103038728.10965.12.camel@sucka>  <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
  <1103042538.10965.27.camel@sucka>  <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr>
  <1103043716.10965.40.camel@sucka>  <Pine.LNX.4.61.0412141806440.5600@yvahk01.tjqt.qr>
 <1103045881.10965.48.camel@sucka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i am aware that UDP is connectionless.  However in terms of a firewall
>this is different.  It _must_ keep a state table of some sorts otherwise

must vs cannot.

>high port outbound connections destined for a DNS server will never be
>let back in b/c the firewall will just say "Why is this dns server
>making a udp connection to port 32768 on this client?".  Keeping a state
>table allows this behavior thru the firewall as it should.

no state for no connection.
if you want rate limiting, you can use iptables -m limit, or whatever your fw 
implements. Frankly, you can't distinguish DNS traffic from someone who 
hijacked your box by just looking at the packet's header. And your FW _has_ to 
account for the case that multiple, possibly "non-related" packets appear on 
the same source port.

>My issue is that linux is not randomizing or incrementing the ports it
>uses for udp connections to prevent this sort of issue since udp is
>connectionless.  We dont have sequence numbers or the sorts like TCP to

Works for me.

>sort this out, we only have source ip and port.

And the kernel keeps a rover. It's right here:

	grep udp_port_rover /usr/src/linux/net/ipv4/*.c

So whenever someone binds an udp socket to port 0, the kernel chooses 
something. And IF NOT (i.e port != 0 at the time you call bind), you gonna use 
THAT specific port.


Jan Engelhardt
-- 
ENOSPC
