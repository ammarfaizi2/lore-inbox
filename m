Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287196AbRL2NQo>; Sat, 29 Dec 2001 08:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287197AbRL2NQe>; Sat, 29 Dec 2001 08:16:34 -0500
Received: from mout1.freenet.de ([194.97.50.132]:16059 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S287196AbRL2NQV>;
	Sat, 29 Dec 2001 08:16:21 -0500
Message-ID: <3C2DC1AA.2070106@athlon.maya.org>
Date: Sat, 29 Dec 2001 14:14:18 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011225
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C2CD326.100@athlon.maya.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann wrote:

> Hello all,
> 
> Again, I did a rsync-operation as described in
> "[2.4.17rc1] Swapping" MID <3C1F4014.2010705@athlon.maya.org>.
> 

Some other examples:
I just did a
cp -Rd linux-2.4.16 linux-2.4.17
(with object-files). Before starting this action, I had about 120 MB of 
free RAM. During copying - I did nothing else meanwhile, there was 2MB 
swap used - and 12 MB of RAM were free. The biggest part of memory was 
used for caching - what is ok.
After copying, only 10 MB of memory have been given free again. There 
have been 490MB of RAM used now (nearly most for caching).

Outgoing from this situation, I started another little cp-action:
cp -Rd linux-2.4.18pre1 linux-2.4.test
(again including object files).
Result: the swap usage stayed nearly constant, neverthless there have 
been 6 accesses to swap.

Now, I deleted the linux-2.4.test-directory with
rm -R linux-2.4.test
This action was very fast (approximately 1s).

Afterwards, a big part of the cache memory has been given free (about 
100MB). Now, 122MB of RAM have been free again.

Next example (running after the last):
SuSE run-crons have been running. This means:
-> updatedb
-> sort
-> frcode
-> find
-> mandb

47MB swap used, 2/3 of memory is used for buffers (Don't forget: I've 
got 512MB of RAM) and about 30MB of RAM are free.


My observation:
Why does the kernel swap to get free memory for caching / buffering? I 
can't see any sense in this action. Wouldn't it be better to shrink the 
cashing / buffering-RAM to the amount of memory, which is obviously free?

Swapping should be principally used, if the RAM ends for real memory 
(memory, which is used for running applications). First of all, the 
memory-usage of cache and buffers should be reduced before starting to 
swap IMHO.

Or would it be possible, to implement more than one swapping strategy, 
which could be configured during make menuconfig? This would give the 
user the chance to find the best swapping strategy for his purpose.



Regards,
Andreas Hartmann

