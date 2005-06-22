Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVFVHqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVFVHqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVFVHpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:45:34 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12429 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262844AbVFVFzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:55:08 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-os@analogic.com, KV Pavuram <kvpavuram@yahoo.co.in>
Subject: Re: 0xffffe002 in ??
Date: Wed, 22 Jun 2005 08:54:44 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20050621152133.77162.qmail@web8409.mail.in.yahoo.com> <Pine.LNX.4.61.0506211132140.17269@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0506211132140.17269@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506220854.44182.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 18:38, Richard B. Johnson wrote:
> On Tue, 21 Jun 2005, KV Pavuram wrote:
> 
> > I am running a multithreaded application on Linux 2.4
> > kernel (RedHat Linux 9).
> >
> > At some point the program receives a seg. fault and if
> > i check info threads, using gdb for debug, almost all
> > the threads are at "0xffffe002 in ??"

It most likely is something in VDSO:

# pmap 1
1: init
Start         Size Perm Mapping
08048000      704K r-xp /app/bash-3.0-uc/bin/bash
080f8000       28K rwxp /app/bash-3.0-uc/bin/bash
080ff000       40K rwxp [heap]
b7f20000      272K r-xp /app/uclibc-0.9.26/lib/libuClibc-0.9.26.so
b7f64000        8K rwxp /app/uclibc-0.9.26/lib/libuClibc-0.9.26.so
b7f66000       16K rwxp [ anon ]
b7f6a000        8K r-xp /app/uclibc-0.9.26/lib/libdl-0.9.26.so
b7f6c000        4K rwxp /app/uclibc-0.9.26/lib/libdl-0.9.26.so
b7f6e000        4K rwxp [ anon ]
b7f6f000       16K r-xp /app/uclibc-0.9.26/lib/ld-uClibc-0.9.26.so
b7f73000        4K rwxp /app/uclibc-0.9.26/lib/ld-uClibc-0.9.26.so
bff5d000       88K rwxp [ stack ]
ffffe000        4K ---p [vdso]       <====================================
mapped: 1196K    writeable/private: 192K    shared: 0K

> If a number of threads arrive at the same bad address you
> should look for some common code that calls through
> a function pointer. If you don't have any calls through
> pointers, then you may have something corrupting the stack
> so that the return address of a called function gets
> corrupted. For instance, if the value 0x02e0 was written
> beyond array limits in local (stack) data, then when that
> function returned it could actually end up 'returning'
> to the bad address you discovered.

> Although the kernel provided the seg-fault mechanism, this
> is not a kernel problem. This is a user-code problem.

I'm not so sure.
--
vda

