Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSCWCFU>; Fri, 22 Mar 2002 21:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289606AbSCWCFL>; Fri, 22 Mar 2002 21:05:11 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62853 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289272AbSCWCEz> convert rfc822-to-8bit;
	Fri, 22 Mar 2002 21:04:55 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: mprotect() api overhead.
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Fri, 22 Mar 2002 17:59:59 -0800
Message-ID: <4D7B558499107545BB45044C63822DDE3A2047@mvebe001.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mprotect() api overhead.
Thread-Index: AcHSCcYQi9qHxmaJQ+ugvvjbo/uAOAAAI5vw
From: <Tony.P.Lee@nokia.com>
To: <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Mar 2002 02:00:00.0370 (UTC) FILETIME=[709B8520:01C1D20E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: ext Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Friday, March 22, 2002 5:03 PM
> To: Lee Tony.P (NET/MtView)
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: mprotect() api overhead.
> 
> 
> > 	For x86 system, is there way to specify 4MB page table entry
> > 	instead of 4K page table entry when use the mmap() api.  
> > 	With 4MB mmap() page table entry, mprotected should take only
> > 	8 iterations to change the access bits for 32 MB of share
> > 	memory as compare to 8k iterations for 4k page table entries.
> > 	Am I corrected on this?
> 
> The mainstream kernel has no real support for 4Mb pages - 
> some experimental
> work has been done but little else. Even then the TLB flush has a non
> trivial overhead. On SMP the effect will be more significant since it
> must ensure the other threads on other processors also see 
> updated page 
> tables.

Alan, Thanks for the info.

Just talked to someone from HP lab that worked on PA-RISC chip
6 years ago.  PA-RISC had some special page table setup that lets
one app to call api in other app's virtual memory in 7 instructions
and without TLB flush.

I was told such "features" is in Itanium.
There were (will be) utopia.... :-)

As for SMP case, for my application, it is less an issue, since
when user call my API in the .so, the mprotect (or that HP 
7 instructions) will open access to the share memory for them
regardless which CPU they are coming from.  If other thread
running in other CPU need to windows open, it will also call
my api which in turn will call the mprotect to open the windows 
for that CPU.


Think of it as one module software that can call APIs in other 
module running in other virtual memory with low overhead but also has 
memory protection against other software (exe or .so) without entering
kernel.  It will be extremly useful in large scale fault 
tolerance software development.  

Just image a world that 

	Apache's mod_tcl.so crashes but the httpd server still running.

	zlib has double free bugs but it can not touch the apache 
	since all the API that can call into the apache module 
	is somehow protected by HW page table.
	It has to fast, otherwise I would just use CGI and standard
	Unix ipc which give us the protection but no performance.


----------------------------------------------------------------
Tony Lee           Nokia Networks, Inc. 
