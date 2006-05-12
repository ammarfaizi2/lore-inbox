Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWELNsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWELNsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWELNsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:48:12 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23990 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751259AbWELNsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:48:10 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Tomasz Malesinski <tmal@mimuw.edu.pl>
Subject: Re: Segfault on the i386 enter instruction
Date: Fri, 12 May 2006 16:47:36 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060512131654.GB2994@duch.mimuw.edu.pl>
In-Reply-To: <20060512131654.GB2994@duch.mimuw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605121647.36916.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 16:16, Tomasz Malesinski wrote:
> The code attached below segfaults on the enter instruction. It works
> when a stack frame is created by the three commented out
> instructions and also when the first operand of the enter instruction
> is small (less than about 6500 on my system).
> 
> AFAIK, the only difference between creating a stack frame with the
> enter instruction or push/mov/sub is that enter checks if the new
> value of esp is inside the stack segment limit.
> 
> I tested it on a vanilla kernel 2.4.26 on Intel Celeron and also on
> probably non-vanilla 2.6.16.13 running on 3 dual core AMD Opteron,
> quite busy, server. It is working in 32-bit mode. Interestingly, on
> the second machine sometimes the program worked correctly.

Does not segfault for me:

# gcc Segfault.S

# ./a.out
asdf

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Celeron(TM) CPU                1200MHz
stepping        : 1
cpu MHz         : 1196.201
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 2395.77

# gcc -v 2>&1 | tail -1
gcc version 3.4.3

--
vda
--
vda
