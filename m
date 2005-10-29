Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVJ2MJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVJ2MJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 08:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVJ2MJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 08:09:18 -0400
Received: from carlsberg.amagerkollegiet.dk ([83.221.136.34]:40967 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id S1751039AbVJ2MJR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 08:09:17 -0400
From: moffe@zz9.dk (Rasmus =?iso-8859-1?Q?B=F8g?= Hansen)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Mac address in network stack.
Date: Sat, 29 Oct 2005 14:09:00 +0200
Message-ID: <87u0f0le3n.fsf@grignard.amagerkollegiet.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-OS: Debian GNU/Linux
X-Homepage: http://www.zz9.dk/
X-PGP-Key: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0x13C9843F
X-ICQ: 88924807
X-MSN: moffe@zz9.dk
X-Jabber: moffe@zz9.dk
Organization: NykDOOM Corporation Inc.
X-Face: %DS.+[45f??m49W<wuMca_)Y:'@GXuT>kAzQtux,*gE!x/E5!wg8B/g|35OJY)6m(_9^e:_
 U~,?.DLHGIc{]>=s0^W"EL^#$#;haH-&'IO&<_7Z@Ib)<5$kByeqKV6}]<;<]{zP;%*>p\06ZdcS;u
 CDw|1qDi;lv4_<a6LGU3E`}cT:T*x9{3V
X-Virus: Hi! I'm a header virus! Copy me into yours and join the fun!
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Amagerkollegiet-MailScanner: Found to be clean
X-Amagerkollegiet-MailScanner-From: moffe@zz9.dk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am trying to adapt a sched module (WRR, a sched class and qdisc) to
the 2.6 kernel. It was originally coded for 2.2 and classified hosts
by their mac address. Later it got classification for IP and with 2.4
MAC support was deactivated as this apparently was done in another way
in 2.4. I am now trying to reimplement the MAC support but have run
into trouble...

In 2.2 the mac address of the sender and receiver of the packet was
found by eg.:

memcpy(addr,skb->mac.ethernet->h_source,ETH_ALEN);
memcpy(addr,skb->mac.ethernet->h_dest,ETH_ALEN);

This was apparently possible only when running in bridging mode. In
the 2.6 kernel this seems to be able to do by eg.:

memcpy(addr,eth_hdr(skb)->h_source, ETH_ALEN);
memcpy(addr,eth_hdr(skb)->h_dest, ETH_ALEN);

However eth_hdr() seems to return a NULL pointer (really a pointer to
skb->mac.raw), even when running in bridge mode.

I see this as a sign that the mac address is not available in this
layer of the network stack. Is this true or am I just trying to fetch
the MAC address in the wrong way?

Thanks in advance
/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
If there are no stupid questions, then what kind of questions do stupid
people ask? Do they get smart just in time to ask questions?
----------------------------------------------[ moffe at zz9 dot dk ] --

