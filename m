Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279416AbRKARpe>; Thu, 1 Nov 2001 12:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279418AbRKARpY>; Thu, 1 Nov 2001 12:45:24 -0500
Received: from ns.suse.de ([213.95.15.193]:11780 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279416AbRKARpM>;
	Thu, 1 Nov 2001 12:45:12 -0500
Date: Thu, 1 Nov 2001 18:45:11 +0100
From: Andi Kleen <ak@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: Andi Kleen <ak@suse.de>, joris@deadlock.et.tudelft.nl,
        linux-kernel@vger.kernel.org
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
Message-ID: <20011101184511.A22234@wotan.suse.de>
In-Reply-To: <p733d3yr2b1.fsf@amdsim2.suse.de> <200111011733.UAA26651@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <200111011733.UAA26651@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Nov 01, 2001 at 08:33:15PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 08:33:15PM +0300, A.N.Kuznetsov wrote:
> Generally packet sockets MUST NOT tap on output packets. No differences

First if you really meant this dev_xmit_nit() (which you added) could be 
removed. But I see no reason for this MUST NOT; IMHO it is a valid use
case to tap outgoing packets.

> of socket of another protocols. UDP does not tap output right?
> What the hell packet socket should do this?

Packet sockets are a little bit more 'raw' than UDP sockets; and for
sniffing it makes sense and people expect it.

It's also kind of promised by having a PACKET_OUTGOING type.

Now of course if you would be serious with this dev_queue_xmit would 
need to be removed, making it impossible to debug/sniff local protocols
without an external sniffer. That would be of course very broken. 
So it has to be kept. But then allowing it for ETH_P_ALL only is really
ugly imho; if the feature exists it should be implemented for the full
packet functionality which includes binding to protocols.


> Snapping on output is feature which must be regulated by a separate option.

 When dev_xmit_nit is already there it is easy enough to do it, so no reason
 to add such complications.

> And to be honest I see no tragedy, if this option will not exist for sockets
> bound to specific protocols.

 I think the patch should be added.

 -Andi
