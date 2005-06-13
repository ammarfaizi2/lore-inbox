Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVFMBwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFMBwj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 21:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVFMBwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 21:52:39 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:59071 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261313AbVFMBwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 21:52:35 -0400
Message-ID: <42ACE590.5030904@lab.ntt.co.jp>
Date: Mon, 13 Jun 2005 10:46:56 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Andrew Morton <akpm@osdl.org>, axboe@suse.de, andrea@suse.de,
       linux-kernel@vger.kernel.org, rlrevell@joe-job.com
Subject: Re: Real-time problem due to IO congestion.
References: <42A91D36.8090506@lab.ntt.co.jp> <20050609234231.42a10763.akpm@osdl.org> <42A93D85.4060005@lab.ntt.co.jp> <20050610202515.GA21733@hh.idb.hist.no>
In-Reply-To: <20050610202515.GA21733@hh.idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your kind advices!

Our system has characteristics such as embedded system, and, 
unfortunately, such systems have the restriction that available disk is 
only 1(raid 1 mirrored one).
But the system has large memory (maximum 16GB), and SMP. (such as blade 
type system)

I think this problem can also be solved by modifying page cache 
transactions(assume there is huge page cache!), and this may guarantee 
somewhat real-time write even on single normal disk.
but this may be only the answer in case of huge page-cache, and may be 
not for user desktops.

what I'm considering is that the this approach is acceptable by kernel 
community or not?? (as you mentioned, kernel modify is one approach, and 
app level buffering is another approach).
If I or somebody made some patch, is there any possibility to be 
accepted? or this type of problem should not go into kernel?


Helge Hafting wrote:
> On Fri, Jun 10, 2005 at 04:13:09PM +0900, Takashi Ikebe wrote:
> 
>>I see.
>>The program which I tested is just sample, and I wanted to know the 
>>phenomena is spec or bug.
>>I also understand that this problem is spec, and need to apply some 
>>buffering to such applications.
>>
> 
> There is an alternative.  Get a separate disk just for the RT-job.
> You can then run your very heavy IO on other disks, the RT disk won't
> be delayed by that.
> 
> Helge Hafting
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp
