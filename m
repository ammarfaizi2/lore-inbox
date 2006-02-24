Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWBXQSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWBXQSa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWBXQSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:18:30 -0500
Received: from rs27.luxsci.com ([66.216.127.24]:22763 "EHLO rs27.luxsci.com")
	by vger.kernel.org with ESMTP id S932334AbWBXQS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:18:29 -0500
Message-ID: <43FF31E4.2000705@eventmonitor.com>
Date: Fri, 24 Feb 2006 11:18:44 -0500
From: Bryan Fink <bfink@eventmonitor.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: NFS Still broken in 2.6.x?
References: <43FE1CAD.3050806@eventmonitor.com>	<1140734824.7963.38.camel@lade.trondhjem.org> <20060224041435.733b4f0d.akpm@osdl.org>
In-Reply-To: <20060224041435.733b4f0d.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>  
>
>>On Thu, 2006-02-23 at 15:35 -0500, Bryan Fink wrote:
>> > Hi All.  I'm running into a bit of trouble with NFS on 2.6.  I see that
>> > at least Trond thought, mid-January, that "The readahead algorithm has
>> > been broken in 2.6.x for at least the past 6 months." (
>> > http://www.ussg.iu.edu/hypermail/linux/kernel/0601.2/0559.html) Anyone
>> > know if that has been fixed?
>>
>> No it hasn't been fixed. ...and no, this is not a problem that only
>> affects NFS: it just happens to give a more noticeable performance
>> impact due to the larger latency of NFS over a 100Mbps link.
>>    
>>
>
>iirc, last time we went round this loop Ram and I were unable to reproduce it.
>
>Does anyone have a testcase?
>  
>

Hi again. I just found some new, very interesting information. Until 
just a few minutes ago, I hadn't realized that one could change the I/O 
scheduler at runtime. Looking into it, my system was using "cfq", and I 
have three other options, "noop", "anticipatory", and "deadline". I've 
now run tests using all three of the other schedulers, and they all 
bring performance back up to the level I had with kernel 2.4. So, either 
NFS is incompatible with cfq, or cfq has some issues that show very 
vividly when used with NFS (or, I suppose, I just have my system tuned 
wrong for use with cfq).

Hope this helps the bug hunt. Special thanks to Asfand Yar Qazi for 
writing to the list this morning asking how to change schedulers at 
runtime 
(http://www.ussg.iu.edu/hypermail/linux/kernel/0602.3/0135.html). Off to 
find out exactly what the best scheduler is for my needs.

-Bryan

