Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRG0WbB>; Fri, 27 Jul 2001 18:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264375AbRG0Waw>; Fri, 27 Jul 2001 18:30:52 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:35593 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263918AbRG0Wao>; Fri, 27 Jul 2001 18:30:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-pre1 and dbench -20% throughput
Date: Sat, 28 Jul 2001 00:34:05 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200107272112.f6RLC3d28206@maila.telia.com>
In-Reply-To: <200107272112.f6RLC3d28206@maila.telia.com>
MIME-Version: 1.0
Message-Id: <0107280034050V.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 23:08, Roger Larsson wrote:
> Hi all,
>
> I have done some throughput testing again.
> Streaming write, copy, read, diff are almost identical to earlier 2.4
> kernels. (Note: 2.4.0 was clearly better when reading from two files
> - i.e. diff - 15.4 MB/s v. around 11 MB/s with later kenels - can be
> a result of disk layout too...)
>
> But "dbench 32" (on my 256 MB box) results has are the most
> interesting:
>
> 2.4.0 gave 33 MB/s
> 2.4.8-pre1 gives 26.1 MB/s (-21%)
>
> Do we now throw away pages that would be reused?
>
> [I have also verified that mmap002 still works as expected]

Could you run that test again with /usr/bin/time (the GNU time 
function) so we can see what kind of swapping it's doing?

The use-once approach depends on having a fairly stable inactive_dirty 
+ inactive_clean queue size, to give use-often pages a fair chance to 
be rescued.  To see how the sizes of the queues are changing, use 
Shift-ScrollLock on your text console.

To tell the truth, I don't have a deep understanding of how dbench 
works.  I should read the code now and see if I can learn more about it 
:-/  I have noticed that it tends to be highly variable in performance, 
sometimes showing variation of a few 10's of percents from run to run.  
This variation seems to depend a lot on scheduling.  Do you see "*"'s 
evenly spaced throughout the tracing output, or do you see most of them 
bunched up near the end?

--
Daniel
