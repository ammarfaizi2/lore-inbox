Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWAOW1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWAOW1G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 17:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWAOW1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 17:27:06 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:33476 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750872AbWAOW1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 17:27:05 -0500
Message-ID: <43CACC34.504@cfl.rr.com>
Date: Sun, 15 Jan 2006 17:27:00 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com> <m3oe2e2983.fsf@telia.com> <43C94464.4040500@cfl.rr.com> <m3hd861o2r.fsf@telia.com> <43C982C0.1070605@cfl.rr.com> <m3r779z9on.fsf@telia.com> <43CA89A4.3010000@cfl.rr.com> <m3k6d1z87g.fsf@telia.com>
In-Reply-To: <m3k6d1z87g.fsf@telia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Surely the kernel can allocate pagable memory if it chooses to?  I think 
in the case of pktcdvd it would be best for the buffers to be pagable 
when initially allocated and filled, and only locked into memory when 
the bio is sent down to the cdrom driver.  That way you could keep a 
fairly large number of buffers on larger ( 256 KB+ ) packets in memory 
for write combining, without placing undue burden on non paged pool. 


Peter Osterlund wrote:

>>Ahh, excellent.  Also, is the memory currently non pagable?  Is there
>>a reason for that?
>>    
>>
>
>Yes the memory is non pagable. The linux kernel doesn't support
>pagable kernel memory, only user space memory can be swapped out.
>
>  
>

