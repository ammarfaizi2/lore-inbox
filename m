Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSG1Sok>; Sun, 28 Jul 2002 14:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSG1Sok>; Sun, 28 Jul 2002 14:44:40 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:16800 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S317035AbSG1Soj>; Sun, 28 Jul 2002 14:44:39 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Ville Herva" <vherva@niksula.hut.fi>
Cc: "Linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
Date: Sun, 28 Jul 2002 11:48:51 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECOEAPDAAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020728065830.GT1465@niksula.cs.hut.fi>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Jul 27, 2002 at 03:39:41PM -0700, you [Buddy Lumpkin] wrote:
>>
>> Why would you want to push *anything* to swap until you have to?

>If you have idle io time in your hands, you can choose to back up some
dirty
>anonymous pages to the swap device. This way, when pages really needs to
get
>freed, you can just drop the pages (just like you would drop clean file
>backed pages.) This obviously eliminates a great latency (somebody said
>something about a "swap storm"), because the write happened beforehand.

>There's nothing wrong with the swap being in use (and the pages may still
be
>in memory). If you have swap, it makes sense to use it. What doesn't make
>sense is to waste time waiting for paging to happen.


This just flat out doesn't make sense to me ...

The system I showed stats on earlier has been up for 57 days. Periodically
file system I/O pushes
freemem below lotsfree and wakes up the scanner. The scanner wakes up and
finds some filesystem
pages that haven't been referenced or modified in a really long, long time
and frees a few of them, then
it goes back to sleep. This keeps a ton of pages in RAM strictly for caching
value (although dirty pages
are flushed periodically, they are kept in RAM too). Then when a shared
mapping to a file occurs or a file
is opened, and accessed with read or write, it can use the page fault
mechanism (minor fault) to retrieve
those pages (using vnode + offset of the page) as apposed to going to disk.

By looking at it, at one of more rare occasions, it must have pushed some
anonymous
pages to the swap devices, and there they sit pretty much doing nothing. But
thats the
nice thing about it ... Why would I want I/O going all the time in
anticipation
of a memory shortage that will rarely happen, or might not happen at all! If
I understand
you correctly, your imagining all of the up front work you could be doing in
anticipation
of the crawling system that could benefit from pages already pushed to the
swap device,
but that would only be one case.

If im willing to spend the money for tons of RAM I shouldn't have to incur
the overhead of going
out to the swap device at all unless I truly get short on memory.
Don't just assume that it's inevitable that I will have to swap at some
point.

And when you refer to idle I/O time, do you mean I/O to the swap device(s)
or all I/O on the system (IO to all disks, network, etc..) ?

--Buddy




