Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWJTRb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWJTRb6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWJTRb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:31:58 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:19975 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964817AbWJTRb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:31:58 -0400
Message-ID: <453907D5.8070501@shadowen.org>
Date: Fri, 20 Oct 2006 18:31:01 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
References: <20061020015641.b4ed72e5.akpm@osdl.org> <4538F12B.10609@mbligh.org> <4538F993.8020605@us.ibm.com>
In-Reply-To: <4538F993.8020605@us.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> Martin J. Bligh wrote:
>> Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
>>>
>>>
>>> - Added the IOAT tree as git-ioat.patch (Chris Leech)
>>>
>>> - I worked out the git magic to make the wireless tree work
>>>   (git-wireless.patch).  Hopefully it will be in -mm more often now.
>>
>> I think the IO & fsx problems have got better, but this one is still
>> broken, at least.
>>
>> See end of fsx runlog here:
>>
>> http://test.kernel.org/abat/57486/debug/test.log.1
>>
>> which looks like this:
>>
>> Total Test PASSED: 79
>> Total Test FAILED: 3
>>   139 ./fsx-linux -N 10000 -o 8192 -A -l 500000 -r 1024 -t 2048 -w
>> 2048 -Z -R -W test/junkfile
>>   139 ./fsx-linux -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W
>> test/junkfile
>>   139 ./fsx-linux -N 10000 -o 8192 -A -l 500000 -r 1024 -t 2048 -w
>> 1024 -Z -R -W test/junkfile
>> Failed rc=1
>> 10/20/06-02:41:55 command complete: (1) rc=1 (TEST FAIL)
>>
> I see following message in the log which makes me think the reiserfs
> tail handling with DIO problem...
> Is this reiserfs ? Chris Mason told me that we need to use -onotail
> mount option for this to pass.
> Not sure why we haven't see this before...
> 
> doread: read: Invalid argument

/dev/sda1 / reiserfs rw 0 0

Yes, this is a reiserfs filesystem we are testing on.  This is a new
machine and probabally the only one reporting to TKO with reiserfs as
its root filesystem.

Can you explain what difference this option makes, and why it is
changing the visible semantics of the filesystem?  Is this valid?

-apw
