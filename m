Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbULNRkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbULNRkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbULNRkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:40:13 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:62097 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S261571AbULNRiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:38:03 -0500
Subject: Re: bind() udp behavior 2.6.8.1
From: Adam Denenberg <adam@dberg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412141806440.5600@yvahk01.tjqt.qr>
References: <1103038728.10965.12.camel@sucka>
	 <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
	 <1103042538.10965.27.camel@sucka>
	 <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr>
	 <1103043716.10965.40.camel@sucka>
	 <Pine.LNX.4.61.0412141806440.5600@yvahk01.tjqt.qr>
Content-Type: text/plain
Message-Id: <1103045881.10965.48.camel@sucka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Dec 2004 12:38:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am aware that UDP is connectionless.  However in terms of a firewall
this is different.  It _must_ keep a state table of some sorts otherwise
high port outbound connections destined for a DNS server will never be
let back in b/c the firewall will just say "Why is this dns server
making a udp connection to port 32768 on this client?".  Keeping a state
table allows this behavior thru the firewall as it should.

My issue is that linux is not randomizing or incrementing the ports it
uses for udp connections to prevent this sort of issue since udp is
connectionless.  We dont have sequence numbers or the sorts like TCP to
sort this out, we only have source ip and port.

Other OS's seem  to do this and thus apps are not getting broken when
connections are made thru the firewall, which is why i originally posted
the question.  I was hoping that maybe there is some workaround or that
hopefully someone else encountered this issue.  I am not saying the
firewall is not totally to blame, but i can see why it is behaving the
way it is when seeing tons of connections from the same udp ip/port come
in.

thanks again
adam



On Tue, 2004-12-14 at 12:10, Jan Engelhardt wrote:
> >any firewall must keep some sort of state table even if it is udp.  How
> 
> No.
> 
> >else do you manage established connections?  It must know that some high
> 
> You don't manage something that does not need managing. It's like firing a 
> bullet at some. You can not tell whether there's still more bullets to come or 
> not.
> 
> >numbered port is making a udp dns request, and thus be able to allow
> >that request back thru to the high numbered port client b/c the
> >connection is already established.
> 
> See linux-os's reply. UDP is connectionless.
> 
> >what does any fireawall do if it sees one ip with the same high numbered
> >udp port make a request in a _very_ short amount of time (under 60ms for
> >this example)?
> 
> I let it pass.
> 
> >It must make a distintion between an attack and legit
> >traffic.
> 
> That's something VERY different. There is a difference between **knowing** 
> that a set of packets _are related_ to each other and the time between two 
> **arbitrary** packets.
> 
> >  So if it sees one ip/port make multiple requests in too short
> >of a time frame, it will drop the traffic, as it probably should.
> 
> Depends on the definition of attack. Look it at that way:
> 
> localhost:32768 sends an UDP packet to dnsserver:53... but already the next 
> packet CAN BE malicious. (Another process can take over the port if the former 
> has dropped the socket.)
> 
> >This
> >is causing erratic behavior when traffic traverses the firewall b/c the
> 
> Then fix the FW.
> 
> >linux kernel keeps allocating the same source high numbered ephemeral
> 
> In your case, the socket is allocated once for the whole program. This socket 
> is _reused_.
> 
> >port.  I would like to know if there is a way to alter this behavior b/c
> >it is breaking applications.
> 
> No, as said, your FW is broken.
> 
> 
> 
> 
> Jan Engelhardt

