Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271961AbRIMRxz>; Thu, 13 Sep 2001 13:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271942AbRIMRxg>; Thu, 13 Sep 2001 13:53:36 -0400
Received: from unused ([12.150.234.220]:48635 "EHLO one.isilinux.com")
	by vger.kernel.org with ESMTP id <S271941AbRIMRx3>;
	Thu, 13 Sep 2001 13:53:29 -0400
Message-ID: <3BA0F2AB.1050100@interactivesi.com>
Date: Thu, 13 Sep 2001 12:53:47 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: Timothy Hamlin <thamlin@zeus.nmt.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: questions of a kernel-newbie, simple ISA driver
In-Reply-To: <Pine.LNX.4.30.0109131124420.20602-100000@zeus.lma.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Hamlin wrote:

 > Driver polls for the 1/2 full FIFO flag, when found transfer 16k words out
 > of the FIFO and place this in a larger buffer, say 320k or something.

The driver should instead poll the device at regular, adjustable intervals, 
and read ALL the data it can at each interval.  Assuming the hardware allows 
that, of couse.

 > How would I maintain this buffer?  Reads to the /dev entry need to be able
 > to get a continuous stream from the device, how do I keep the buffer both
 > filling, and being read out at the same time?  Should I make the buffer a
 > FIFO as well?  How?  How do I keep track of what has been read from the
 > buffer, so that subsequent reads get new data, not data that is lower down
 > in the buffer?

This is a basic, first-year computer science question.  Just use a circular 
buffer.  You can get the algorithm from any CS book.

 >  Can I allow multiple processes to be reading from this
 > /dev entry without loosing data to any of them?

Sure, just use one circular buffer per process.

 > Also, when I read for a device like a serial port I can just do cat
 > /dev/ttyS0 and watch the stream coming in.  So far in my driver, a read
 > performs one operation, outputs whatever, and then stops.  So a cat of my
 > device only transfers the current data, and then just sits there.  How do
 > I keep that steam going so that a cat will continually update?

Increase the rate at which you read the hardware FIFO.  Or perhaps, use the 
reads to your /dev device as a trigger to get more data from the HW.

