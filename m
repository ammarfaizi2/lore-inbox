Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310549AbSCXQ6R>; Sun, 24 Mar 2002 11:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310577AbSCXQ6H>; Sun, 24 Mar 2002 11:58:07 -0500
Received: from mout1.freenet.de ([194.97.50.132]:35000 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S310549AbSCXQ57>;
	Sun, 24 Mar 2002 11:57:59 -0500
Message-ID: <3C9E060B.5080603@freenet.de>
Date: Sun, 24 Mar 2002 17:59:55 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020323
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Rik van Riel <riel@conectiva.com.br>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <E16pBGB-0006gE-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>Advantage of combining consumption-speed and memory usage per process 
>>would be, that processes could be filtered, which are obviously broken. 
>>If the behaviour of the process is correct, than the machine hasn't 
>>enough memory. But this is a problem, which cannot be handled by the kernel.
> 
> 
> With 2.4.19pre3-ac3+ you don't need a heuristic. Do
> 
> 	echo "2" >/proc/sys/vm/overcommit_memory
> 
> The system will then fail allocations before they can cause an OOM status.
> It might be interesting to add "except root" modes to this.
> 
> Alan

If I would ad the option "except root", I would have the same problem, 
because rsync must run as root to do a full backup :-(.

If I understand this feature right, always this process gets a problem, 
which want's to have memory even if there is no more free. It could be 
the wrong process too.
But if a process gets wild like rsync in this situation, it's very 
likely that rsync is the first which doesn't get no more memory. But 
what's afterwards if it didn't get any more memory?
If the process, which wants to have so much memory, isn't stopped (or 
doesn't stop itself), the memory situation isn't getting better. Other 
processes, which are working right, will probably fail while the broken 
process eats up the new free mem again.

I think that a broken process like rsync should be killed in order to 
prevent other processes to be damaged indirectly.

Regards,
Andreas Hartmann

