Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSCaMgw>; Sun, 31 Mar 2002 07:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312532AbSCaMgm>; Sun, 31 Mar 2002 07:36:42 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:39053 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S312526AbSCaMga>; Sun, 31 Mar 2002 07:36:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Randy Hron <rwhron@earthlink.net>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: Linux 2.4.19-pre5
Date: Sun, 31 Mar 2002 07:42:15 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <20020330135333.A16794@rushmore> <E16rRCX-00068U-00@avocet.prod.itd.earthlink.net> <1017532120.641.75.camel@psuedomode>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16reZK-0001IL-00@pintail.mail.pas.earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In this test I wanted to see this lag.  

Just to be clear on what the "max latency" number is, it's the I/O
request within tiobench that waited the longest.  I.E. The process notes
the time before it's ready to make the request, then notes the time
after the request is fullfilled.  With a 2048MB file and a 4096 byte
block, there may be over 500,000 requests.  

It's a relatively small number of requests that have the big latency
wait, so depending on the I/O requests your other applications make
during the test, a long wait may not be obvious, unless one or your
I/O's gets left at the end of the queue for a long time. 

This is sometimes referred to as a "corner case".  

The point where the "# of threads" manifests the "big latency
wall" is to note a dramatic change in longest I/O latency. This
point varies between the kernel trees.

The "big latency phenomenon" has been in the 2.4 tree at least
since 2.4.17 which is the first kernel I have this measurement
for.  It probably goes back much further.

read_latency2
-------------
I tested read_latency2 with 2.4.19-pre5.    pre5 vanilla hits
a wall at 32 tiobench threads for sequential reads.  With
read_latency2, the wall is around 128.

For random reads, pre5 hits a wall at 64 threads.  With
read_latency2, the wall is not apparent even with 128 threads.

read_latency2 appears to reduce sequential write latency
too, but not as dramatically as in the read tests.

