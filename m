Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283634AbRK3MWk>; Fri, 30 Nov 2001 07:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283635AbRK3MWa>; Fri, 30 Nov 2001 07:22:30 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:23825 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S283634AbRK3MWL>; Fri, 30 Nov 2001 07:22:11 -0500
Message-ID: <3C0779BD.7090604@namesys.com>
Date: Fri, 30 Nov 2001 15:21:17 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org,
        reiserfs-dev@namesys.com
Subject: Re: Block I/O Enchancements, 2.5.1-pre2
In-Reply-To: <Pine.LNX.4.33.0111271933100.1195-100000@penguin.transmeta.com> <E169dGg-0000iO-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On November 28, 2001 04:38 am, Linus Torvalds wrote:
>
>>We will probably _not_ get 64-bit page index numbers, though. I don't want
>>to make the page structure bigger/slower for very little gain. So the page
>>cache is probably going to be limited to about 44 bits (45+ if people
>>start doing large pages, which is probably worth it). So there would still
>>be partition/file limits on the order of 16-64 TB in the next few years.
>>
>
>The Ext2+ crowd is actively working on preparing for the world of larger 
>blocks, so that 64KB blocks will be entirely practical.  This will get us to 
>1/4 Petabyte, still with 32 bit block pointers internally.  The main problem 
>that has to be solved is internal fragmentation.
>

This is a bad idea for general purpose usage patterns.  The problem is 
that if you cure the internal fragmentation problem like reiserfs did, 
you are still going to be left with a memory bandwidth consumption that 
is proportional to the size of nodes, because inserting an 8 byte item 
is likely to cause a shift of contents proportional to node size.  

We need to go to 64 bit blocknumbers and 64 bit inode numbers.  If we 
are not going to do this, well, I really need to change the design of 
Reiser4, as I was just assuming it would be done.  We get some nice 
simplicities out of never reusing objectids (with 64 bits, you never run 
out of them, the math for what it takes to run out of them assuming you 
use a trillion a second is a bit amusing.)

I recommend the use of 64 bits for inode numbers and blocknumbers plus 
the use of compression (effective for filesystems small enough to not 
use all 64 bits) for those who dislike the byte wastage.

Hans

