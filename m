Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270166AbRHGJz7>; Tue, 7 Aug 2001 05:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270172AbRHGJzo>; Tue, 7 Aug 2001 05:55:44 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:44266 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S270166AbRHGJy5>; Tue, 7 Aug 2001 05:54:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: David Ford <david@blue-labs.org>, linux-kernel@vger.kernel.org
Subject: Re: RP_FILTER runs too late
Date: Mon, 6 Aug 2001 20:52:34 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B6F8E17.9090100@blue-labs.org>
In-Reply-To: <3B6F8E17.9090100@blue-labs.org>
MIME-Version: 1.0
Message-Id: <01080620523409.04153@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 02:43, David Ford wrote:
> I finally figured out why my SNAT setup wasn't working.  I had 1 in
> eth0/rp_filter and that was silently breaking it.
>
> This discussion follows the scripts located at website
> http://blue-labs.org/ , rc.networking and rc.firewalling.  Both are live
> meaning you'll see any changes I make.
>
> Here's the scoop.  I run a VPN from here to my colo server...but I don't
> want all my traffic going through the VPN.  So I need to finagle a
> method of NAT.  Now because the NAT code runs behind the routing code,
> packets are already heading the wrong direction when they get their
> headers changed.  Because of that you need to tag them with a mark and
> implement routing rules based on that mark.  As an aside note, all that
> could be avoided if SNAT would just be available in PREROUTING.
>
> Ok. Now that packets are flowing through the right interfaces, things
> look good but wait...the reply packets are vanishing without a trace.
>
> The culprit is the rp_filter on eth0.  The packet comes in, gets the
> header rewritten then gets chomped by rp_filter.  I'm not quite sure why
> because the src is still an external IP and the destination before and
> after is still an internal IP.
>
> Wouldn't the rp_filter be more effective if it came ahead of the nat
> code?  As it is now, it's useless on that interface.
>
> David

I just put up some firewall rules as part of the Dynamic Virtual Private 
Networking project on sourceforge at http://dvpn.sourceforge.net.  It shows 
both source and destination nat, port forwarding outside of a box, and a 
couple other fun goodies.  Not necessarily your kind of VPN, but maybe it'll 
help...

I'm not sure what you're trying to do, but I got everything I tried to work...

Rob
