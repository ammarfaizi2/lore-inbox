Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130327AbRBEV0V>; Mon, 5 Feb 2001 16:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131567AbRBEV0K>; Mon, 5 Feb 2001 16:26:10 -0500
Received: from pcow028o.blueyonder.co.uk ([195.188.53.124]:59914 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S130327AbRBEVZ7>;
	Mon, 5 Feb 2001 16:25:59 -0500
Date: Mon, 5 Feb 2001 21:20:09 +0000
From: Michael Pacey <michael@wd21.co.uk>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org, aia21@cam.ac.uk, michael@wd21.co.uk
Subject: Re: [Patch] [Repost] 3Com 3c523: Can't load module in kernel 2.4.1
Message-ID: <20010205212009.B425@kermit.wd21.co.uk>
In-Reply-To: <Pine.LNX.4.30.0102051034450.22075-100000@iso-2146-l1.zeusinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.30.0102051034450.22075-100000@iso-2146-l1.zeusinc.com>; from ttsig@tuxyturvy.com on Mon, Feb 05, 2001 at 15:50:26 +0000
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Feb 2001 15:50:26 Tom Sightler wrote:

> Anyway, here's the patch again, hope it works this time.  It includes the
> following changes:
> 
> - fix addresses with bus_to_virt
> - reduce xmit buffers from 4 to 1 (puts driver in noop mode like ni52
> driver)
> - increase recv buffers from 6 to 9 (should help decrease dropped
> packets)
> - add short delay to detect routine (makes cards detectable on fast
> machines)
> - use eth_copy_and_sum for receiving packets
> 
> It passed basic stress testing with multiple, simultaneous ftp transfers.
> 
> Known bugs:
> 
> - Multicast still doesn't work at all (I have patches that seem to fix
> this but they have other problems)
> - Still drops packets under heavy traffic (can be reduced further by
> lowering MTU on interface)
> - Sometimes requires host to send a packet before it starts receiving (I
> can't reproduce this on my equipment anymore, but needs more testing)
> 
> Anyone with this card please test and report back.
> 

This works for me. I had to frig the patch file though (I think /my/ mailer
(balsa) was screwing it up though).

I did an NFS transfer of ~100Mb file (a tar of linux 2.4.1). Details:

10Base2 Co-ax segment, lightly used, shared with one other machine.
Transfer rate: 5,854,215 Mbit/s
Overruns: 18

I didn't check what the overruns were prior to the transfer but all I had
done was the NFS mount and couple of directory listings.

I'm very happy with this; under 2.2.17 with this card, I was getting about
1Mbyte per minute for an NFS transfer. My friend thanks you too.

--
Michael Pacey
michael@wd21.co.uk
ICQ: 105498469

wd21 ltd - world domination in the 21st century

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
