Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVGWFiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVGWFiI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 01:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVGWFiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 01:38:07 -0400
Received: from dial169-39.awalnet.net ([213.184.169.39]:17415 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S262357AbVGWFgd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 01:36:33 -0400
Message-Id: <200507230536.IAA03542@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'linux-os \(Dick Johnson\)'" <linux-os@analogic.com>
Cc: "'Bernd Petrovitsch'" <bernd@firmix.at>,
       "'Linux kernel'" <linux-kernel@vger.kernel.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'Vinicius'" <jdob@ig.com.br>
Subject: RE: Kernel doesn't free Cached Memory
Date: Sat, 23 Jul 2005 08:35:24 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcWOvmevsy6YzHeuQvm7ZTrcdtDdlwAfmr6g
In-Reply-To: <Pine.LNX.4.61.0507220904280.15626@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick Johnson wrote: { 
> On Fri, 2005-07-22 at 08:27 -0300, Vinicius wrote:
> [...]
>>    I have a server with 2 Pentium 4 HT processors and 32 GB of RAM, 
>> this server runs lots of applications that consume lots of memory to. 
>> When I stop this applications, the kernel doesn't free memory (the  
>> memory still in use) and the server cache lots of memory (~27GB). 
>> When I start this applications, the kernel sends  "Out of Memory" 
>> messages and kill some random applications.

...you might even need to turn memory over-commit off:
  echo "0" > /proc/sys/vm/overcommit_memory
}

That's in 2.4. In 2.6 it's:
  echo "2" > /proc/sys/vm/overcommit_memory

But the kernel doesn't honor no-overcommit in either version, i.e. it still
overcommits/pages-out loaded/running procs, thus invoking OOM!

Is there a way to make the kernel strictly honor the no-overcommit request?

Thanks!

