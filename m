Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVIHAjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVIHAjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 20:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVIHAjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 20:39:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50939 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932462AbVIHAjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 20:39:02 -0400
Message-ID: <431F87D7.6060403@mvista.com>
Date: Wed, 07 Sep 2005 17:37:43 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Serge Noiraud <serge.noiraud@bull.net>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] KGDB for Real-Time Preemption systems
References: <20050811110051.GA20872@elte.hu> <43028A94.1050603@mvista.com> <200509051423.47380.Serge.Noiraud@bull.net>
In-Reply-To: <200509051423.47380.Serge.Noiraud@bull.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Noiraud wrote:
> mercredi 17 Août 2005 02:53, George Anzinger wrote/a écrit :
> 
>>I have put a version of KGDB for x86 RT kernels here:
>>http://source.mvista.com/~ganzinger/
>>
>>The common_kgdb_cfi_.... stuff creates debug records for entry.S and
>>friends so that you can "bt" through them.  Apply in this order:
>>Ingo's patch
>>kgdb-ga-rt.patch
>>common_kgdb_cfi_annotations.patch
>>
>>This is, more or less, the same kgdb that is in Andrew's mm tree changed
>>to fix the RT issues.
> 
> 
> Hi, everybody
> 
> I found two bugs in kgdb-ga-rt patch.
> 
> The first one : if CONFIG_SMP is not set, we have a compile error
> The second one : if CONFIG_KGDB is not set, we have a link error 
> I send you a diff patch to correct this. I am not sure the last patch is 
> correct, but it works.

The reported bugs are now rolled into the kgdb patch.  Also, there is a 
new README.txt.  I also included, in the kgdb patch, an updated gdb 
macro file (Documentation/i386/kgdb/gdbinit.hw) which has a per_cpu 
macro to:

	given a per_cpu structure name and the cpu number returns the
	address of that structure, properly typed.

I am also putting my current version of time_stamp_tool.  This is the 
replacement for kgdb_ts() which I have removed from the kgdb patch. 
Still a little rough but it has promise of being arch independent.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
