Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUGFXCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUGFXCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUGFXCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:02:03 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:22245 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264660AbUGFXBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:01:48 -0400
Date: Wed, 7 Jul 2004 01:01:47 +0200
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, jamie@shareable.org,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: PLS help fix: recent 2.6.7 won't connect to anything Re: [PATCH] fix tcp_default_win_scale.
Message-ID: <20040706230147.GB6694@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>,
	Stephen Hemminger <shemminger@osdl.org>, jamie@shareable.org,
	netdev@oss.sgi.com, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20040701133738.301b9e46@dell_ss3.pdx.osdl.net> <20040701140406.62dfbc2a.davem@redhat.com> <20040702013225.GA24707@conectiva.com.br> <20040706093503.GA8147@outpost.ds9a.nl> <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net> <20040706194034.GA11021@mail.shareable.org> <20040706130549.31daa8e0@dell_ss3.pdx.osdl.net> <20040706132822.70c8174a.davem@redhat.com> <20040706133641.4a58af30@dell_ss3.pdx.osdl.net> <20040706133559.70b6380d.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706133559.70b6380d.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 01:35:59PM -0700, David S. Miller wrote:

> Therefore we do not know which of the following two it really is:

Anybody with this problem is kindly invited to try to connect to
213.244.168.210, port 10000, http://213.244.168.210:10000/ should work.

If you have a problem, email me with your IP address, I have a tcpdump
running.

> 1) window scale option being stripped from SYN+ACK

The remote is in fact zeus-pub.kernel.org. I assume it does not have a
broken firewall, and I sure haven't, and it sends out to me:

00:46:31.936667 192.168.1.4.34018 > 204.152.189.116.80: S 2786942165:2786942165(0) win 5840 
	<mss 1460,sackOK,timestamp 269093190,nop,wscale 7> (DF)

00:46:32.097745 204.152.189.116.80 > 192.168.1.4.34018: S 2888442437:2888442437(0) 
	ack 2786942166 win 5792 <mss 1460,sackOK,timestamp 3563902477 26909319,nop,wscale 0> (DF)
	                                                                                  ^
00:46:32.098170 192.168.1.4.34018 > 204.152.189.116.80: . ack 1 win 45 
	<nop,nop,timestamp 26909481 3563902477> (DF)

So I would rule out 1), as this is a network that does not have the problem. 

> 2) non-zero window option being patched into a zero window
>    scale option

This looks more likely, on the outgoing SYN. We'll know tomorrow evening
(CEST) or earlier if somebody with the problem volunteers.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
