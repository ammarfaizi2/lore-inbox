Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTINF3L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 01:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTINF3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 01:29:11 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:8687 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262308AbTINF3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 01:29:10 -0400
Message-ID: <3F63FC82.8070008@nortelnetworks.com>
Date: Sun, 14 Sep 2003 01:28:34 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
Cc: Jamie Lokier <jamie@shareable.org>, rusty@linux.co.intel.com,
       riel@conectiva.com.br, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>	 <20030913174825.GB7404@mail.jlokier.co.uk> <1063476152.24473.30.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Sat, 2003-09-13 at 13:48, Jamie Lokier wrote:
> 
> 
>>Also, when the OOM condition is triggered I'd like the system to
>>reboot, but first try for a short while to unmount filesystems cleanly.
>>
>>Any chance of those things?

<snip>

> I do like all of this, however, and want to see some different OOM
> killers.


One thing that we've done, and that others may find useful, is to allow 
processes to become immune to the oom-killer as long as they stay under 
a certain amount of memory allocated.

We added a syscall that specifies a certain number of pages of memory. 
As long as the process' memory utilization remains under that amount, 
the oom-killer will not kill it.

In our case we are on a mostly-embedded system, and have a pretty good 
idea what will be running.  This lets us engineer the critical apps to 
be immune, while still allowing memory to be freed up by killing 
non-critical applications.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

