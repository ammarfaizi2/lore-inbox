Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWKTXWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWKTXWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWKTXWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:22:41 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:1276 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030421AbWKTXWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:22:40 -0500
Message-ID: <45623803.7070103@oracle.com>
Date: Mon, 20 Nov 2006 15:19:31 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: jes@trained-monkey.org, Adrian Bunk <bunk@stusta.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: xconfig segfault
References: <20061119161231.e509e5bf.randy.dunlap@oracle.com> <20061120004147.GC31879@stusta.de> <4560FB07.2040102@oracle.com> <20061120102438.94ff4b0a.randy.dunlap@oracle.com> <Pine.LNX.4.64.0611202254200.6242@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0611202254200.6242@scrub.home>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Mon, 20 Nov 2006, Randy Dunlap wrote:
> 
>> I found the problem patch, but not the root cause.
>>
>> The xconfig segfault begins in 2.6.19-rc5-git3 (-git2 is OK).
>> A relatively simple Kconfig change causes it (but why?).
>>
>> (Note:  The running kernel doesn't matter, just which kernel tree
>> is being viewed/config-ed.)
>>
>> If I back out the patches below, -git3 (xconfig ^F find/search)
>> works for me.
> 
> I cannot reproduce this. Could you try to run qconf within gdb for a 
> backtrace (adding -g to HOST_EXTRACFLAGS might get more useful output).

Sure, let me know what you want next.

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 46953334203536 (LWP 23635)]
0x00000000004289bc in ConfigMainWindow::searchConfig ()
(gdb) bt
#0  0x00000000004289bc in ConfigMainWindow::searchConfig ()
#1  0x0000000000428ae2 in ConfigMainWindow::qt_invoke ()
#2  0x00002ab42ab8b79c in QObject::activate_signal ()
   from /usr/lib64/libqt-mt.so.3
#3  0x00002ab42ab8c4b3 in QObject::activate_signal ()
   from /usr/lib64/libqt-mt.so.3
#4  0x00002ab42ae889b3 in QAction::qt_invoke () from /usr/lib64/libqt-mt.so.3
#5  0x00002ab42ab8b79c in QObject::activate_signal ()
   from /usr/lib64/libqt-mt.so.3
#6  0x00002ab42ae6d628 in QSignal::signal () from /usr/lib64/libqt-mt.so.3
#7  0x00002ab42aba42a5 in QSignal::activate () from /usr/lib64/libqt-mt.so.3
#8  0x00002ab42ab31a45 in QAccelPrivate::activate ()
   from /usr/lib64/libqt-mt.so.3
#9  0x00002ab42ab333e2 in QAccelManager::dispatchAccelEvent ()
   from /usr/lib64/libqt-mt.so.3
#10 0x00002ab42ab338fc in qt_dispatchAccelEvent () from /usr/lib64/libqt-mt.so.3
#11 0x00002ab42ab35d7a in QApplication::notify () from /usr/lib64/libqt-mt.so.3
#12 0x00002ab42ab31fce in QAccelManager::tryAccelEvent ()
   from /usr/lib64/libqt-mt.so.3
#13 0x00002ab42ab323ac in qt_tryAccelEvent () from /usr/lib64/libqt-mt.so.3
#14 0x00002ab42aadb39c in QETWidget::translateKeyEvent ()
   from /usr/lib64/libqt-mt.so.3
#15 0x00002ab42aadc180 in QApplication::x11ProcessEvent ()
   from /usr/lib64/libqt-mt.so.3
#16 0x00002ab42aaeb22f in QEventLoop::processEvents ()
   from /usr/lib64/libqt-mt.so.3
#17 0x00002ab42ab49691 in QEventLoop::enterLoop () from /usr/lib64/libqt-mt.so.3
#18 0x00002ab42ab4953a in QEventLoop::exec () from /usr/lib64/libqt-mt.so.3
#19 0x0000000000425e23 in main ()
(gdb) 

-- 
~Randy
