Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSG1SzI>; Sun, 28 Jul 2002 14:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSG1SzI>; Sun, 28 Jul 2002 14:55:08 -0400
Received: from mail15.speakeasy.net ([216.254.0.215]:29913 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S317148AbSG1SzG>; Sun, 28 Jul 2002 14:55:06 -0400
Subject: RE: About the need of a swap area
From: Ed Sweetman <safemode@speakeasy.net>
To: Buddy Lumpkin <b.lumpkin@attbi.com>
Cc: Ville Herva <vherva@niksula.hut.fi>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <FJEIKLCALBJLPMEOOMECOEAPDAAA.b.lumpkin@attbi.com>
References: <FJEIKLCALBJLPMEOOMECOEAPDAAA.b.lumpkin@attbi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 28 Jul 2002 14:58:25 -0400
Message-Id: <1027882706.4228.138.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-28 at 14:48, Buddy Lumpkin wrote:
> 
> On Sat, Jul 27, 2002 at 03:39:41PM -0700, you [Buddy Lumpkin] wrote:
> >>
> >> Why would you want to push *anything* to swap until you have to?
> 
> >If you have idle io time in your hands, you can choose to back up some
> dirty
> >anonymous pages to the swap device. This way, when pages really needs to
> get
> >freed, you can just drop the pages (just like you would drop clean file
> >backed pages.) This obviously eliminates a great latency (somebody said
> >something about a "swap storm"), because the write happened beforehand.
> 
> >There's nothing wrong with the swap being in use (and the pages may still
> be
> >in memory). If you have swap, it makes sense to use it. What doesn't make
> >sense is to waste time waiting for paging to happen.
> 
> 
> This just flat out doesn't make sense to me ...
> 
> The system I showed stats on earlier has been up for 57 days. Periodically
> file system I/O pushes
> freemem below lotsfree and wakes up the scanner. The scanner wakes up and
> finds some filesystem
> pages that haven't been referenced or modified in a really long, long time
> and frees a few of them, then
> it goes back to sleep. This keeps a ton of pages in RAM strictly for caching
> value (although dirty pages
> are flushed periodically, they are kept in RAM too). Then when a shared
> mapping to a file occurs or a file
> is opened, and accessed with read or write, it can use the page fault
> mechanism (minor fault) to retrieve
> those pages (using vnode + offset of the page) as apposed to going to disk.
> 
> By looking at it, at one of more rare occasions, it must have pushed some
> anonymous
> pages to the swap devices, and there they sit pretty much doing nothing. But
> thats the
> nice thing about it ... Why would I want I/O going all the time in
> anticipation
> of a memory shortage that will rarely happen, or might not happen at all! If
> I understand
> you correctly, your imagining all of the up front work you could be doing in
> anticipation
> of the crawling system that could benefit from pages already pushed to the
> swap device,
> but that would only be one case.
> 
> If im willing to spend the money for tons of RAM I shouldn't have to incur
> the overhead of going
> out to the swap device at all unless I truly get short on memory.
> Don't just assume that it's inevitable that I will have to swap at some
> point.
> 
> And when you refer to idle I/O time, do you mean I/O to the swap device(s)
> or all I/O on the system (IO to all disks, network, etc..) ?
> 
> --Buddy

If you bother to do any real tests you'd see that linux will swap when
nothing is going on and this doesn't hinder anything.  This overhead
you're imagining doesn't occur because Overhead only exists when you're
trying to do something.  There is no drawback to how linux puts pages
into swap except what rik van riel said about battery powered boxes. 
Even so I believe that's just a /proc tunable fix.   Otherwise there is
a situation where it's advantageous to do what linux does and none where
it isn't.  

It's not like your swap device is growing and using more swap means less
space for programs.  You have X amount of swap space..  like other
people have said,  might as well make use of it if you can.  Who cares
if that situation may not occur, it's not detrimental to anything.

