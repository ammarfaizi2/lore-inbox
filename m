Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWGHSGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWGHSGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWGHSGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:06:31 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:39230 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964933AbWGHSGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:06:17 -0400
Date: Sat, 08 Jul 2006 12:06:13 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()
In-reply-to: <fa.AmXizdwfdZtqgKFSMcRp3U0QZXI@ifi.uio.no>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Message-id: <44AFF415.2020305@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.AmXizdwfdZtqgKFSMcRp3U0QZXI@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abu M. Muttalib wrote:
> Hi,
> 
> I am getting the Out of memory.
> 
> To circumvent the problem, I have commented the call to "out_of_memory(),
> and replaced "goto restart" with "goto nopage".
> 
> At "nopage:" lable I have added a call to "schedule()" and then "return
> NULL" after "schedule()".

Bad idea - in the configuration you have, the system may need the 
out-of-memory killer to free up memory, otherwise the system can 
deadlock due to all memory being exhausted.

> 
> I tried the modified kernel with a test application, the test application is
> mallocing memory in a loop. Unlike as expected the process gets killed. On
> second run of the same application I am getting the page allocation failure
> as expected but subsequently the system hangs.
> 
> I am attaching the test application and the log herewith.
> 
> I am getting this exception with kernel 2.6.13. With kernel
> 2.4.19-rmka7-pxa1 there was no problem.
> 
> Why its so? What can I do to alleviate the OOM problem?

Please see Documentation/vm/overcommit-accounting in the kernel source tree.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

