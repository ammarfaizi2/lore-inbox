Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbTHSTF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbTHSSmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:42:19 -0400
Received: from relay.pair.com ([209.68.1.20]:40464 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S272927AbTHSSa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:30:29 -0400
X-pair-Authenticated: 68.40.145.213
Subject: RE: [2.4 PATCH] bugfix: ARP respond on all devices
From: Daniel Gryniewicz <dang@fprintf.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Underwood <richard@aspectgroup.co.uk>,
       "'David S. Miller'" <davem@redhat.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, willy@w.ods.org,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1061296544.30566.8.camel@dhcp23.swansea.linux.org.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk>
	 <1061296544.30566.8.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061317825.3744.7.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Aug 2003 14:30:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 08:35, Alan Cox wrote:
> You increase it and you shortcut on shared lans. Thats really a seperate
> issue to the question of which source is used. If you loopback someone
> elses address on your own lo device I'm not suprised weird shit happens,
> put the alias on eth0 where it belongs.

Only if you are on a shared lan.  If you are not on a shared lan, then
it will *ONLY* work if linux is on the other end.  No other system will
work.  And, you don't need an alias on loopback.  Merely changing the
default route will result in this.  Change default route from gw 1.1.1.1
on eth0 to gw 2.2.2.2 on eth1 (making sure that 2.2.2.2 doesn't have an
arp entry), and linux will say, on eth1:
whohas 2.2.2.2 tell 1.1.1.2
where 1.1.1.2 is the address on eth0.  No one will respond to this, so
all communication from beyond a directly connected network will now
fail.

-- 
Daniel Gryniewicz <dang@fprintf.net>
