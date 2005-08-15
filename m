Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbVHOKNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbVHOKNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 06:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbVHOKNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 06:13:10 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:64905 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932587AbVHOKNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 06:13:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cVz6/vNaK6/jDt0GidlSXA4h+CHe0BHOQTs8WbKdq+79bquMGUQb2abAzov5/qpy2VSJGPrlaLYZKQVNYFixG2DYJD2lCBVCfDWk67cSg1I5VwchRwm8NqBaAWgBmBEM9EE1Uz9VjEuPVT7wK1fd/UslDeTDvf9Nid3Pooq3pHg=  ;
Message-ID: <43006AA6.1040405@yahoo.com.au>
Date: Mon, 15 Aug 2005 20:12:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu
Subject: Re: [patch 18/39] remap_file_pages protection support: add VM_FAULT_SIGSEGV
References: <20050812182145.DF52E24E7F3@zion.home.lan> <20050815104022.D19811@flint.arm.linux.org.uk>
In-Reply-To: <20050815104022.D19811@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Aug 12, 2005 at 08:21:45PM +0200, blaisorblade@yahoo.it wrote:
> 
>>@@ -632,10 +632,11 @@ static inline int page_mapped(struct pag
>>  * Used to decide whether a process gets delivered SIGBUS or
>>  * just gets major/minor fault counters bumped up.
>>  */
>>-#define VM_FAULT_OOM	(-1)
>>-#define VM_FAULT_SIGBUS	0
>>-#define VM_FAULT_MINOR	1
>>-#define VM_FAULT_MAJOR	2
>>+#define VM_FAULT_OOM		(-1)
>>+#define VM_FAULT_SIGBUS		0
>>+#define VM_FAULT_MINOR		1
>>+#define VM_FAULT_MAJOR		2
>>+#define VM_FAULT_SIGSEGV	3
>> 
>> #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
>> 
> 
> 
> Please arrange for "success" values to be numerically larger than "failure"
> values.  This will avoid breaking ARM.
> 
> Is there a reason why we don't use -ve numbers for failure and +ve for
> success here?
> 

Well there is now, and that is we are now using a bit in the 2nd
byte as flags. So I had to do away with -ve numbers there entirely.

You could achieve a similar thing by using another bit in that byte
#define VM_FAULT_FAILED 0x20
and make that bit present in VM_FAULT_OOM and VM_FAULT_SIGBUS, then
do an unlikely test for that bit in your handler and branch away to
the slow path.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
