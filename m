Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSEaQxW>; Fri, 31 May 2002 12:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSEaQxV>; Fri, 31 May 2002 12:53:21 -0400
Received: from [62.70.58.70] ([62.70.58.70]:3206 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316223AbSEaQxV> convert rfc822-to-8bit;
	Fri, 31 May 2002 12:53:21 -0400
Message-Id: <200205311653.g4VGrIE09588@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: linux-kernel@vger.kernel.org
Subject: [BUG] in sendfile() under high load
Date: Fri, 31 May 2002 18:53:18 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <tux-list@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

After doing some testing with tux, getting something like a I/O or VM chrash 
whenever downloads start stressing I/O heavily, I tried to make a small 
server myself, using sendfile(). This, however, shows the same behaviour. 
Testing a small app, I use xinetd:

fd = open();
sendfile(0, fd ...);

this works fine until there's ~20 downloads, at which point the I/O just 
messes up. everything goes SLOOOOW and system CPU time is stable at 100%. It 
should be noted that before this limit is reached, the system is hardly using 
any system time at all. After stopping the downloads, the system moves back 
to good behavior, nice I/O speed (~95MB/s disk-to-memory) etc. The system 
also performs well with few clients.

Detailed configuration:

- 4 IBM 40gig disks in RAID-0. chunk size 1MB
- 1 x athlon 1GHz
- 1GB RAM - no highmem (900 meg)
- kernel 2.4.19pre7 + patch from Andrew Morton to ditch buffers early 
	(thread: [BUG] 2.4 VM sucks. Again)
- gigEthernet between test client and server

Anyone got a clue?

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
