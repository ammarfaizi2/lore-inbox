Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129255AbQLJEuQ>; Sat, 9 Dec 2000 23:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLJEuG>; Sat, 9 Dec 2000 23:50:06 -0500
Received: from Cantor.suse.de ([194.112.123.193]:31758 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129255AbQLJEt4>;
	Sat, 9 Dec 2000 23:49:56 -0500
Date: Sun, 10 Dec 2000 05:19:23 +0100
From: Andi Kleen <ak@suse.de>
To: Gerard Paul Java <gerardj@cebu.mozcom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PF_PACKET and Token Ring
Message-ID: <20001210051923.A14451@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.03.10011291143490.10359-100000@cebu.mozcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.03.10011291143490.10359-100000@cebu.mozcom.com>; from gerardj@cebu.mozcom.com on Wed, Nov 29, 2000 at 11:47:08AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 11:47:08AM +0800, Gerard Paul Java wrote:
> 
> Hi,
> 
> I'm trying to capture IP packets over a Token Ring network through a
> (PF_PACKET, SOCK_RAW) socket, but for some
> reason the sll_protocol field in the sockaddr_ll structure doesn't
> contain ETH_P_IP for IP packets but rather contains 0x100 (of course, in
> network byte order).
> 
> Is this a bug, or is it expected behavior?

0x100 is ETH_P_802_3. This happens because some token ring packets
with an 802.3 header pass twice through the tap -- once to go to the
SNAP handler and then again afterwards to the final protocol. For IP
and ARP it should not happen though, because these take shortcuts and
only go once. You're probably seeing some other packet.

On the one hand it smells like a bug, on the other hand it is probably
not worth fixing because it is similar to the loopback or the tunnel devices 
showing you packets multiple times.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
