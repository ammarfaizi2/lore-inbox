Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUJBAP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUJBAP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUJBAP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:15:28 -0400
Received: from gizmo02ps.bigpond.com ([144.140.71.12]:65212 "HELO
	gizmo02ps.bigpond.com") by vger.kernel.org with SMTP
	id S266884AbUJBANM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:13:12 -0400
Message-ID: <415DF294.1050707@bigpond.net.au>
Date: Sat, 02 Oct 2004 10:13:08 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
References: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com> <20041001120926.4d6f58d5.akpm@osdl.org> <1096666140.12861.82.camel@dyn318077bld.beaverton.ibm.com> <20041001145536.182dada9.akpm@osdl.org> <1096672002.12861.84.camel@dyn318077bld.beaverton.ibm.com> <20041001164938.3231482e.akpm@osdl.org>
In-Reply-To: <20041001164938.3231482e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
>>Here is the full sysrq-t output.
> 
> 
> What's this guy up to?
> 
> db2fmcd       D 0000000000000000     0 11032      1          1373 11031 (NOTLB)
> 00000101b9b9bef8 0000000000000002 0000003700000037 00000101c13608a0 
>        000000010000009f 0000010199649250 0000010199649588 0000000000000000 
>        0000000000000206 ffffffff801353db 
> Call Trace:<ffffffff801353db>{try_to_wake_up+971} <ffffffff80445570>{__down_write+128} 
>        <ffffffff80125e7f>{sys32_mmap+143} <ffffffff80124b01>{ia32_sysret+0} 
>        
> 
> Something is seriously screwed up if it's stuck in try_to_wake_up().  Tried
> generating a few extra traces?
> 
> Then again, maybe we're missing an up_read() somewhere.  hrm, I'll check.

It's highly^64 unlikely BUT a possible reason for a task getting stuck 
in try_to_wakeup() is the function adjust_sched_timestamp() which is 
part of the ZAPHOD patch.  This could be tested by removing the if-while 
statement from that function and seeing if that fixes things.  Or you 
could just remove the call from try_to_wake_up().

I'll use a more sensible (bounded) mechanism in the next version of ZAPHOD.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
