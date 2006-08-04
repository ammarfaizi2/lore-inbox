Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbWHDIWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWHDIWm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWHDIWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:22:42 -0400
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:2994 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1030199AbWHDIWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:22:41 -0400
Message-ID: <44D3041E.501@kolumbus.fi>
Date: Fri, 04 Aug 2006 11:23:58 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: kmannth@us.ibm.com
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, y-goto@jp.fujitsu.com,
       andrew <akpm@osdl.org>
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>	 <1154650396.5925.49.camel@keithlap>	 <20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>	 <1154656472.5925.71.camel@keithlap>	 <20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>	 <1154660408.5925.79.camel@keithlap>	 <20060804121308.e9720b49.kamezawa.hiroyu@jp.fujitsu.com>	 <1154661826.5925.92.camel@keithlap>	 <20060804124847.610791b5.kamezawa.hiroyu@jp.fujitsu.com> <1154665534.5925.98.camel@keithlap>
In-Reply-To: <1154665534.5925.98.camel@keithlap>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2 HF462|May 23, 2006) at 04.08.2006 11:22:33,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 04.08.2006 11:22:33,
	Serialize complete at 04.08.2006 11:22:33,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 04.08.2006 11:22:33,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 04.08.2006 11:22:39,
	Serialize complete at 04.08.2006 11:22:39
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

keith mannthey wrote:
> On Fri, 2006-08-04 at 12:48 +0900, KAMEZAWA Hiroyuki wrote:
>   
>> On Thu, 03 Aug 2006 20:23:46 -0700
>> keith mannthey <kmannth@us.ibm.com> wrote:
>>     
>
>   
>>>>> What keeps 0xa0000000 to 0xa1000000 from being re-onlined by a bad call
>>>>> to add_memory?
>>>>>           
>>>> Usual sparsemem's add_memory() checks whether there are sections in
>>>> sparse_add_one_section(). then add_pages() returns -EEXIST (nothing to do).
>>>> And ioresouce collision check will finally find collision because 0-0xbffffff
>>>> resource will conflict with 0xa0000000 to 0xa10000000 area.
>>>> But, x86_64 's (not sparsemem) add_pages() doen't do collision check, so it panics.
>>>>         
>>> I have paniced with your 5 patches while doing SPARSMEM....  I think
>>> your 6th patch address the issues I was seeing.  
>>>
>>>       
>
>
> with the 6 patches things work as expected.  It is nice to have the
> sysfs devices online the correct amount of memory.  
>
> I was broken without this patch because invalid add_memory calls are
> made on by box (yet another issue) during boot. 
>
> I will build my patch set on top of your 6 patches. 
>
> Thanks,
>   Keith 
>
>   
Keith, are you working on the reserve hotadd case? It looks really 
broken, at the same time we both assume the hot add region contains RAM 
per e820 (use of reserve_bootmem_node()) and at the same time in other 
places (in reserve_hotadd()) that it may not contain RAM. And 
nodes_cover_memory() is broken no matter what we assume.


--Mika

