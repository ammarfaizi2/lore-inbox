Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293171AbSBQQ1J>; Sun, 17 Feb 2002 11:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293175AbSBQQ1A>; Sun, 17 Feb 2002 11:27:00 -0500
Received: from relay1.pair.com ([209.68.1.20]:60431 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S293171AbSBQQ0s>;
	Sun, 17 Feb 2002 11:26:48 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C6FDB8C.9B033134@kegel.com>
Date: Sun, 17 Feb 2002 08:34:20 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: time goes backwards periodically on laptop if booted in low-power mode
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Toshiba laptop (running stock Red Hat 7.2, kernel 2.4.7-10) 
appears to suffer from a power management-related time hiccup: when
I boot in low-power mode, then switch to high-power mode,
time goes backwards by 10ms several times a second.
According to the thread
 Subject:  [PATCH]: allow notsc option for buggy cpus
 From:     Anton Blanchard <anton@linuxcare.com.au>
 Date:     2001-03-10 0:58:29
 http://marc.theaimsgroup.com/?l=linux-kernel&m=98418670406359&w=2
this can be fixed by disabling the TSC option, but there
ought to be a runtime fix.  Was a runtime fix ever put
together for this situation?

FWIW, the system is a Toshiba Satellite 2805, and /proc/cpuinfo reports

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 746.342
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1490.94

when booted in high power mode; when booted in low power mode,
/proc/cpuinfo changes as follows:

7c7
< cpu MHz               : 746.342
---
> cpu MHz               : 383.295
18c18
< bogomips      : 1490.94
---
> bogomips      : 750.38

- Dan

p.s. there were three other (unresolved?) threads about similar
time problems, but I don't think I'm suffering from these.

Subject:  gettimeofday question
From:     Russell King <rmk@arm.linux.org.uk>
Date:     2001-03-03 12:49:04
http://marc.theaimsgroup.com/?l=linux-kernel&m=98362388532220&w=2

Subject:  40ms/10ms error in do_gettimeofday()
From:     Bernard Imbert <imbert@ipanematech.com>
Date:     2000-04-04 10:15:57
http://marc.theaimsgroup.com/?l=linux-kernel&m=95484334731324&w=2

Subject:  problems with do_slow_gettimeoffset()
From:     Jason Sodergren <jason@mugwump.taiga.com>
Date:     2000-03-30 22:35:36
http://marc.theaimsgroup.com/?l=linux-kernel&m=95445682624501&w=2
