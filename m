Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281663AbRK0RNd>; Tue, 27 Nov 2001 12:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281678AbRK0RNY>; Tue, 27 Nov 2001 12:13:24 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:7442 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281759AbRK0RNH>; Tue, 27 Nov 2001 12:13:07 -0500
Message-ID: <3C03C96D.B3ACA982@zip.com.au>
Date: Tue, 27 Nov 2001 09:12:13 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ahmed Masud <masud@googgun.com>
CC: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <Pine.LNX.4.33.0111261825340.15932-100000@xanadu.home> <000901c17723$b641c990$8604a8c0@googgun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmed Masud wrote:
> 
> Just to add to the above something I've experienced:
> 
> 2.4.12 - 2.4.14 on a number of AMD Athelon 900 with 256 MB
> RAM doing serial I/O would miss data while any DISK writes would
> occure.

Two possibilities suggest themselves:

- Interrupt latency.   Last time I checked (a year ago), the worst-case
  interrupt latency of the IDE drivers was 80 microseconds on a 500MHz PII.
  That was with `hdparm -u 1'.   That's pretty good.

  Could you please confirm that you're using `hdparm -u 1' against the
  relevant disk?

- The serial port is working OK, but the application which is handling
  serial IO is blocked on a disk read (something got paged out), and
  that disk read fails to complete by the time the serial port buffer
  fills up.

  I'll send you a patch which makes the VM less inclined to page things
  out in the presence of heavy writes, and which decreases read
  latencies.

Thanks.
