Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUDUXHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUDUXHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 19:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUDUXHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 19:07:31 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:1554 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262927AbUDUXH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 19:07:29 -0400
Date: Thu, 22 Apr 2004 01:02:57 +0200
From: Willy Tarreau <w@w.ods.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: "David S. Miller" <davem@redhat.com>,
       Fabian Uebersax <fabian.uebersax@ch.tiscali.com>,
       linux-kernel@vger.kernel.org
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
Message-ID: <20040421230257.GK596@alpha.home.local>
References: <435F241B01CDFC44B50865371254BC3702426157@ch-flu-exchange> <20040421132642.60c21268.davem@redhat.com> <874qrdggdt.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874qrdggdt.fsf@deneb.enyo.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 21, 2004 at 11:39:26PM +0200, Florian Weimer wrote:
> "David S. Miller" <davem@redhat.com> writes:
> 
> > On Wed, 21 Apr 2004 19:27:01 +0200
> > "Fabian Uebersax" <fabian.uebersax@ch.tiscali.com> wrote:
> >
> >> http://www.ietf.org/internet-drafts/draft-ietf-tcpm-tcpsecure-00.txt
> >
> > Anyone who recommends responding to a RST packet, does not
> > understand TCP very well.

This might quickly lead to very funny loops :-) I don't think that they have
taken into account every situation (dynamic IP re-assignment to someone else
during established session, address translation, sequence randomization a la
openbsd or ippersonality, ...). I even have the feeling that they don't
distinguish between SYN and SYN/ACK...

This "vulnerability" as they call it has nothing new: around 1996, I've
played with a tool named "juggernaut" which exploited this TCP feature to
close sessions. It was designed as a hacking tool, but revealed very useful
to close never-ending sessions on HTTP proxies :-) Some time later, another
one came out too. What is new IMHO is that windows are scaling up and this
article reminds us that we should not confuse a 32 bits sequence number
with a session cookie. I read somewhere that on 10GbE, sequence numbers
are rotating so fast (overflow every 3 seconds) that you are forced to
use timestamps if you don't want to risk to merge late segments. In this
case, the timestamp adds another 32 bits "random" (can we have a per-session
random offset added to timestamps ?).

> This was my thought as well.  Surely you don't want to deploy such a
> drastic change to the TCP state engine after just so little
> investigation.

Why? It makes your TCP harder with a 100% money-back warranty :-)

> In the confined environment of BGP peerings, the risks can be
> controlled (RSTs are typically rate-limited on the receiving end
> anyway, for example).  On the net as a whole, you have to be
> compatible with all implementations ever written.  If some
> implementation replied to the ACK cookie with another RST with an
> suitable sequence number, there might be a few issues.

Well, I hope that some script kiddies will at least try to scan the net
for such crappy border routers if there are some ISP out there stupid
enough to accept spoofed BGP packets. At least, we'll see them (or their
customers) disappear from the net for a few minutes and we will know why ;
They'll get what they deserve ! We all expect a minimum of security on
such access points.

> (BTW, TCP connections used for BGP typically have port numbers from a
> very small set.  So there is no additional randomness from that which
> offers any additional protection.)

That's what I was discussing with a collegue of mine. I was wondering if
a cisco always uses the same ports (or nearly the same) after a reboot,
in which case the source port range to be swept would be reduced.

Regards,
Willy

