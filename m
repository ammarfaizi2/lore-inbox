Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291923AbSBAT3V>; Fri, 1 Feb 2002 14:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291924AbSBAT3M>; Fri, 1 Feb 2002 14:29:12 -0500
Received: from zok.sgi.com ([204.94.215.101]:22415 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S291923AbSBAT3H>;
	Fri, 1 Feb 2002 14:29:07 -0500
Message-ID: <01ec01c1ab56$ba7d5e40$6401a8c0@attbi.com>
From: "John Hawkes" <hawkes@sgi.com>
To: "Linux-Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: push BKL out of llseek
Date: Fri, 1 Feb 2002 11:29:11 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dave Jones" <davej@suse.de>
>  did you benchmark with anything other than dbench ?

I've done substantial AIM7 benchmarking on a 28p ia64 NUMA system, and
llseek's BKL usage is a significant contributor to poor scaling.  For
500 AIM7 "tasks" and ext2 filesystems, waiting on the BKL consumes about
half of the available CPU cycles, and sys_lseek()'s usage is the most
significant cycle waster, followed by ext2_get_block() and
ext2_write_inode().  Anton's llseek patch from last November does make
a measurable improvement in AIM7 throughput.

--
John Hawkes
hawkes@sgi.com


