Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262955AbTCSJoq>; Wed, 19 Mar 2003 04:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262956AbTCSJop>; Wed, 19 Mar 2003 04:44:45 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:29091 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S262955AbTCSJoo>;
	Wed, 19 Mar 2003 04:44:44 -0500
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Date: Wed, 19 Mar 2003 10:55:31 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303191055.31832.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

which compiler optimization should I use for this test?

-O3 shows other values:
* the empty overhead is 4 cycles shorter
* but store overhead goes from 3 to 48 cycles!

Please see below.


Regards,

Phil


gcc -O3 linus_i_d_cache.c -o linus_i_d_cache
./linus_i_d_cache

empty overhead=73 cycles
load overhead=10 cycles
I$ load overhead=10 cycles
I$ load overhead=10 cycles
I$ store overhead=48 cycles

gcc -g -Wall linus_i_d_cache.c -o linus_i_d_cache
./linus_i_d_cache

empty overhead=77 cycles
load overhead=12 cycles
I$ load overhead=12 cycles
I$ load overhead=12 cycles
I$ store overhead=3 cycles


cat /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 3
cpu MHz         : 265.916
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips        : 530.84



