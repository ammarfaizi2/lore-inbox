Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268488AbUHYCVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268488AbUHYCVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 22:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUHYCVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 22:21:41 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:45172 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268488AbUHYCUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 22:20:52 -0400
Message-ID: <412BF780.3090508@yahoo.com.au>
Date: Wed, 25 Aug 2004 12:20:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Serban Simu <serban@asperasoft.com>
CC: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: page allocation failure & sk98lin
References: <412AE018.8000207@asperasoft.com> <412AF360.60005@yahoo.com.au> <412BA4FC.2070505@asperasoft.com>
In-Reply-To: <412BA4FC.2070505@asperasoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serban Simu wrote:
> Thank you, Nick. Just wanted to mention that while I understand that we 
> recover from this allocation failure (and also I don't mind the stack 
> printouts), about 20% of my incoming network traffic (600-700 Mbps) 
> seems to be dropped in the process.

Yeah that is expected - so I guess it isn't exactly 'harmless' if
performance is critical.

> Does the memory manager have to 
> spend a considerable amount of time to recover?
> 
> I will have a look at the -mm fixes, thanks for the idea.
> 

The relevant patch is this one which is now merged into 2.6.

http://linux.bkbits.net:8080/linux-2.5/cset@412b8828ClkE2ZwNwGQ02aYoMwb7-A?nav=index.html|ChangeSet@-1d

It would be nice if you can test that. It will give GFP_ATOMIC allocators
a larger buffer between starting memory reclaim, and failing their allocations.

However if it is a production system and you can't test patches, Marcelo
pointed out that you should be able to work around the problem by increasing
/proc/sys/vm/min_free_kbytes. Then maybe you could try 2.6.9 with min_free_kbytes
back to its default setting :)
