Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315209AbSDWN6p>; Tue, 23 Apr 2002 09:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315212AbSDWN6o>; Tue, 23 Apr 2002 09:58:44 -0400
Received: from [24.93.67.52] ([24.93.67.52]:28677 "EHLO mail5.nc.rr.com")
	by vger.kernel.org with ESMTP id <S315209AbSDWN6i>;
	Tue, 23 Apr 2002 09:58:38 -0400
Message-ID: <3CC56883.9020506@nc.rr.com>
Date: Tue, 23 Apr 2002 09:58:27 -0400
From: Harley Stenzel <hstenzel@nc.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
In-Reply-To: <20020423113935.A30329@openminds.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Louwers wrote:
> Hi,
> 
> We recently stummed across a rather annoying bug when 2 nics are on
> the same network.
> 
> Our situation is this: we have a server with 2 nics, each with a
> different IP on the same network, connected to the same switch. Let's
> assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
> netmask of 255.255.255.0.
. . .
> 
> Is this a bug or a known issue? If it is not a bug, how can it be
> solved?

It is a known issue with 2.4 Linux kernels and ARP.  Linux will respond 
to arp requests for any address configured on the box on any interface 
that receives the arp request.  Patches have been proposed in the past, 
but the maintainers have elected to not accept the patches on the basis 
that the current behavior is RFC-compliant.  The behavior you describe 
is also RFC-compliant, and is in fact what the other OSes that I'm 
familiar with do.

In your situation, where you have a single nic that you want to use as 
backup only, you could set noarp on the backup nic.  Then, when you want 
to talk to the machine on the backup nic, you could use a static arp 
entry specifying the MAC address of the backup and any IP address on the 
box.

Alternatively, you could put the NICs on different physical segments or 
you could dig up the proposed patches (2.4.0,2,and 12 if I remember 
correctly) and port them forward and apply them.

> 
> Kind Regards,
> Frank Louwers
> 

--Harley Stenzel
   hstenzel@nc.rr.com

