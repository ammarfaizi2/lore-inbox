Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272126AbTG2UsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272128AbTG2UsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:48:25 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:38392
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272126AbTG2UsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:48:18 -0400
Message-ID: <3F26E044.9010202@rogers.com>
Date: Tue, 29 Jul 2003 16:59:48 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: WINE + Galciv + Con Kolivas's 011 patch to  2.6.0-test2
References: <3F22F75D.8090607@rogers.com> <200307291325.09096.kernel@kolivas.org> <3F266D33.4040106@rogers.com> <200307292246.36808.kernel@kolivas.org>
In-Reply-To: <200307292246.36808.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [65.49.219.239] using ID <dw2price@rogers.com> at Tue, 29 Jul 2003 16:47:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tue, 29 Jul 2003 22:48, gaxt wrote:
> 
>>I tried O11. Still chuggy in the AVIs and then locks out input into X. I
>>switch to Alt-F1 console and hear the video advance, switch back, it
>>pauses, switch to Alt-F1 etc. to get it through the video and then it's
>>fine.
>>
>>Incidentally, I moved my /home to another hard drive last night (same
>>7200 rpms) to get more space. It makes no difference to performance.
>>260-test2-vanilla was quite good and -mm1 and -O11 are chuggy and lock
>>out input to X and require switching to virtual console to advance
>>through the videos.
>>
>>If there is some other data I can provide you, let me know.
> 
> 
> What top shows as the PRI of all the important processes concerned during all 
> this would be helpful.
> 
> Con

It's hard to grab top info as the interface freezes up. I'd have to ssh 
in from another system.

However, browsing lkml, I noticed someone saying I/O throughput was 
affected by a readahead setting of 256 instead of 512 using hdparm -a 
###. I changed the readahead on my root and home drives and galciv was 
able to load (with some mild stuttering in the movies).

I've never adjusted this setting before. Perhaps it compensates for 
scheduler activity by allowing the system to draw more data within a 
given timeslice? Or am I babbling?

Running top while glaciv + wine is running with the new hdparm -a 512 
setting, I can mention the following patterns:

When loading up playing AVIs, the top are wineserver, wine, wine, and X 
(there is also another wine process). When the game chugs/pauses badly 
in playing an avi, wineserver leaps to the top with >50% CPU with 
wineserver+wine processes+x taking 100% CPU. Then when chugging lapses, 
wineserver drops down to the 26% range and the other wine processes are 
the same or a bit above. When the game is loaded, two wine processes at 
21% CPU each are at top, then X with 5-10% then wineserver with 2-3% (a 
huge drop) or even a couple of appas above wineserver.

Perhaps this data helps?

