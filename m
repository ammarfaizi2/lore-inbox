Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273818AbRJEVml>; Fri, 5 Oct 2001 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273819AbRJEVmb>; Fri, 5 Oct 2001 17:42:31 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:15329 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S273818AbRJEVmT>; Fri, 5 Oct 2001 17:42:19 -0400
Message-ID: <3BBE29DF.A5DECF12@oracle.com>
Date: Fri, 05 Oct 2001 23:45:03 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.11-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Merillat <harik@chaos.ao.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Wierd /proc/cpuinfo with 2.4.11-pre4
In-Reply-To: <200110051816.f95IGRW2008474@vulpine.ao.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Merillat wrote:
> 
> From dmesg:
> CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
> Intel Pentium with F0 0F bug - workaround enabled.
> Intel old style machine check architecture supported.
> Intel old style machine check reporting enabled on CPU#0.
> CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
> CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
> CPU:             Common caps: 000001bf 00000000 00000000 00000000
> CPU: Intel Pentium 75 - 200 stepping 0b
> Checking 'hlt' instruction... OK.
> 
> Looks normal.  Let's see /proc/cpuinfo...
> 
> processor       : 0

[snip]

> processor       : 7
> vendor_id       : unknown
> cpu family      : 0
> model           : 0
> model name      : unknown
> stepping        : 0
> cache size      : 515 KB
> fdiv_bug        : no
> hlt_bug         : yes
> f00f_bug        : yes
> coma_bug        : yes
> fpu             : no
> fpu_exception   : no
> cpuid level     : 0
> wp              : no
> flags           :
> bogomips        : 644464.70
> 
> Wow!  That's pretty impressive, a new kernel build gives me an
> additional _7_ CPUs!
> 
> Interesting bits of .config:
> 
> CONFIG_M586TSC=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_SMP is not set
> # CONFIG_X86_UP_APIC is not set
> # CONFIG_X86_UP_IOAPIC is not set
> 
> Won't compile with UP APIC turned on, as others have noted.
> 
> Aside from /bin/ps getting confused about the system capabilities, it
> seems stable.

Same 8-processor incorrect info on my PIII Dell laptop - 
 redirecting '/usr/bin/top' stderr gets this:

[asuardi@dolphin linux]$ cat x
fscanf failed on /proc/stat for cpu 1
fscanf failed on /proc/stat for cpu 2
fscanf failed on /proc/stat for cpu 3
fscanf failed on /proc/stat for cpu 4
fscanf failed on /proc/stat for cpu 5
fscanf failed on /proc/stat for cpu 6
fscanf failed on /proc/stat for cpu 7
fscanf failed on /proc/stat for cpu 1

So I'd assume anything touching /proc/cpuinfo is hosed.

--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
