Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTE0ESg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTE0ESg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:18:36 -0400
Received: from adsl-67-122-203-155.dsl.snfc21.pacbell.net ([67.122.203.155]:1195
	"EHLO ext.storadinc.com") by vger.kernel.org with ESMTP
	id S263322AbTE0ESc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:18:32 -0400
Message-ID: <3ED2EA26.9060100@storadinc.com>
Date: Mon, 26 May 2003 21:31:34 -0700
From: manish <manish@storadinc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <Pine.LNX.4.55L.0305270103220.32094@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>
>On Mon, 26 May 2003, manish wrote:
>
>>Hello !
>>
>>I am running the 2.4.20 kernel on a system with 3.5 GB RAM and dual CPU.
>>I am running bonnie accross four drives in parallel:
>>
>>bonnie -s 1000 -d /<dir-name>
>>
>>bdflush settings on this system:
>>
>>[root@dyn-10-123-130-235 vm]# cat bdflush
>>2       50      32      100     50      300     1       0       0
>>
>>All the bonnie process and any other process (like df, ps -ef etc.) are
>>hung in __lock_page. Breaking into kdb, I observe the following for one
>>such bonnie process:
>>
>>schedule(..)
>>__lock_page(..)
>>lock_page(..)
>>do_generic_file_read(..)
>>generic_file_read(..)
>>
>>After this, the processes never exit the hang. At times, a couple of
>>bonnie processes complete but the hang still occurs with the remaining
>>processes and with the other processes.
>>
>>I tried out the 2.5.33 kernel (one of the 2.5 series) and observed that
>>the hang does not occur. If I run, two bonnie processes, they never get
>>stuck. Actually, if I run 4 parallel mke2fs, they too get stuck.
>>
>>Any clues where this could be happening?
>>
>
>Hi,
>
>Are you sure there is no disk activity ?
>
>Run vmstat and check that, please.
>
Hello !

My bad. This is one of the kernels that had modified the IO subsystem to 
replace the io_request_lock with a finer grained host_lock and queue_lock.

I also noticed that the hang occurs when the settings of bdflush are the 
following:

root@dyn-10-123-130-235 vm]# cat bdflush
30      50      32      100     50      300     60      0       0

Thanks
-Manish





