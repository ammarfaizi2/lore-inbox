Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132935AbRDKTDf>; Wed, 11 Apr 2001 15:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132933AbRDKTDZ>; Wed, 11 Apr 2001 15:03:25 -0400
Received: from mgw-x4.nokia.com ([131.228.20.27]:34991 "EHLO mgw-x4.nokia.com")
	by vger.kernel.org with ESMTP id <S132935AbRDKTDJ>;
	Wed, 11 Apr 2001 15:03:09 -0400
Message-ID: <2D6CADE9B0C6D411A27500508BB3CBD063CF32@eseis15nok>
From: Imran.Patel@nokia.com
To: ak@suse.de, Imran.Patel@nokia.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: RE: skb allocation problems (More Brain damage!)
Date: Wed, 11 Apr 2001 22:02:46 +0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What you can try is to turn on slab debugging. Set the  FORCED_DEBUG
> define in mm/slab.c to one and recompile. Does it change any pattern
> when you dump the data in the skbs or pings? 
> If yes someone is playing with already freed packets.

I think the dump that i got suggests something more strange than that. This
is what i can make of the dump:

this is the ip header (with src addr: 192.168.102.22 and dest addr:
192.168.10.29)
45 0 0 80 0 0 40 0 ff 1 2d f8 c0 a8 66 16 c0 a8 66 1d 

this is the icmp header (echo reply)
0 0 e4 48 11 d 0 0 

the regular ping data follows
14 5d d4 3a 63 1 a 0 8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c
1d
1e 1f 20 21 22 23 

Now, it is expecting 24, 25, 26,.....but the outer ip & icmp header and data
(as above) follows again....
45 0 0 80 0 0 40 0 ff 1 2d f8 c0 a8 66 16 c0 a8 66 1d 0 0
0 0 11 d 0 0 14 5d d4 3a 63 1 a 0 8 9 a b c d e f 10 11 12 13 14 15 16 17 18
19 1a 1b 1c 1d 1e 1f 20 21 22 23

it is very hard to imagine the scenario which can lead to this...
I will try your suggestion..

> And what NIC are you using btw?
as i said earlier, Intel Ethernet Pro 100...

imran

