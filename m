Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281677AbRKUIwk>; Wed, 21 Nov 2001 03:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281680AbRKUIwa>; Wed, 21 Nov 2001 03:52:30 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:59396 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S281677AbRKUIwT>; Wed, 21 Nov 2001 03:52:19 -0500
Message-ID: <3BFB6B09.1060103@namesys.com>
Date: Wed, 21 Nov 2001 11:51:21 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: en-us
MIME-Version: 1.0
To: Frank de Lange <lkml-frank@unternet.org>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>,
        Chris Mason <mason@suse.com>
Subject: Re: Abysmal interactive performance on 2.4.linus
In-Reply-To: <20011112205551.A14132@unternet.org> <3BF02BA4.D7E2D70E@mandrakesoft.com> <20011112235642.A17544@unternet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank de Lange wrote:

>On Mon, Nov 12, 2001 at 03:05:56PM -0500, Jeff Garzik wrote:
>
>>Can you try 2.4.13ac6 (not 7/8), and 2.2.20, and post a comparison?
>>
>
>Here's the results from some tests I did:
>
>2.2.20
>======
>without filesystem activity
>no slowdowns observed
>time ls -al /usr/|sort -k 5 -n
>real	0m0.121s
>user	0m0.000s
>sys	0m0.090s
>
>with filesystem activity on ext2
>no slowdowns observed
>time ls -al /opt/|sort -k 5 -n
>real	0m0.079s
>user	0m0.010s
>sys	0m0.100s
>
>2.4.13-ac5
>==========
>no slowdowns observed
>without filesystem activity
>time ls -al /usr/|sort -k 5 -n
>real	0m0.142s
>user	0m0.000s
>sys	0m0.000s
>
>with filesystem activity on ext2
>no slowdowns observed
>time ls -al /opt/|sort -k 5 -n
>real	0m0.022s
>user	0m0.020s
>sys	0m0.010s
>
>with filesystem activity on reiserfs
> - it took 31 seconds to just open this small ( < 1 kb) text file (which
>   resides in my home directory, on an ext2 filesystem) in vi...
>time ls -al /usr/|sort -k 5 -n
>real    0m6.136s
>user    0m0.020s
>sys     0m0.020s
>
>
>2.4.15-pre4
>===========
>without filesystem activity
>no slowdowns observed
>time ls -al /usr/|sort -k 5 -n
>real	0m0.081s
>user	0m0.010s
>sys	0m0.010s
>
>with filesystem activity on ext2
>no slowdowns observed
>time ls -al /usr/|sort -k 5 -n
>real    0m0.146s
>user    0m0.000s
>sys     0m0.020s
>
>with filesystem activity on reiserfs
>system behaviour erratic, some slowdowns
>time ls -al /opt|sort -k5 -n
>real    0m13.232s
>user    0m0.020s
>sys     0m0.010s
>
>Seems that reiserfs is the common factor here, at least on my box. This is a 35
>GB reiserfs filesystem, app 80% used, both large and small files.
>
>As said in my previous message, the numbers themselves don't mean squat. It is
>the large delays (the fact that user+sys <<< real) which are the problem here.
>
>Any other magic anyone wants me to perform? Hans, you reading this?
>
>Cheers//Frank
>
Yura, see if you can reproduce this and analyze the cause.  If I 
understand correctly, he is saying the problem is not throughput but 
latency.  Is that correct Frank?  Once Yura reproduces it, I will 
speculate as to the cause.

Hans


