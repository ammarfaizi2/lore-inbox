Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVJYSdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVJYSdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 14:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVJYSdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 14:33:47 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:10162 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932293AbVJYSdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 14:33:47 -0400
Message-ID: <435E7A7B.3040806@hp.com>
Date: Tue, 25 Oct 2005 14:33:31 -0400
From: Mark Seger <Mark.Seger@hp.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: Patch for inconsistent recording of block device statistics]
References: <435D0F45.90906@hp.com> <20051025064014.GO2811@suse.de>
In-Reply-To: <20051025064014.GO2811@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, the patch worked.  The general discussion was that the byte counter 
gets incremented when requests are queued, not when they're acted upon 
as is the case with the count of I/Os.  As a result, the disk write 
numbers don't make any sense reporting impossibly high numbers (>100MB 
and as high as 450!) during some times and at other reporting zeros.  
The entire time, the I/O counts are happily showing what appear to be 
correct numbers.  Here's a snapshot taken during a portion of a 2GB file 
file to /tmp.

# DISK SUMMARY (/sec)
#         Reads  R-Merged  R-KBytes   Writes  W-Merged  W-KBytes
14:26:38      0         0         0        0         0         0
14:26:39      0         0         0       90      4391     18368
14:26:40      0         0         0      577     12603     52696
14:26:41      0         0         0      563    107835    446728
14:26:42      0         0         0      445         0         0
14:26:43      0         0         0      442         0         0
14:26:44      0         0         0      445         0         0
14:26:45      0         0         0      354         0         0
14:26:46      0         0         0      442         0         0
14:26:47      0         0         0      443         0         0
14:26:48      0         0         0      408         0         0
14:26:49      0         0         4      439       782      3280
14:26:50      1         0         0      462     12230     51160
14:26:51      0         0         0      574     88342    366116
14:26:52      0         0         0      477     32881    136604
14:26:53      0         0         0      443      9101     37656
14:26:54      0         0         0      442     11779     48736
14:26:55      0         0         0      373         0         0
14:26:56      0         0         0      415         0         0

-mark

Jens Axboe wrote:

>On Mon, Oct 24 2005, Mark Seger wrote:
>  
>
>>This patch was discussed back in march, and I still haven't seen it show 
>>up in the source pool.  I was wondering if it just feel through the 
>>cracks or if it was planned for a specific future release.  If the 
>>attached doesn't provide enough context for you to remember what this is 
>>all about, just let me know...
>>    
>>
>
>Refresh my memory on where the discussion went after this email, I don't
>recall. Did the patch work for you?
>
>
>  
>

