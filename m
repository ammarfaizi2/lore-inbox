Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261351AbTCGEQq>; Thu, 6 Mar 2003 23:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261348AbTCGEQp>; Thu, 6 Mar 2003 23:16:45 -0500
Received: from ohsmtp02.ogw.rr.com ([65.24.7.37]:1213 "EHLO
	ohsmtp02.ogw.rr.com") by vger.kernel.org with ESMTP
	id <S261351AbTCGEQo>; Thu, 6 Mar 2003 23:16:44 -0500
Message-ID: <001f01c2e463$9e9ed5e0$de00000a@woh.rr.com>
From: "Steven Schaefer" <sschaefer1@woh.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: mmap(.., .., PROT_READ, MAP_PRIVATE, .., ..) functionality question
Date: Thu, 6 Mar 2003 23:40:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please email me directly (or CC me) since I am not subscribed to the mail
list.

I have a question on the functionality of mmap() when used with PROT_READ,
and MAP_PRIVATE flag.

Currently I am reading in the entire contents of a file into memory and
processing it thru "zlib" compression library.  In order to create RFC1952
compatible data the file's contents has to be read once by the compression
routine and once by the checksum routine.  "zlib" provides a simple
implementation where it uses mmap() to map the file into memory and passes
that address off to the two routines.  This brings up my design
consideration and thus my question.

Doesn't mmap(), mind you with PROT_READ and MAP_PRIVATE, first copy the
contents of the file into the swap space and then when the data is accessed
into physical RAM before the CPU can get to it?  If so, in essence wouldn't
I be doubling the disk access time???  I have found numerous messages
talking about mmap() but only with read/write considerations.

I'm trying to decide whether or not using read() to copy the contents into
system memory (heavy on the physical memory) is worth the sacrifice of
having the extra disk access (light on the physical memory).  So how does
mmap() handle the mapped file?

Imagine for a moment it does not first copy the file contents to swap space.
The fact that I would need to read the data twice, once for each function;
wouldn't the memory access to the file contents cause mmap() to access the
file twice from the hard drive be a draw back or does it somehow cache it in
memory after the first access?  If it did cache it, is it going to cache it
on the swap partition or in memory?

I list a few links that I found references to mmap() discussions, that of
course didn't specifically answer my question.

http://groups.google.com/groups?q=mmap+group:mlist.linux.
*&start=180&hl=en&lr
=&ie=UTF-8&selm=linux.kernel.1007839431.371.0.camel%40quinn.rcn.nmt.edu&rnum
=185

http://groups.google.com/groups?q=mmap+group:mlist.linux.
*&start=70&hl=en&lr
=&ie=UTF-8&selm=linux.kernel.991739488742.20020313181735%40spylog.ru&rnum=75

http://groups.google.com/groups?q=mmap+group:mlist.linux.
*&start=90&hl=en&lr
=&ie=UTF-8&selm=linux.kernel.1781804867952.20020314122715%40spylog.ru&rnum=9
6

http://groups.google.com/groups?q=mmap+group:mlist.linux.
*&start=160&hl=en&lr
=&ie=UTF-8&selm=linux.kernel.5.1.0.14.2.20020603141650.01acc8c0%40mira-sjcm-
3.cisco.com&rnum=169

http://groups.google.com/groups?q=mmap+group:mlist.linux.
*&start=180&hl=en&lr
=&ie=UTF-8&selm=linux.kernel.9spg3c%247bb%241%40penguin.transmeta.com&rnum=1
87

http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.1/0884.html

http://groups.google.com/groups?q=mmap+group:mlist.linux.*&hl=en&lr
=&ie=UTF-8&selm=linux.kernel.861732271654.20020313161718%40spylog.ru&rnum=3

http://groups.google.com/groups?q=mmap+group:mlist.linux.
*&start=40&hl=en&lr
=&ie=UTF-8&selm=linux.kernel.3B269B5D.35A554A9%40scali.no&rnum=50




