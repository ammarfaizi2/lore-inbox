Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132678AbRDKRVC>; Wed, 11 Apr 2001 13:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132680AbRDKRUx>; Wed, 11 Apr 2001 13:20:53 -0400
Received: from admin.csn.ul.ie ([136.201.105.1]:46607 "HELO admin.csn.ul.ie")
	by vger.kernel.org with SMTP id <S132678AbRDKRUm>;
	Wed, 11 Apr 2001 13:20:42 -0400
Date: Wed, 11 Apr 2001 18:20:29 +0100 (IST)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: <airlied@skynet>
To: <Imran.Patel@nokia.com>
Cc: <ak@suse.de>, <netfilter-devel@us5.samba.org>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: skb allocation problems (More Brain damage!)
In-Reply-To: <2D6CADE9B0C6D411A27500508BB3CBD063CF2D@eseis15nok>
Message-ID: <Pine.LNX.4.32.0104111820120.15099-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What compiler are you using to compile the kernel?

Dave.

On Wed, 11 Apr 2001 Imran.Patel@nokia.com wrote:

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
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


