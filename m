Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268791AbRG0HSR>; Fri, 27 Jul 2001 03:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268793AbRG0HSH>; Fri, 27 Jul 2001 03:18:07 -0400
Received: from tierra.stl.es ([195.235.83.3]:34411 "EHLO tierra.stl.es")
	by vger.kernel.org with ESMTP id <S268791AbRG0HRy>;
	Fri, 27 Jul 2001 03:17:54 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent proxies and binding to foreign addresses
In-Reply-To: <m2lmlcakrq.fsf@j-sanchez-p.stl.es>
	<m2lmlcakrq.fsf@j-sanchez-p.stl.es>
	<200107270215.EAA1376016@mail.takas.lt>
From: Julio Sanchez Fernandez <j_sanchez@stl.es>
Date: 27 Jul 2001 09:16:58 +0200
In-Reply-To: Nerijus Baliunas's message of "Fri, 27 Jul 2001 04:15:32 +0200 (EET)"
Message-ID: <m2hevyaljp.fsf@j-sanchez-p.stl.es>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Nerijus Baliunas <nerijus@users.sourceforge.net> writes:

> On 25 Jul 2001 21:09:13 +0200 Julio Sanchez Fernandez <j_sanchez@stl.es> wrote:
> 
> JSF> This mechanism has worked since I originally wrote my kludge up to
> JSF> 2.2.x but, from what I can gather, it does not work anymore in 2.4.x.
> 
> Hello,
> 
> I don't know if it is useful for you, but http://www.mcknight.de/jftpgw
> supports transparent proxy for Linux 2.4.x kernel.

Only impersonating the server.  What does not work is impersonating
the client and that cannot be fixed from user space.

> BTW, do you know of any port forwarder which works with 2.4 kernel in
> transparent mode? I tried mmtcpfwd and portfwd, but both do not work.

Anyone that used TCP and worked before should be easy to adapt by just
finding where it got the destination address with getsockname and
using the getsockopt with SOL_ORIGINAL_DST thing.  Apparently, UDP is
out as well, though I don't care about that currently.

Add to your list more forwarders like transproxy and those (plug-gw in
particular) in the TIS (NAI) FWTK with the transparency patches
described at http://www.fwtk.org

While none of them has been adapted to 2.4, they should be easy as I
said above.

And as long as you don't care what origin address the server sees,
that's alright.  But all connections now seem to come from the proxy.
And that does not let you do things like differentiated services,
access control or audit.  Even user support becomes a mess.

Julio
