Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWDGLuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWDGLuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 07:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWDGLuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 07:50:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48524 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964781AbWDGLuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 07:50:23 -0400
Message-ID: <443651D7.6020901@redhat.com>
Date: Fri, 07 Apr 2006 07:49:43 -0400
From: Hideo AOKI <haoki@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 1/3] mm: An enhancement of OVERCOMMIT_GUESS
References: <4434570F.9030507@redhat.com>	<20060406094533.b340f633.kamezawa.hiroyu@jp.fujitsu.com>	<4434C12A.4000108@redhat.com> <20060406170851.1402c78d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060406170851.1402c78d.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: multipart/mixed;
 boundary="------------020700080200080102050801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020700080200080102050801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kamezawa-san,

Thank you for your quick response. And sorry for slow response.

KAMEZAWA Hiroyuki wrote:

> Hideo AOKI <haoki@redhat.com> wrote:
> 
>>Since __vm_enough_memory() doesn't know zone and cpuset information,
>>we have to guess proper value of lowmem_reserve in each zone
>>like I did in calculate_totalreserve_pages() in my patch.
>>Do you think that we can do this calculation every time?
>>
>>If it is good enough, I'll make revised patch.
>>
> 
> I just thought to show "how to calculate" in unified way is better.

I got it.

> Do you have a detailed comparison of test result with and without this patch ?

Yes. I have test logs and attach them to this e-mail.

The logs are verbose output of my test kernel module which I already
sent to lkml.
http://marc.theaimsgroup.com/?l=linux-kernel&m=114428121522349&w=2

Test machine was i386 4GB memory PC. I didn't use swap region.


Let me explain a few things about the log.

* 2.6.17-rc1-mm1

HIGH: <active 18220><inactive 12278><free 1419><sum 31917><present 622220>
NORMAL: <active 1618><inactive 2293><free 1397><sum 5308><present 225280>

   The test module consumes free pages until the number of free pages
   is less than pages_high.


<buf 3916><cache 31785><slab reclaim 1550><swap 0> <+ 1> <target 33336>

   This line shows the status of memory just before the module calls
   __vm_enough_memory(). Meaning of each item is below.

     buf:            bufferram
     cache:          page cache
     slab reclaim:   slab_reclaim_pages
     swap:           nr_swap_pages
     +:              margin
     target:         the number of pages to ask __vm_enough_memory()


Test MAY be <failed>.

   This line shows __vm_enough_memory() returned success.


Please let me know if you have any questions and suggestions.

Regards,
Hideo Aoki

---
Hideo Aoki, Hitachi Computer Products (America) Inc.

--------------020700080200080102050801
Content-Type: text/plain;
 name="log-2.6.17-rc1-mm1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log-2.6.17-rc1-mm1.txt"

* 2.6.17-rc1-mm1

Apr  6 20:33:33 dhcp1 kernel: Test module was loaded. <mode 1>
Apr  6 20:33:33 dhcp1 kernel: init ...<3>done
Apr  6 20:33:33 dhcp1 kernel:
Apr  6 20:33:33 dhcp1 kernel: HIGH: <active 18238><inactive 12278><free 590698><sum 621214><present 622220>
Apr  6 20:33:34 dhcp1 kernel: HighMem <target 589272>, <3>
Apr  6 20:33:34 dhcp1 kernel: HIGH: <active 18220><inactive 12278><free 1512><sum 32010><present 622220>
Apr  6 20:33:34 dhcp1 kernel:
Apr  6 20:33:34 dhcp1 kernel: HIGH: <active 18220><inactive 12278><free 1512><sum 32010><present 622220>
Apr  6 20:33:34 dhcp1 kernel: HighMem <target 86>, <3>
Apr  6 20:33:34 dhcp1 kernel: HIGH: <active 18220><inactive 12278><free 1419><sum 31917><present 622220>
Apr  6 20:33:34 dhcp1 kernel: already satisfied
Apr  6 20:33:34 dhcp1 kernel:
Apr  6 20:33:34 dhcp1 kernel: NORMAL: <active 1618><inactive 2277><free 205532><sum 209427><present 225280>
Apr  6 20:33:34 dhcp1 kernel: Normal <target 204124>, <3>
Apr  6 20:33:34 dhcp1 kernel: NORMAL: <active 1618><inactive 2291><free 1490><sum 5399><present 225280>
Apr  6 20:33:34 dhcp1 kernel:
Apr  6 20:33:34 dhcp1 kernel: NORMAL: <active 1618><inactive 2293><free 1490><sum 5401><present 225280>
Apr  6 20:33:34 dhcp1 kernel: Normal <target 82>, <3>
Apr  6 20:33:34 dhcp1 kernel: NORMAL: <active 1618><inactive 2293><free 1428><sum 5339><present 225280>
Apr  6 20:33:34 dhcp1 kernel:
Apr  6 20:33:34 dhcp1 kernel: NORMAL: <active 1618><inactive 2293><free 1428><sum 5339><present 225280>
Apr  6 20:33:34 dhcp1 kernel: Normal <target 20>, <3>
Apr  6 20:33:34 dhcp1 kernel: NORMAL: <active 1618><inactive 2293><free 1397><sum 5308><present 225280>
Apr  6 20:33:34 dhcp1 kernel: already satisfied
Apr  6 20:33:34 dhcp1 kernel: concrete test ...
Apr  6 20:33:34 dhcp1 kernel: <buf 3916><cache 31785><slab reclaim 1550><swap 0> <+ 1> <target 33336>
Apr  6 20:33:34 dhcp1 kernel: Test MAY be <failed>.
Apr  6 20:33:34 dhcp1 kernel: allocation failed: out of vmalloc space - use
vmalloc=<size> to increase size.
Apr  6 20:33:35 dhcp1 kernel: allocation failed: out of vmalloc space - use
vmalloc=<size> to increase size.
Apr  6 20:33:35 dhcp1 kernel: Test SURELY was <FAILED>.
Apr  6 20:33:35 dhcp1 kernel: concrete test ...done.

--------------020700080200080102050801
Content-Type: text/plain;
 name="log-2.6.17-rc1-mm1+patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log-2.6.17-rc1-mm1+patch.txt"

* 2.6.17-rc1-mm1 + patches

Apr  6 20:56:36 dhcp1 kernel: Test module was loaded. <mode 1>
Apr  6 20:56:36 dhcp1 kernel: init ...<3>done
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: HIGH: <active 17074><inactive 13427><free 590727><sum 621228><present 622220>
Apr  6 20:56:36 dhcp1 kernel: HighMem <target 589301>, <3>
Apr  6 20:56:36 dhcp1 kernel: HIGH: <active 17074><inactive 13427><free 1479><sum 31980><present 622220>
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: HIGH: <active 17074><inactive 13427><free 1479><sum 31980><present 622220>
Apr  6 20:56:36 dhcp1 kernel: HighMem <target 53>, <3>
Apr  6 20:56:36 dhcp1 kernel: HIGH: <active 17074><inactive 13427><free 1417><sum 31918><present 622220>
Apr  6 20:56:36 dhcp1 kernel: already satisfied
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2248><free 205669><sum 209543><present 225280>
Apr  6 20:56:36 dhcp1 kernel: Normal <target 204261>, <3>
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2262><free 1441><sum 5329><present 225280>
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2264><free 1441><sum 5331><present 225280>
Apr  6 20:56:36 dhcp1 kernel: Normal <target 33>, <3>
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2264><free 1410><sum 5300><present 225280>
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2264><free 1410><sum 5300><present 225280>
Apr  6 20:56:36 dhcp1 kernel: Normal <target 2>, <3>
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel: Normal <target 2>, <3>
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel: Normal <target 2>, <3>
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel: Normal <target 2>, <3>
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel: Normal <target 2>, <3>
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel: Normal <target 2>, <3>
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel: Normal <target 2>, <3>
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel:
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1410><sum 5301><present 225280>
Apr  6 20:56:36 dhcp1 kernel: Normal <target 2>, <3>
Apr  6 20:56:36 dhcp1 kernel: NORMAL: <active 1626><inactive 2265><free 1379><sum 5270><present 225280>
Apr  6 20:56:36 dhcp1 kernel: already satisfied
Apr  6 20:56:36 dhcp1 kernel: concrete test ...
Apr  6 20:56:36 dhcp1 kernel: <buf 3902><cache 31720><slab reclaim 1538><swap 0> <+ 1> <target 33259>
Apr  6 20:56:36 dhcp1 kernel: Test was <PASSED>.
Apr  6 20:56:36 dhcp1 kernel: concrete test ...done.
Apr  6 20:56:48 dhcp1 kernel: Unloading module ...

--------------020700080200080102050801--
