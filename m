Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbVLOJGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbVLOJGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbVLOJGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:06:36 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:59576 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161086AbVLOJGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:06:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=rtUnyyUTPsFHt57HFy1zl64hyQLFTxaUo/8crKxoprV7cDL2Q8mEEOb+9KeOpI8rWaVPRDDoOo9i5FqnGg3MfG2BcZ6AHgQPqqOjPfJDQIF5rap3ZixdiSsUp0h2gu2vhoGhQ69Bl5GVrR/KFlAI18nRX84pyC22vYXPu39kJ2s=  ;
Message-ID: <43A13216.8000104@yahoo.com.au>
Date: Thu, 15 Dec 2005 20:06:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Miles Lane <miles.lane@gmail.com>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.15-rc5-mm3 -- BUG: using smp_processor_id() in preemptible
 [00000001] code: swapper/1
References: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com> <20051215004028.0bf9791f.akpm@osdl.org>
In-Reply-To: <20051215004028.0bf9791f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>A little later, I get this:
>>
>>[4294676.542000] BUG: using smp_processor_id() in preemptible
>>[00000001] code: rcS/942
>>[4294676.542000] caller is mod_page_state_offset+0x12/0x28
>>[4294676.542000]  [<c1003723>] dump_stack+0x16/0x1a
>>[4294676.554000]  [<c110c1eb>] debug_smp_processor_id+0x77/0x90
>>[4294676.565000]  [<c10413d3>] mod_page_state_offset+0x12/0x28
>>[4294676.577000]  [<c104911b>] __handle_mm_fault+0x1f/0x18e
>>[4294676.589000]  [<c1013d7f>] do_page_fault+0x170/0x492
>>[4294676.600000]  [<c10033f7>] error_code+0x4f/0x54
>>[4294676.612000]  [<c10027ae>] ret_from_fork+0x6/0x14
> 
> 
> Nick.
> 
> 

Silly me, it is doing the local_irq_save *after* the __get_cpu_var.
Sorry for the typo. However the bug is harmless and will just result
in skewed statistics in the very rare chance of a race.

Thanks for reporting.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
