Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318638AbSHUSki>; Wed, 21 Aug 2002 14:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318642AbSHUSki>; Wed, 21 Aug 2002 14:40:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19359 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318638AbSHUSkh>; Wed, 21 Aug 2002 14:40:37 -0400
Message-ID: <1029955373.3d63df2d7d598@imap.linux.ibm.com>
Date: Wed, 21 Aug 2002 11:42:53 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: manand@us.ibm.com
Subject: Re: (RFC): SKB Initialization
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.65.17.188
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch reduces the numer of cylces by 25%

Er, I'm not getting that from just the numbers you show.

The total ave number of cycles in alloc_skb before is approx 268.

Total number of cycles in alloc_skb after is approx 468. 

So in order to reduce the total ave number of cycles, you
need __kfree_skb to reduce by more than approx 200. (Since
thats where you moved the code to).

So unless we see the total cycles in __kfree_skb, how
do we know? Or what am I missing?

thanks,
Nivedita


You said:



                                CPU 0                 CPU 1
                               ------                 ------
Avg cycles in alloc_skb:        64.05                 203.39
Avg cycles in __kfree_skb:     127.54                 228.95
                               ------                 -------
Total Avg Cycles               191.59                 432.34
                               ------                 -------

# of times alloc_skb called:      235,478            2,060,422
# of times __kfree_skb called:  2,063,276              232,359


Linux 2.5.25+Skbinit Patch:
--------------------------
                              CPU 0                   CPU 1
                              -----                   -----
 Avg cycles in alloc skb:     237.21                  230.91

 # of times alloc_skb called: 1,226,594             1,213,327





