Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUJBA0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUJBA0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUJBA0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:26:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:46039 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266878AbUJBA0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:26:52 -0400
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041001164938.3231482e.akpm@osdl.org>
References: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
	 <20041001120926.4d6f58d5.akpm@osdl.org>
	 <1096666140.12861.82.camel@dyn318077bld.beaverton.ibm.com>
	 <20041001145536.182dada9.akpm@osdl.org>
	 <1096672002.12861.84.camel@dyn318077bld.beaverton.ibm.com>
	 <20041001164938.3231482e.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1096676374.12861.91.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Oct 2004 17:19:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 16:49, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Here is the full sysrq-t output.
> 
> What's this guy up to?
...
> 
> Something is seriously screwed up if it's stuck in try_to_wake_up().  Tried
> generating a few extra traces?
> 
> Then again, maybe we're missing an up_read() somewhere.  hrm, I'll check.
> 

It reproduced again. I think this is the one causing all the troubles..

db2fmcd       D ffffffff80132e2a     0 10854   7636                    
(NOTLB)
00000101bae85ef8 0000000000000002 0000020800000018 00000101d9ddd550
       0000000100000084 000001016d490e20 000001016d491158
00000101d9ddd550
       0000000000000206 ffffffff801353cb
Call Trace:<ffffffff801353cb>{try_to_wake_up+971}
<ffffffff804455f0>{__down_write+128}
       <ffffffff80125e6f>{sys32_mmap+143}
<ffffffff80124af1>{ia32_sysret+0}

when I tried looking at /proc/10854 - it hung.

elm3b29:~ # cd /proc/10854
elm3b29:/proc/10854 # l

ls            D 000000000051bb70     0 28029  27737                    
(NOTLB)
00000101ac9b1e28 0000000000000006 702e6d6574737973 ffffffff8054f240
       000000000000009f 00000101df4fa9a0 00000101df4facd8
0000000000000000
       000000d000000002 00000101ac9b1e68
Call Trace:<ffffffff80445692>{__down_read+130}
<ffffffff801b79a9>{proc_exe_link+73}
       <ffffffff801b7745>{proc_pid_readlink+165}
<ffffffff8018a511>{sys_readlink+161}
       <ffffffff8011075e>{system_call+126}


I have no idea what db2fmcd is stuck on. I will try to find out more..

Thanks,
Badari


