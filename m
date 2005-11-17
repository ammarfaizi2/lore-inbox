Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVKQQHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVKQQHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVKQQHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:07:52 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:5454 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S932301AbVKQQHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:07:52 -0500
Message-ID: <437CAA62.8090101@samwel.tk>
Date: Thu, 17 Nov 2005 17:05:54 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Jan Niehusmann <jan@gondor.com>
CC: Bradley Chapman <kakadu@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <e294b46e0511170522v5762d48jcaff8413e33b2ebe@mail.gmail.com> <437C9334.3020606@samwel.tk> <20051117154124.GA1813@knautsch.gondor.com>
In-Reply-To: <20051117154124.GA1813@knautsch.gondor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:
>> Bradley, Jan, since when have these problems been happening? Kernel 
>> version-wise, I mean?
> 
> I didn't notice these problems before 2.6.14. As these corruptions are
> not happening very often, and as I usually do not run the notebook on
> battery power, the problem may have existed for a while, though.
> 
> Today I did a simple test: I activated laptop mode with a 10s idle
> timeout, and made a script write files with uniqe identifiers, followed
> by a sync, every 60 seconds. After nearly an hour, I didn't see any
> corruption, though at least some of these writes have triggered
> a spin-up. When I have some spare time I'll do more intensive testing.

Well, the syncs should trigger a spinup every time. Laptop mode does not 
influence syncs, really.

> Additionally, I mounted more than half of the partitions on this
> notebook read only, and made a 1:1 copy of these partitions to an
> external hard drive. Therefore, I can check later if something
> accidentally did write to these areas.

"more than half"? Exactly how many partitions *are* there on this 
notebook? ;)

> If you have any suggestions for additional test, please tell me.

Perhaps you could enable /proc/sys/vm/block_dump. This makes the kernel 
output all disk activity, including block numbers. By looking up the 
corrupted block numbers in your logs you can check later if the 
corrupting write was done by the kernel (i.e., software fault) or not 
(hardware fault).

Note that the output of block_dump may not go into your logs by default, 
because it's output with KERN_DEBUG. You may need to change your log 
settings.

You can add extra context on ext3's state by enabling JBD debugging 
(CONFIG_JBD_DEBUG, IIRC).

> The random filesystem corruption had one positive effect: I never had
> such a good backup of my data before. ;-)

It made me rethink my backup strategy as well. :)

--Bart
