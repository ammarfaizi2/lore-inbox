Return-Path: <linux-kernel-owner+w=401wt.eu-S932069AbXALPVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbXALPVT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbXALPVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:21:19 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:54415 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932069AbXALPVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:21:18 -0500
Message-ID: <45A7A76E.1090405@cfl.rr.com>
Date: Fri, 12 Jan 2007 10:21:18 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Hua Zhong <hzhong@gmail.com>
CC: "'Michael Tokarev'" <mjt@tls.msk.ru>,
       "'Linus Torvalds'" <torvalds@osdl.org>, "'Viktor'" <vvp01@inbox.ru>,
       "'Aubrey'" <aubreylee@gmail.com>, "'Hugh Dickins'" <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <45A6704A.40205@tls.msk.ru> <45A6C1D2.9020104@cfl.rr.com> <000001c735d5$2fea7830$262d100a@nuitysystems.com>
In-Reply-To: <000001c735d5$2fea7830$262d100a@nuitysystems.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jan 2007 15:21:26.0513 (UTC) FILETIME=[538FA610:01C7365D]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14930.003
X-TM-AS-Result: No--8.963300-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:
>> The other problem besides the inability to handle IO errors is that
>> mmap()+msync() is synchronous.  You need to go async to keep 
>> the pipelines full.
> 
> msync(addr, len, MS_ASYNC); doesn't do what you want?
> 

No, because there is no notification of completion.  In fact, does this 
call actually even avoid blocking in the current code, while asking the 
kernel to flush the pages in the background?

Even if it performs the sync in the background, what about faulting in 
the pages to be synced?  For instance, if you splice pages from a source 
mmaped file into the destination mmap, then msync on the destination, 
doesn't the process still block to fault in the source pages?


