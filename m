Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267719AbTBUVrU>; Fri, 21 Feb 2003 16:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267720AbTBUVrU>; Fri, 21 Feb 2003 16:47:20 -0500
Received: from web8007.mail.in.yahoo.com ([203.199.70.94]:49669 "HELO
	web8007.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id <S267719AbTBUVrT>; Fri, 21 Feb 2003 16:47:19 -0500
Message-ID: <20030221215721.71135.qmail@web8007.mail.in.yahoo.com>
Date: Fri, 21 Feb 2003 21:57:21 +0000 (GMT)
From: =?iso-8859-1?q?Yours=20Lovingly?= <ylovingly@yahoo.co.in>
Subject: strange but consistent feature of linux nfs client
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The linux nfs client (at least the one in 2.4.19)
shows one characteristic :
Consider a client side benchmark that creates a file
across nfs, writes some data into it, reads this data
back, modifies it and writes it back, finally reading
it again and closing. (Assume that there isn't any
other client operating on this nfs mounted filesystem
that could pose a threat to the cached data validity
on our client)
Thus the order is like :
write-read-write-read

I observed without exception in all test runs that the
second write-read combination had the read succeeding
to find the data in the local cache(after suitable
revalidation etc) while the first read operation in
each individual test run never found the data in the
local cache(although the first write too like the
second write was done through the pagecache) or
whatever but invariably made an on the wire read -
always.

So what is special - first time reads/first time
writes and why,
and how is this speciality affected in the kernel.

thanks a lot
Abhishek

________________________________________________________________________
Missed your favourite TV serial last night? Try the new, Yahoo! TV.
       visit http://in.tv.yahoo.com
