Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbTAXMkM>; Fri, 24 Jan 2003 07:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267644AbTAXMkM>; Fri, 24 Jan 2003 07:40:12 -0500
Received: from mail.mpi-sb.mpg.de ([139.19.1.1]:29129 "EHLO
	interferon.mpi-sb.mpg.de") by vger.kernel.org with ESMTP
	id <S267643AbTAXMkL>; Fri, 24 Jan 2003 07:40:11 -0500
Message-ID: <3E31364E.F3AFDCF0@mpi-sb.mpg.de>
Date: Fri, 24 Jan 2003 13:49:18 +0100
From: Roman Dementiev <dementiev@mpi-sb.mpg.de>
Reply-To: dementiev@mpi-sb.mpg.de
Organization: MPI for Computer Science
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19p4-smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
CC: dementiev@mpi-sb.mpg.de
Subject: buffer leakage in kernel?
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've met with following problem (kernel 2.4.20-pre4 ):
I write and read sequentially from/to 8 files each of 64 Gbytes (not a
mistake, 64 Gbyte),
each on different disk. The files are opened with flag O_DIRECT. I have
1 Gbyte RAM, no swap.
While this scanning is running, number of "buffers" reported by ''free"
and in /proc/meminfo
is continuously increasing up to ~ 500 MB !! When the program exits
normally or I break it, number
of "buffers" does not decrease and even increases if I do operations on
other files.

This is not nice at all when I have another applications running
with memory consumption > 500 MB: when my "scanner" approaches 50G
border on
each disk, I've got numerous  "Out of memory" murders :(. Even 'ssh' to
this machine
is killed :(

Could anyone explain why it happens? I suppose that it is a memory
leakage in
file system buffer management.
Is it fixed already in any patch?


Bye,
Roman


