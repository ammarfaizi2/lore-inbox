Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291099AbSBGEie>; Wed, 6 Feb 2002 23:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291104AbSBGEiY>; Wed, 6 Feb 2002 23:38:24 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:53771 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S291099AbSBGEiI>; Wed, 6 Feb 2002 23:38:08 -0500
Date: Wed, 6 Feb 2002 23:37:57 -0500 (EST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Ben Greear <greearb@candelatech.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <3C620131.9090606@candelatech.com>
Message-ID: <Pine.LNX.4.44.0202062325480.4832-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Ben Greear wrote:

> >>From the limited testing I just ran, I appears that starfire and 3c59x 
> > handle this correctly, whereas tulip always loses a small number of 
> > packets during a UDP storm. ttcp -us[rt] is very useful for such 
> > testing...
> 
> It would be interesting to see which side is dropping?  Have you
> coorelated ethernet driver counters to your sendto count?

It's hard for me to do it right now, because I don't have them in 
isolation (they do NFS and other stuff), and I don't have iptables support 
compiled into the kernel running the tulip. However:

starfire -> 3c59x
3c59x -> starfire
tulip -> 3c59x
tulip -> starfire

never lose data on a quiescent network:

ttcp-t: 83886080 bytes in 7.04 real seconds = 11640.36 KB/sec +++
ttcp-r: 83886080 bytes in 7.04 real seconds = 11641.10 KB/sec +++

whereas

3c59x -> tulip
starfire -> tulip

*always* lose several packets:

ttcp-t: 16777216 bytes in 1.40 real seconds = 11717.40 KB/sec +++
ttcp-r: 16769024 bytes in 1.40 real seconds = 11679.39 KB/sec +++

and

ttcp-t: 33554432 bytes in 2.80 real seconds = 11714.81 KB/sec +++
ttcp-r: 33456128 bytes in 2.80 real seconds = 11660.28 KB/sec +++

and

ttcp-t: 83886080 bytes in 7.00 real seconds = 11704.40 KB/sec +++
ttcp-r: 83722240 bytes in 7.00 real seconds = 11674.67 KB/sec +++

So I would tend to blame it on the tulip -- but the Rx side of it, not the 
Tx, which this discussion was about...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

