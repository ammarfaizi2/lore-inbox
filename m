Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269416AbUIIKlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269416AbUIIKlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269418AbUIIKlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:41:36 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:58958 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269416AbUIIKlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:41:03 -0400
Message-ID: <41402F73.6060804@yahoo.com.au>
Date: Thu, 09 Sep 2004 20:24:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Nathan Lynch <nathanl@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cpu: add a CPU_DOWN_PREPARE notifier
References: <413EFFFB.5050902@yahoo.com.au>  <413F0070.2020104@yahoo.com.au> <1094725418.25641.21.camel@bach>
In-Reply-To: <1094725418.25641.21.camel@bach>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Wed, 2004-09-08 at 22:52, Nick Piggin wrote:
> 
>>2/3
>>
>>Rusty, can I do this?
>>
>>______________________________________________________________________
>>Add a CPU_DOWN_PREPARE hotplug CPU notifier. This is needed so we can
>>dettach all sched-domains before a CPU goes down, thus we can build
>>domains from online cpumasks, and not have to check for the possibility
>>of a CPU coming up or going down.
> 
> 
> And if taking the CPU down fails?  If you need this, you need the
> CPU_DOWN_FAILED as well, unfortunately.  Hence I prefer the "do the
> domain thing while machine is frozen" and sidestep it entirely.
> 

Really? It doesn't need to be run from the stop_machine_run
context at all - it can happily be done while the system is
running.

That said, if you really object to CPU_DOWN_PREPARE and CPU_DOWN_FAILED,
it probably shouldn't be too much work. Should it make the call from
take_cpu_down?
