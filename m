Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWBXOWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWBXOWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWBXOWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:22:21 -0500
Received: from rs27.luxsci.com ([66.216.127.24]:17879 "EHLO rs27.luxsci.com")
	by vger.kernel.org with ESMTP id S1751064AbWBXOWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:22:20 -0500
Message-ID: <43FF16B7.9060407@eventmonitor.com>
Date: Fri, 24 Feb 2006 09:22:47 -0500
From: Bryan Fink <bfink@eventmonitor.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: NFS Still broken in 2.6.x?
References: <43FE1CAD.3050806@eventmonitor.com>	 <1140734824.7963.38.camel@lade.trondhjem.org>	 <20060224041435.733b4f0d.akpm@osdl.org> <1140788198.3615.3.camel@lade.trondhjem.org>
In-Reply-To: <1140788198.3615.3.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>On Fri, 2006-02-24 at 04:14 -0800, Andrew Morton wrote:
>  
>
>>Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>>    
>>
>>>On Thu, 2006-02-23 at 15:35 -0500, Bryan Fink wrote:
>>> > Hi All.  I'm running into a bit of trouble with NFS on 2.6.  I see that
>>> > at least Trond thought, mid-January, that "The readahead algorithm has
>>> > been broken in 2.6.x for at least the past 6 months." (
>>> > http://www.ussg.iu.edu/hypermail/linux/kernel/0601.2/0559.html) Anyone
>>> > know if that has been fixed?
>>>
>>> No it hasn't been fixed. ...and no, this is not a problem that only
>>> affects NFS: it just happens to give a more noticeable performance
>>> impact due to the larger latency of NFS over a 100Mbps link.
>>>      
>>>
>>iirc, last time we went round this loop Ram and I were unable to reproduce it.
>>
>>Does anyone have a testcase?
>>    
>>
>
>Yes. A dead simple one
>
>run iozone in sequential read mode on a tcp link w/ rsize == 32k
>  
>
I'm sure Trond's testcase is much more useful, but for reference, I 
thought I'd add that I've been doing my testing with a simple "dd 
if=/nfsmount/file of=/dev/null bs=32k".  /nfsmount/file is usually 2.5-3 
GB, which makes the difference between NFS servers long enough that I 
feel safe throwing a "time" in front of the whole command.  That is, the 
difference is nowhere near millisecond resolution (it's nearer a 
minute), so I like to start the test and then walk away to do other things.

Interesting that it's not an NFS-only bug.  I assumed it was when I 
logged into each server so I could run "dd if=file of=/dev/null bs=32k" 
locally.  When I did that, both servers gave roughly the same speed.  
Sorry I left this bit out of my first email.  I assume this example only 
illustrates how opaque the code around this problem truly is.

Thanks very much for the help.

-Bryan

