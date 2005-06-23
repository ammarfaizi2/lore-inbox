Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVFWGSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVFWGSg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVFWGRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:17:23 -0400
Received: from web8406.mail.in.yahoo.com ([202.43.219.154]:13977 "HELO
	web8406.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S262228AbVFWGNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:13:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4fGb0pADsCqv0U+rAGh/iqi95IQ11KkZRfEKZWGI5eofcIhlLPBkGFvpypC3Mdiyakv7x7dq9x6QHlSUjYjESOAyKp8+cjs5frvmNlU3A0XtatdnoN1rhrQ8RpL44cqyBCGZK+AtMNjHORY96nil2YLr50PrVMaIm+J5NRAnyUw=  ;
Message-ID: <20050623061257.6905.qmail@web8406.mail.in.yahoo.com>
Date: Thu, 23 Jun 2005 07:12:57 +0100 (BST)
From: KV Pavuram <kvpavuram@yahoo.co.in>
Subject: Re: 0xffffe002 in ??
To: Denis Vlasenko <vda@ilport.com.ua>, linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506220854.44182.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the threads are going into that strange
address when they are waiting over an IPC object like
semaphore or mutex. Atleast i saw a thread come out of
that strange address immed. after another threads
released a semaphore!!

Thanks for the inputs.

Pav.
--- Denis Vlasenko <vda@ilport.com.ua> wrote:

> On Tuesday 21 June 2005 18:38, Richard B. Johnson
> wrote:
> > On Tue, 21 Jun 2005, KV Pavuram wrote:
> > 
> > > I am running a multithreaded application on
> Linux 2.4
> > > kernel (RedHat Linux 9).
> > >
> > > At some point the program receives a seg. fault
> and if
> > > i check info threads, using gdb for debug,
> almost all
> > > the threads are at "0xffffe002 in ??"
> 
> It most likely is something in VDSO:
> 
> # pmap 1
> 1: init
> Start         Size Perm Mapping
> 08048000      704K r-xp /app/bash-3.0-uc/bin/bash
> 080f8000       28K rwxp /app/bash-3.0-uc/bin/bash
> 080ff000       40K rwxp [heap]
> b7f20000      272K r-xp
> /app/uclibc-0.9.26/lib/libuClibc-0.9.26.so
> b7f64000        8K rwxp
> /app/uclibc-0.9.26/lib/libuClibc-0.9.26.so
> b7f66000       16K rwxp [ anon ]
> b7f6a000        8K r-xp
> /app/uclibc-0.9.26/lib/libdl-0.9.26.so
> b7f6c000        4K rwxp
> /app/uclibc-0.9.26/lib/libdl-0.9.26.so
> b7f6e000        4K rwxp [ anon ]
> b7f6f000       16K r-xp
> /app/uclibc-0.9.26/lib/ld-uClibc-0.9.26.so
> b7f73000        4K rwxp
> /app/uclibc-0.9.26/lib/ld-uClibc-0.9.26.so
> bff5d000       88K rwxp [ stack ]
> ffffe000        4K ---p [vdso]      
> <====================================
> mapped: 1196K    writeable/private: 192K    shared:
> 0K
> 
> > If a number of threads arrive at the same bad
> address you
> > should look for some common code that calls
> through
> > a function pointer. If you don't have any calls
> through
> > pointers, then you may have something corrupting
> the stack
> > so that the return address of a called function
> gets
> > corrupted. For instance, if the value 0x02e0 was
> written
> > beyond array limits in local (stack) data, then
> when that
> > function returned it could actually end up
> 'returning'
> > to the bad address you discovered.
> 
> > Although the kernel provided the seg-fault
> mechanism, this
> > is not a kernel problem. This is a user-code
> problem.
> 
> I'm not so sure.
> --
> vda
> 
> 



	

	
		
__________________________________________________________
Free antispam, antivirus and 1GB to save all your messages
Only in Yahoo! Mail: http://in.mail.yahoo.com
