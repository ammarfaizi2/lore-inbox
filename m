Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbREELpY>; Sat, 5 May 2001 07:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbREELpO>; Sat, 5 May 2001 07:45:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22419 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132373AbREELpA>;
	Sat, 5 May 2001 07:45:00 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15091.59308.315685.312632@pizda.ninka.net>
Date: Sat, 5 May 2001 04:44:44 -0700 (PDT)
To: "Svenning Soerensen" <svenning@post5.tele.dk>
Cc: <linux-kernel@vger.kernel.org>, <linux-ipsec@freeswan.org>
Subject: Re: Problem with PMTU discovery on ICMP packets
In-Reply-To: <015201c0d557$a1e69c50$1400a8c0@sss.intermate.com>
In-Reply-To: <015201c0d557$a1e69c50$1400a8c0@sss.intermate.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Svenning Soerensen writes:
 > I think there is a bug in the 2.4 icmp code regarding PMTU discovery.
 > It seems to be inconsistent between reboots: at one boot echo replies always
 > have the DF bit set, while after another boot they don't, indicating that
 > this is caused by an uninitialized parameter.
 > Even 'echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc' doesn't change this
 > behaviour.
 > 
 > I can't think of any legitimate reasons for doing PMTU discovery on ICMP
 > packets, and since it actually in some situations breaks ping in combination
 > with FreeS/WAN (I can elaborate, if anyone is interested), I would suggest
 > to turn it off in a consistent manner.
 > The patch below (against 2.4.4) should accomplish this.

I want to understand why on some boots it's on while on some
boots it is off, that makes no sense.

Before the piece of code you patched, we call ops->create() which is
inet_create in net/ipv4/af_inet.c, there is sets the PMTU discovery
disposition based upon the setting in ipv4_config which should always
have the same setting at the point during boot, every boot.

You need to figure out why it sometimes gets set and sometimes does
not, then we can figure out how to fix it.

Later,
David S. Miller
davem@redhat.com
