Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVDFK7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVDFK7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 06:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVDFK7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 06:59:09 -0400
Received: from mail.customers.edis.at ([62.99.242.131]:50599 "EHLO
	smtp-1.edis.at") by vger.kernel.org with ESMTP id S262160AbVDFK7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 06:59:04 -0400
Message-ID: <4253C0FC.6070402@lawatsch.at>
Date: Wed, 06 Apr 2005 12:59:08 +0200
From: Philip Lawatsch <philip@lawatsch.at>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
References: <3Ojst-4kX-19@gated-at.bofh.it> <3OGIo-7oY-13@gated-at.bofh.it> <3OGIo-7oY-15@gated-at.bofh.it> <3OGIo-7oY-17@gated-at.bofh.it> <3OGIo-7oY-11@gated-at.bofh.it> <3OIh7-cc-1@gated-at.bofh.it> <3OITV-AR-3@gated-at.bofh.it> <3PxjH-812-3@gated-at.bofh.it> <42535FFF.4080503@shaw.ca>
In-Reply-To: <42535FFF.4080503@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Alan Cox wrote:
> 
>> On Sad, 2005-04-02 at 05:50, Robert Hancock wrote:
>>
>>> I'm wondering if one does a ton of these cache-bypassing stores
>>> whether something gets hosed because of that. Not sure what that
>>> could be though. I don't imagine the chipset is involved with any of
>>> that on the Athlon 64 - either the CPU or RAM seems the most likely
>>> suspect to me
>>
>>
>>
>> The glibc version is essentially the "perfect" copy function for the
>> CPU. If you have any bus/memory problems or chipset bugs it will bite
>> you.
> 
> 
> Anyone have any suggestions on how to track this further? It seems
> fairly clear what circumstances are causing it, but as for figuring out
> what's at fault..

Digging through my glibc's source if found that if you memset arrays
<120000 bytes it will use good old mov instructions to do the job. In
case of arrays larger than 120000 bytes it will use movnti instructions
to do the job.

Thus I refined my test code to use mov for memset regardless of the size
(simply abused glibcs code a little bit)

-> No crash!

Then, changing the all the mov to movnti and my machine frags again :(

It seems that mov'ing does not kill my machine while simply using movnti
does.

kind regards Philip

