Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVKHMsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVKHMsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVKHMsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:48:09 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:49165 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965030AbVKHMsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:48:08 -0500
Message-ID: <43709E86.8010203@vmware.com>
Date: Tue, 08 Nov 2005 04:48:06 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 4/21] i386 Broken bios common
References: <200511080422.jA84MQxK009859@zach-dev.vmware.com> <20051108071935.GB28201@elte.hu>
In-Reply-To: <20051108071935.GB28201@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2005 12:48:08.0167 (UTC) FILETIME=[AB4AEF70:01C5E462]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Zachary Amsden <zach@vmware.com> wrote:
>
>  
>
>> 	gdt = get_cpu_gdt_table(cpu);
>> 	save_desc_40 = gdt[0x40 / 8];
>>-	gdt[0x40 / 8] = bad_bios_desc;
>>+	gdt[0x40 / 8] = gdt[GDT_ENTRY_BAD_BIOS_CACHE];
>> 
>>    
>>
>
>i like the cleanup, but wouldnt it be simpler to dedicate GDT entry #8 
>to the 0x40 descriptor, and hence be compatible with such broken BIOSes 
>by default? Right now entry #8 is taken up by TLS segment #2, but we 
>could change GDT_ENTRY_TLS_MIN from 6 to 9 and push the TLS segments to 
>entries 9,10,11. [ Could there be any buggy SMM code that relies on 
>having something at 0x40? ]
>  
>

I worry that there could be buggy userspace code that relies on having 
selector 0x40 - notably Wine.  So although I would like to make 0x40 the 
default, can't be guaranteed.

SMM code is safe, since it gets SMRAM mapped in on entry and has 
descriptor saved state so it can mess with tables as it sees fit without 
worrying about restoring anything.

Zach
