Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284890AbRLKFMm>; Tue, 11 Dec 2001 00:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284905AbRLKFMc>; Tue, 11 Dec 2001 00:12:32 -0500
Received: from bluebox.ne.mediaone.net ([24.128.139.92]:59400 "EHLO
	osiris.978.org") by vger.kernel.org with ESMTP id <S284890AbRLKFMO>;
	Tue, 11 Dec 2001 00:12:14 -0500
Date: Tue, 11 Dec 2001 00:12:14 -0500
From: Brian Ristuccia <brian@ristuccia.com>
To: linux-kernel@vger.kernel.org
Cc: familiar@handhelds.org
Subject: how to receive UDP packet at interface from interface's IP
Message-ID: <20011211001213.X22467@osiris.978.org>
Mail-Followup-To: brian@ristuccia.com, linux-kernel@vger.kernel.org,
	familiar@handhelds.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm currently working on getting status reporting going on my merlin CDPD
modem. The merlin is a PCMCIA type II card that works as a standard serial
device and can be made to talk SLIP or PPP by issuing certain Hayes-style AT
commands. Combined with a handheld PC like the Compaq IPAQ, it makes a great
tool for remote system administration, email, text web browsing, etc.

One nifty thing about the modem is that while in SLIP or PPP mode, one can
send a UDP packet to 10.0.0.1:4950. Using a protocol called MSCI, the modem
will let you query things like signal strength, link quality, etc. But my
problem is that the modem sends the response UDP packets with the source and
destination IP address both matching that of the PPP interface to which the
modem is attached and I never see the data on my listening socket. For
example, if the PPP interface's IP address was 192.168.0.100, the packets
would come from 192.168.0.100 to 192.168.0.100. Even when I disable
rp_filter, I can not receive the packets on my listening socket. I can see
the packets with tcpdump, but they never make it to the socket.

Is there any reason why the kernel is not sending the contents of these
packets to the socket? If so, is there an easy way to change the behavior?
I've looked in net/ipv4/ at files ip_input.c fib_frontend.c and udp.c, but I
can't see where the packet might be getting discarded. Is there any way to
receive this type of packet through a normal UDP socket, or should I just
hack up a userspace workaround with libpcap?

Any hints will be very much appreciated. Thanks.

(Please respect my Mail-Followup-To header when replying).

-- 
Brian Ristuccia
brian@ristuccia.com
bristucc@cs.uml.edu
