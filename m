Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132688AbRDKRsR>; Wed, 11 Apr 2001 13:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132689AbRDKRsG>; Wed, 11 Apr 2001 13:48:06 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:48389 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132688AbRDKRr6>;
	Wed, 11 Apr 2001 13:47:58 -0400
Date: Wed, 11 Apr 2001 13:47:18 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: <Imran.Patel@nokia.com>
cc: <ak@suse.de>, <netfilter-devel@us5.samba.org>, <netdev@oss.sgi.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: skb allocation problems (More Brain damage!)
In-Reply-To: <2D6CADE9B0C6D411A27500508BB3CBD063CF2D@eseis15nok>
Message-ID: <Pine.LNX.4.30.0104111343380.31460-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Coudl the problem be in the NIC driver not in the alloc_skb?  I have used
both 2.4.{1,3} for some time and never seen this corruption.  I use ping
-f with various packet sizes for stress testing my IPSec boxes... these do
quite a bit of extra skb creation as an IPSec header sometimes does not
fit in the original skb.  No problems yet.

My gut tells me to blame the NIC driver of the NIC itself.

B.

On Wed, 11 Apr 2001, Imran.Patel@nokia.com wrote:

> > Well, I don't know then. You have to debug it. It's probably
> > something stupid
> > (if fundamental services like alloc_skb/kfree_skb were
> > completely buggy
> > someone surely would have noticed earlier)
>
> yep, at first i thought it was because of sume stupidity in my module...but
> now it seems that actually it is not my code which is doing something
> stupid....just now i have found out that even simple ping faces similar
> problems ....here is the output that i get when i ping from the host
> 192.168.102.29 (runs 2.4.1) to 192.168.102.22 (runs 2.4.3) (Note:I don't
> insert any kernel modules of my own on these machines):
>
>
> PING 192.168.102.22 (192.168.102.22) from 192.168.102.29 : 100(128) bytes of
> data.
> 108 bytes from hobbes.sr.ntc.nokia.com (192.168.102.22): icmp_seq=0 ttl=255
> time=36.5 ms
> wrong data byte #36 should be 0x24 but was 0x45
> 	19 45 d4 3a e 7a a 0 8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19
> 1a 1b 1c 1d 1e 1f
> 	20 21 22 23 45 0 0 80 0 0 40 0 ff 1 2d f8 c0 a8 66 16 c0 a8 66 1d 0
> 0 0 0 4 c 0 0
> 	19 45 d4 3a e 7a a 0 8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19
> 1a 1b
>
> --- 192.168.102.22 ping statistics ---
> 1 packets transmitted, 1 packets received, 0% packet loss
> round-trip min/avg/max = 36.5/36.5/36.5 ms
>
>
> Note that the problem starts with byte #36 which goes on like " 45 0 0 80 0
> ......." which is in fact the outer IP header!! So certainly there are
> buffer overruns on the other end (host 192.168.102.22)....
>
> And as a I said earlier, only ping packets with size within certain range
> create this problem......Something is terribly wrong here!! But as I am not
> a Linux mm guru, i can't tell what is wrong here!
>
>
> regards,
> imran
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
	WebSig: http://www.jukie.net/~bart/sig/


