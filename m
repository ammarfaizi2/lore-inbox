Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315201AbSDWNqG>; Tue, 23 Apr 2002 09:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSDWNqF>; Tue, 23 Apr 2002 09:46:05 -0400
Received: from jalon.able.es ([212.97.163.2]:22718 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315201AbSDWNp7>;
	Tue, 23 Apr 2002 09:45:59 -0400
Date: Tue, 23 Apr 2002 15:45:49 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Frank Louwers <frank@openminds.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Message-ID: <20020423134549.GA2048@werewolf.able.es>
In-Reply-To: <20020423113935.A30329@openminds.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.23 Frank Louwers wrote:
>Hi,
>
>We recently stummed across a rather annoying bug when 2 nics are on
>the same network.
>
>Our situation is this: we have a server with 2 nics, each with a
>different IP on the same network, connected to the same switch. Let's
>assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
>netmask of 255.255.255.0.
>
>Now the strange thing is that traffic for 1.2.3.2 arrives at eth0 no
>matter what!
>

>From wht I understand for net, interface selection for a connection is
done based on network address. So if you first configure eth0 with
mask 255.255.255.0, and a subnet of 1.2.3.0,
and eth1 is configured just the same (ip adresses only
differ in last number), the kernel just uses the first interface it
founds for a subnet. To prove this, you could try to load the interfaces
in reverse order, and all traffic should go to eth1.

Do you really need the two interfaces to be in the same subnet ? I use
tw parallel nets for a cluster, but configured both as independent
subnets, 10.0.0.0 and 10.0.1.0. So you can drive all nfs through one
interface mounting the server as 10.0.0.1, and all the bproc traffic
through the other (or all the ssh through the other connecting
always to 10.0.1.1).

Hope this helps.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam5 #1 SMP mar abr 23 01:29:38 CEST 2002 i686
