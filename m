Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290965AbSBVBna>; Thu, 21 Feb 2002 20:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290987AbSBVBnU>; Thu, 21 Feb 2002 20:43:20 -0500
Received: from relay1.pair.com ([209.68.1.20]:29712 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S290965AbSBVBnJ>;
	Thu, 21 Feb 2002 20:43:09 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C75A418.2C848B3F@kegel.com>
Date: Thu, 21 Feb 2002 17:51:20 -0800
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Zach Brown <zab@zabbo.net>
Subject: is CONFIG_PACKET_MMAP always a win?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Newbie gig-ethernet question here.
I'm helping somebody implement a program that needs to process
raw packets as close to wire rate as is possible.  We're
using kernel 2.4.16 or so.

What's the best way to retrieve raw packets from the kernel?

a) use libpcap
   Overhead: a little bit worse than the best of any of the other options?

b) use af_packet, and call recvfrom or recvmsg myself for each packet
   Overhead: one full memcpy of the packet body and one 
   system call per packet.

c) enable CONFIG_PACKET_MMAP, use PACKET_RX_RING, and read packets from an mmap'd ring buffer
   Overhead: kernel does a full memcpy of the packet body to get it
   into the ring buffer, and my program does another to get it out.

If I understand it right, b costs one memcpy and one recv, and c costs
two memcpys.  Which one wins?

I guess I should benchmark these alternatives myself, but before I do,
does anyone know of a good place to look for this info?  Maybe
I'm reinventing the wheel here.

Thanks,
Dan
