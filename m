Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVGTPsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVGTPsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 11:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVGTPsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 11:48:40 -0400
Received: from gate.corvil.net ([213.94.219.177]:5638 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261151AbVGTPsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 11:48:39 -0400
Message-ID: <42DE7249.6090102@draigBrady.com>
Date: Wed, 20 Jul 2005 16:48:25 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mauricio Lin <mauriciolin@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: How do you accurately determine a process' RAM usage?
References: <42CC2923.2030709@draigBrady.com>	 <20050706181623.3729d208.akpm@osdl.org>	 <42CCE737.70802@draigBrady.com>	 <20050707014005.338ea657.akpm@osdl.org>	 <42D39102.5010503@draigBrady.com>	 <3f250c7105071913091c5b2858@mail.gmail.com>	 <42DE60D8.2070101@draigBrady.com> <3f250c7105072008321c128deb@mail.gmail.com>
In-Reply-To: <3f250c7105072008321c128deb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Lin wrote:
> Hi Brady,
> 
> On 7/20/05, P@draigbrady.com <P@draigbrady.com> wrote:
> 
>>The following shell gets the shared values for the
>>first httpd process:
>>
>>FIRST_HTTPD=`ps -C httpd -o pid= | head -1 | tr -d ' '`
>>HTTPD_STATM_SHARED=$(expr 4 '*' `cut -f3 -d' ' /proc/$FIRST_HTTPD/statm`)
>>HTTPD_SMAPS_SHARED=$(grep Shared /proc/$FIRST_HTTPD/smaps | tr -s ' '
>>| cut -f2 -d' ' | ( tr '\n' +; echo 0 ) | bc)
>>
>>
>>This shows that "smaps" reports 3060 KB more shared mem than "statm".
>>However adding up all the anon sections in smaps only gives 2456 KB?
> 
> 
> You are adding up all Shared_Clean and Shared_Dirty as Shared, right?

yes. Look at the command I posted.

>>When doing this I also noticed that there are duplicate
>>entries in smaps. Any ideas why?
> 
> 
> Each pair of address per line indicates the start and end address of a
> memory area (VMA) such as:
> 
> b7f7d000-b7f7e000 
> 
> This means that an specific memory area start on virtual address 
> b7f7d000 and end on b7f7e000 .
> 
> An mapped file like /lib/ld-2.3.3.so is organized in different memory
> areas. The memory area can be a text section, data section or bss. So
> it is normal you find the same filename mapped in more than one memory
> area.

yes. Look at the command I posted.
There are multiple entries with the _same addresses_

>>grep -F - /proc/$FIRST_HTTPD/smaps | sort | uniq -d -c

-- 
Pádraig Brady - http://www.pixelbeat.org
--
