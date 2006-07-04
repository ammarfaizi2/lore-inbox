Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWGDAJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWGDAJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWGDAJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:09:21 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.4.202]:22827 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750781AbWGDAJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:09:20 -0400
Date: Mon, 03 Jul 2006 20:09:13 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
In-reply-to: <20060703093148.5e61a7e4.pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       hadi@cyberus.ca, netdev@vger.kernel.org
Message-id: <44A9B1A9.20106@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <44892610.6040001@watson.ibm.com> <449C6620.1020203@engr.sgi.com>
 <20060623164743.c894c314.akpm@osdl.org> <449CAA78.4080902@watson.ibm.com>
 <20060623213912.96056b02.akpm@osdl.org> <449CD4B3.8020300@watson.ibm.com>
 <44A01A50.1050403@sgi.com> <20060626105548.edef4c64.akpm@osdl.org>
 <44A020CD.30903@watson.ibm.com> <20060626111249.7aece36e.akpm@osdl.org>
 <44A026ED.8080903@sgi.com> <20060626113959.839d72bc.akpm@osdl.org>
 <44A2F50D.8030306@engr.sgi.com> <20060628145341.529a61ab.akpm@osdl.org>
 <44A2FC72.9090407@engr.sgi.com> <20060629014050.d3bf0be4.pj@sgi.com>
 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
 <20060629094408.360ac157.pj@sgi.com> <20060629110107.2e56310b.akpm@osdl.org>
 <44A57310.3010208@watson.ibm.com> <44A5770F.3080206@watson.ibm.com>
 <20060630155030.5ea1faba.akpm@osdl.org> <44A5DBE7.2020704@watson.ibm.com>
 <44A5EDE6.3010605@watson.ibm.com> <20060702215350.2c1de596.pj@sgi.com>
 <44A93179.2080303@watson.ibm.com> <20060703093148.5e61a7e4.pj@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

>Shailabh wrote:
>  
>
>>I don't know if there are buffer overflow 
>>issues in passing a string
>>    
>>
>
>I don't know if this comment applies to "the standard netlink way of
>passing it up using NLA_STRING", but the way I deal with buffer length
>issues in the cpuset code is to insist that the user code express the
>list in no fewer than 100 + 6 * NR_CPUS bytes:
>
>From kernel/cpuset.c:
>
>        /* Crude upper limit on largest legitimate cpulist user might write. */
>        if (nbytes > 100 + 6 * NR_CPUS)
>                return -E2BIG;
>
>This lets the user specify the buffer size passed in, but prevents
>them from trying a denial of service attack on the kernel by trying
>to pass in a huge buffer.
>
>If the user can't figure out how to write the desired cpulist in
>that size, then tough toenails.
>  
>
Paul,

Perhaps I should use the the other ascii format for specifying cpumasks 
since its more amenable
to specifying an upper bound for the length of the ascii string and is 
more compact ?

That format (the one used in lib/bitmap.c:bitmap_parse) is comma 
separated chunks of hex digits
with each chunk specifying 32 bits of the desired cpumask.

So
((NR_CPUS + 32) / 32) * 8 + 1
(8 hex characters for each 32 cpus, and 1 extra character for null 
terminator)
would be an upper bound that would accomodate all the cpus for sure.

Thoughts ?

--Shailabh

--Shailabh
