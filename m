Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287537AbSANQLh>; Mon, 14 Jan 2002 11:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287535AbSANQL1>; Mon, 14 Jan 2002 11:11:27 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:57009 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S287537AbSANQLR>;
	Mon, 14 Jan 2002 11:11:17 -0500
Message-ID: <3C430323.6060707@candelatech.com>
Date: Mon, 14 Jan 2002 09:11:15 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RFC:  Multi-packet read/write for packet sockets?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a performance critical application that reads packets, both
UDP and Ethernet, from the kernel into user space.  When there are
lots of small packets, the program performs relatively poorly....
Recently, while recovering from a really abusive day of snowboarding,
I started thinking about this problem, and I would like to see what
you all think of a potential solution...

Basically, I want a new read method that is something like this:

int mread(int fd, char* buffer, int buffer_size, int* offsets, int offsets_size);

offsets will be an array of integers that the kernel will fill out,
and offsets_size is the length of the array of offsets...

The basic idea is that under heavy load, I expect there to be multiple packets
to be read by the time I get to servicing that file-descriptor.  The mread
call could grab multiple packets at once, packing them into the buffer.
User-space code can delineate packets by looking at the offsets.  Determining
how many packets were read could be done by looking at the return of mread
(the number of bytes read) and the offsets array.  It could also be returned
in another variable if desired....

The kernel knows the max number of packets that can be read based on offsets_size,
as well as buffer limitations due to the size of buffer.

The mread method could be used on UDP and RAW packets at least.  It would
be completely worthless for stream-based sockets like TCP...

Comments welcome...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


