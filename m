Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288159AbSBDCf5>; Sun, 3 Feb 2002 21:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288169AbSBDCfr>; Sun, 3 Feb 2002 21:35:47 -0500
Received: from clavin.cs.tamu.edu ([128.194.130.106]:49085 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S288159AbSBDCfg>;
	Sun, 3 Feb 2002 21:35:36 -0500
Date: Sun, 3 Feb 2002 20:35:33 -0600 (CST)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: Rob Landley <landley@trommello.org>
cc: linux-kernel@vger.kernel.org
Subject: packet_socket = socket(PF_PACKET, int socket_type, int protocol);
In-Reply-To: <Pine.SOL.4.10.10202031831480.25367-100000@dogbert>
Message-ID: <Pine.SOL.4.10.10202032016260.27278-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, 
	PF_PACKET socket should bypass IPTABLES queue, I think.?
	http://docs.csoft.net/cgi-bin/man.cgi?section=7&topic=packet

	I will try logging target and will enjoy it.
	
	Thanks!

Xinwen Fu

P.S.
	This semester (I'm still a student, old. Ah, shameful) I took a
security class. Our (I'm in a black group) task is to hack a Redhat 7.2
linux
machine cnotrolled by a golden group. If you'd like, I can tell you what
we are doing step by step and
I think you can give a hand to crack these bad guys' machine...



On Sun, 3 Feb 2002, Xinwen - Fu wrote:

> Rob,
> 	Another problem:
> 	Will a packet from SOCK_PACKET socket bypass all the queues of
> IPTABLES?
> 
> 	Thanks!
> 	
> 
> Xinwen Fu
> 
> 
> On Sun, 3 Feb 2002, Rob Landley wrote:
> 
> > On Sunday 03 February 2002 01:45 pm, Xinwen - Fu wrote:
> > > Hi, All,
> > >
> > > 	I want  to know how a raw packet passes the chain of iptables.
> > >
> > > 	Here are the iptables chains
> > >
> > > --->PRE------>[ROUTE]--->FWD---------->POST------>
> > >         Conntrack    |       Filter   ^    NAT (Src)
> > >         Mangle       |                |    Conntrack
> > >         NAT (Dst)    |             [ROUTE]
> > >         (QDisc)      v                |
> > >                      IN Filter       OUT Conntrack
> > >
> > >                      |  Conntrack     ^  Mangle
> > >                      |
> > >                      |                |  NAT (Dst)
> > >
> > >                      v                |  Filter
> > >
> > >
> > > 	So how a raw packet go through these chains?
> > 
> > 
> > Well, from trial and error and a lot of documentation reading, I eventually 
> > worked out that a TCP/IP packet basically seems to do this:
> > 
> > --->pre--->forward--->post--->
> >      |                           ^
> >      |                           |
> >      v                          |
> >      input->local ports->output
> > 
> > I'd like to point out that the last arrow should point from "output" to 
> > "post", since kmail apparently is not using a fixed with font, and I can't 
> > figure out how to get it to do so.  (I did figure out how to get it to use a 
> > korean, chinese, or cyrillic encoding, but not monospaced.  Sigh...)
> > 
> > So in prerouting, the packet is either forwarded on to the forwarding chain 
> > (if it's not for this box) or to the input chain (if it's for a daemon on 
> > this box).  Forwarding never sees packets locally generated on this box, they 
> > go into the output chain and then get sent on to postrouting (which is where 
> > forwarding also feeds into).
> > 
> > It took a little trial and error to work this out, by the way.  It's entirely 
> > ossibly I'm wrong (since I don't think the above agrees with the 
> > documentation), but at the same time it works and survives specific behavior 
> > testing, so... :)  The tables are fairly arbitrarily broken into "NAT" tables 
> > and non-NAT tables.  Oh, and one of the chains (output, I think) exists in 
> > both nat and non-nat versions.  To this day, I have no idea why...
> > 
> > > 	Thanks!!
> > >
> > > Xinwen Fu
> > 
> > If the above doesn't help, this might:
> > 
> > http://netfilter.samba.org/unreliable-guides/
> > 
> > Rob
> > 
> 
> 



