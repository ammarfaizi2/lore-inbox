Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbULNRLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbULNRLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbULNRLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:11:15 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:21651 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261562AbULNRKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:10:42 -0500
Date: Tue, 14 Dec 2004 18:10:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adam Denenberg <adam@dberg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: bind() udp behavior 2.6.8.1
In-Reply-To: <1103043716.10965.40.camel@sucka>
Message-ID: <Pine.LNX.4.61.0412141806440.5600@yvahk01.tjqt.qr>
References: <1103038728.10965.12.camel@sucka>  <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
  <1103042538.10965.27.camel@sucka>  <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr>
 <1103043716.10965.40.camel@sucka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>any firewall must keep some sort of state table even if it is udp.  How

No.

>else do you manage established connections?  It must know that some high

You don't manage something that does not need managing. It's like firing a 
bullet at some. You can not tell whether there's still more bullets to come or 
not.

>numbered port is making a udp dns request, and thus be able to allow
>that request back thru to the high numbered port client b/c the
>connection is already established.

See linux-os's reply. UDP is connectionless.

>what does any fireawall do if it sees one ip with the same high numbered
>udp port make a request in a _very_ short amount of time (under 60ms for
>this example)?

I let it pass.

>It must make a distintion between an attack and legit
>traffic.

That's something VERY different. There is a difference between **knowing** 
that a set of packets _are related_ to each other and the time between two 
**arbitrary** packets.

>  So if it sees one ip/port make multiple requests in too short
>of a time frame, it will drop the traffic, as it probably should.

Depends on the definition of attack. Look it at that way:

localhost:32768 sends an UDP packet to dnsserver:53... but already the next 
packet CAN BE malicious. (Another process can take over the port if the former 
has dropped the socket.)

>This
>is causing erratic behavior when traffic traverses the firewall b/c the

Then fix the FW.

>linux kernel keeps allocating the same source high numbered ephemeral

In your case, the socket is allocated once for the whole program. This socket 
is _reused_.

>port.  I would like to know if there is a way to alter this behavior b/c
>it is breaking applications.

No, as said, your FW is broken.




Jan Engelhardt
-- 
ENOSPC
