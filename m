Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUHXNYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUHXNYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUHXNYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:24:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56019 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267765AbUHXNYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:24:32 -0400
Date: Tue, 24 Aug 2004 09:24:19 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
In-Reply-To: <043101c489ab$bf6fe1d0$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0408240908530.19614-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Kaigai Kohei wrote:

> o UNIXbench
> 
> * INDEX value comparison
>                                        2.6.8.1   2.6.8.1   2.6.8.1   2.6.8.1
>                                      (Disable)  (Enable)  (rwlock)     (RCU)
> Dhrystone 2 using register variables    268.9     268.8     269.2     269.0
> Double-Precision Whetstone               94.2      94.2      94.2      94.2
> Execl Throughput                        388.3     379.0     377.8     377.9 +
> File Copy 1024 bufsize 2000 maxblocks   606.6     526.6     515.6     504.8 *
> File Copy 256 bufsize 500 maxblocks     508.9     417.0     410.4     395.2 *
> File Copy 4096 bufsize 8000 maxblocks   987.1     890.4     876.0     857.9 *
> Pipe Throughput                         525.1     406.4     404.5     408.8 +
> Process Creation                        321.2     317.8     315.9     316.3 +
> Shell Scripts (8 concurrent)           1312.8    1276.2    1278.8    1282.8 +
> System Call Overhead                    467.1     468.7     464.1     467.2 +
>                                     ========================================
>      FINAL SCORE                        445.8     413.2     410.1     407.7

This benchmark somewhat characterizes 1P performance, and the ones I've 
marked with (*) get noticably worse with the RCU patch compared to the 
current locking scheme.  Tests marked (+) show no or insignificant 
improvement.

Might be useful to compare with the lmbench macrobenchmark, to see if it 
shows a similar pattern.

> o dbench [ 4 processes run parallely on 4-CPUs / 10 times trials ]
>                   ---- mean ----  - STD -
> 2.6.8.1(disable)  860.249 [MB/s]   44.683
> 2.6.8.1(enable)   714.254 [MB/s]   32.359
> 2.6.8.1(+rwlock)  767.904 [MB/s]   27.968
> 2.6.8.1(+RCU)     830.678 [MB/s]   16.352

Can you show the figures for 1 and 2 clients?

> In IA-32 or x86_64, can anybady implement atomic_inc_return()?
> If it can not, I'll try to make alternative macros or inline functions.

If you can get this done, it will be very useful, as I could allso run 
some benchmarks on my test systems.


- James
-- 
James Morris
<jmorris@redhat.com>





