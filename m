Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVGZF1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVGZF1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVGZF1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:27:02 -0400
Received: from dial169-98.awalnet.net ([213.184.169.98]:49161 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S261737AbVGZFYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:24:36 -0400
Message-Id: <200507260524.IAA06949@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Paolo Ornati'" <ornati@fastwebnet.it>
Cc: "'Bernd Petrovitsch'" <bernd@firmix.at>,
       "'Linux kernel'" <linux-kernel@vger.kernel.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Subject: RE: Kernel doesn't free Cached Memory
Date: Tue, 26 Jul 2005 08:23:19 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <42E5134A.30001@tmr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcWRj+If6YwMiYR5Tva3ArrfKD6v5QACyGig
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote: {
Al Boldi wrote:
> Dick Johnson wrote: {
> 
>>On Fri, 2005-07-22 at 08:27 -0300, Vinicius wrote:
>>[...]
>>
>>>   I have a server with 2 Pentium 4 HT processors and 32 GB of RAM, 
>>>this server runs lots of applications that consume lots of memory to.
>>>When I stop this applications, the kernel doesn't free memory (the 
>>>memory still in use) and the server cache lots of memory (~27GB).
>>>When I start this applications, the kernel sends  "Out of Memory" 
>>>messages and kill some random applications.
> 
> 
> ...you might even need to turn memory over-commit off:
>   echo "0" > /proc/sys/vm/overcommit_memory
> }
> 
> That's in 2.4. In 2.6 it's:
>   echo "2" > /proc/sys/vm/overcommit_memory

RHEL3 *is* a 2.4 kernel.
> 
> But the kernel doesn't honor no-overcommit in either version, i.e. it
still
> overcommits/pages-out loaded/running procs, thus invoking OOM!
> 
> Is there a way to make the kernel strictly honor the no-overcommit
request?
> 

Don't have swap?
}

Turn off swap and things get worse!

Paolo Ornati wrote:{
Bill Davidsen <davidsen@tmr.com> wrote:
> And IMHO Linux is *way* too willing to evicy clean pages of my 
> programs to use as disk buffer, so that when system memory is full I 
> pay  the overhead of TWO disk i/o's, one to finally write the data to 
> the  disk and one to read my program back in. If free software is 
> about  choice, I wish there was more in the area of how memory is 
> used.

isn't this tuned enough by "/proc/sys/vm/swappiness" ?
}

Swappiness tunes but does not inhibit overcommit!

So the question remains:
	Why Is there no way to make the kernel _strictly_ honor the
no-overcommit request?

--
Al

