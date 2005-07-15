Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263217AbVGOFaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263217AbVGOFaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 01:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbVGOFap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 01:30:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62659 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263213AbVGOFaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 01:30:09 -0400
Message-ID: <42D7495F.3030502@us.ibm.com>
Date: Thu, 14 Jul 2005 22:27:59 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel McNeil <daniel@osdl.org>
CC: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net>	 <1121382983.6755.87.camel@dyn9047017102.beaverton.ibm.com> <1121384672.6025.81.camel@ibm-c.pdx.osdl.net>
In-Reply-To: <1121384672.6025.81.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil wrote:

> On Thu, 2005-07-14 at 16:16, Badari Pulavarty wrote:
> 
>>How does your patch ensures that we meet the driver alignment
>>restrictions ? Like you said, you need atleast "even" byte alignment
>>for IDE etc..
>>
>>And also, are there any restrictions on how much the "minimum" IO
>>size has to be ? I mean, can I read "1" byte ? I guess you are
>>not relaxing it (yet)..
>>
> 
> 
> This patch does not change the i/o size requirements -- they
> must be a multiple of device block size (usually 512).
> 
> It only relaxes the address alignment restriction.  I do not
> know what the driver alignment restrictions are.  Without the
> 1st patch, it was impossible to relax the address space
> check and have direct-io generate the correct i/o's to submit.
> 
> This 2nd patch, is just for testing and generating feedback
> to find out what the address alignment issues are.  Then
> we can decide how to proceed.
> 
> Did you look over the 1st patch?  Comments?

Yes. I did look at the first patch and my questions were basically
towards the first patch. I don't see any enforcement of alignment
with your patch at all. So, we let the driver fail if it can't
handle it ?

BTW, I don't think the first patch is really doing the right thing.
You got little carried away while cleaning up.
You are trying to relax "user buffer" alignment only. If your
"offset" is in the middle of a filesystem block (say 4k), you still
need to zero out the first portion to be able to write into the
middle. That "evil" code is still needed. :(

Thanks,
Badari

