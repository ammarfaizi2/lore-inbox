Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTE0S7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTE0S7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:59:49 -0400
Received: from adsl-67-122-203-155.dsl.pltn13.pacbell.net ([67.122.203.155]:6847
	"EHLO ext.storadinc.com") by vger.kernel.org with ESMTP
	id S263315AbTE0S7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:59:47 -0400
Message-ID: <3ED3B899.6070804@storadinc.com>
Date: Tue, 27 May 2003 12:12:25 -0700
From: manish <manish@storadinc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <20030527182547.GG3767@dualathlon.random> <Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva> <200305272039.18330.m.c.p@wolk-project.de> <3ED3B5CA.7050001@storadinc.com> <Pine.LNX.4.55L.0305271601370.2100@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>
>On Tue, 27 May 2003, manish wrote:
>
>>Marc-Christian Petersen wrote:
>>
>>>On Tuesday 27 May 2003 20:33, Marcelo Tosatti wrote:
>>>
>>>Hi Marcelo,
>>>
>>>>It seems your "fix-pausing" patch is fixing a potential wakeup
>>>>miss, right? (I looked quickly throught it). Could you explain me the
>>>>problem its trying to fix and how?
>>>>
>>>Please have also a look here:
>>>
>>>http://hypermail.idiosynkrasia.net/linux-kernel/archived/2002/week45/0305.html
>>>
>>>ciao, Marc
>>>
>>Hello !
>>
>>I applied the fix-pausing-2 patch to the 2.4.20 kernel. This time on,
>>the stack trace:
>>
>>sys_write
>>generic_file_write
>>ext2_get_group_desc
>>bread
>>__wait_on_buffer
>>schedule
>>
>
>Huh? You mean bonnie still deadlocks or ?
>
At the time the processes get stuck:


[root@dyn-10-123-130-235 vm]# more /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  3709870080 3699126272 10743808        0 18313216 3531255808
Swap: 1077501952        0 1077501952
MemTotal:      3622920 kB
MemFree:         10492 kB
MemShared:           0 kB
Buffers:         17884 kB
Cached:        3448492 kB
SwapCached:          0 kB
Active:          25252 kB
Inactive:      3445344 kB
HighTotal:     2752512 kB
HighFree:         2120 kB
LowTotal:       870408 kB
LowFree:          8372 kB
SwapTotal:     1052248 kB
SwapFree:      1052248 kB




