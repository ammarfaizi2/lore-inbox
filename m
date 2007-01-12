Return-Path: <linux-kernel-owner+w=401wt.eu-S932127AbXALP1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbXALP1p (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbXALP1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:27:45 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:54467 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932119AbXALP1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:27:44 -0500
Message-ID: <45A7A8F0.30200@cfl.rr.com>
Date: Fri, 12 Jan 2007 10:27:44 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: dean gaudet <dean@arctic.org>
CC: Linus Torvalds <torvalds@osdl.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jan 2007 15:27:53.0059 (UTC) FILETIME=[39F5E330:01C7365E]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14930.003
X-TM-AS-Result: No--5.272700-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> it seems to me that if splice and fadvise and related things are 
> sufficient for userland to take care of things "properly" then O_DIRECT 
> could be changed into splice/fadvise calls either by a library or in the 
> kernel directly...

No, because the semantics are entirely different.  An application using 
read/write with O_DIRECT expects read() to block until data is 
physically fetched from the device.  fadvise() does not FORCE the kernel 
to discard cache, it only hints that it should, so a read() or mmap() 
very well may reuse a cached page instead of fetching from the disk 
again.  The application also expects write() to block until the data is 
on the disk.  In the case of a blocking write, you could splice/msync, 
but what about aio?


