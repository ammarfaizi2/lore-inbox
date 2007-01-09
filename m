Return-Path: <linux-kernel-owner+w=401wt.eu-S932237AbXAIQur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbXAIQur (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbXAIQur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:50:47 -0500
Received: from scalix.xandros.com ([142.46.212.37]:52952 "EHLO
	scalix.xandros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbXAIQuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:50:46 -0500
X-Greylist: delayed 778 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 11:50:45 EST
Date: Tue, 9 Jan 2007 11:37:25 -0500
From: Woody Suwalski <woodys@xandros.com>
To: David Brownell <david-b@pacbell.net>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
cc: rtc-linux@googlegroups.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <45A3C4C5.5080405@xandros.com>
In-Reply-To: <20070107090235.GA21613@flint.arm.linux.org.uk>
References: <200701051001.58472.david-b@pacbell.net>
References: <200701051933.26368.david-b@pacbell.net>
References: <459FD993.3070909@xandros.com>
References: <200701061317.25567.david-b@pacbell.net>
References: <20070107090235.GA21613@flint.arm.linux.org.uk>
Subject: Re: [patch 2.6.20-rc3 1/3] rtc-cmos driver
x-scalix-Hops: 1
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000607050904010902050707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------000607050904010902050707
Content-Type: text/plain;
	charset="ISO-8859-1";
	format="flowed"
Content-Disposition: inline

Russell King wrote:
> On Sat, Jan 06, 2007 at 01:17:25PM -0800, David Brownell wrote:
>   
>> On Saturday 06 January 2007 9:17 am, Woody Suwalski wrote:
>>     
>>>>> There are PPC, M68K, SPARC, and other boards that could also
>>>>> use this; ARMs tend to integrate some other RTC on-chip.  ...
>>>>>           
>>>> Let me put that differently.  That should be done as a separate
>>>> patch, adding (a) that platform_device, and maybe platform_data
>>>> if it's got additional alarm registers, and (b) Kconfig support
>>>> to let that work.  I'd call it a "patch #4 of 3".  ;)
>>>> ...
>>>>         
>>> I will try to play with the new code on Monday on ARM...
>>>       
>> Thanks.  Could you describe your ARM board?  None of mine have an
>> RTC using this register API.  Does it support system sleep states
>> (/sys/power/state) with a wakeup-capable (enable_irq_wake) RTC irq? 
>>     
>
> Woody will be using a Netwinder (he's part of the original development
> team.)  So no sleep states and therefore no wakeup.
>
> There's various other ARM-based systems using the PC RTC, but none of
> them have sleep or wakeup abilities afaik.
>
>   
I think that Russell is correct - the RTC is just part of a Winbond 
multifunction chip. It has no special wake-up or alarm hooks (as far as 
I remember).

As to the patch: applied to 2.6.20-rc4, both on PC and ARM, commented 
out "EXPERIMENTAL"...

To build your new patch for ARM I have modified the line "depends on 
RTC_CLASS && (X86_PC || ACPI || ARM)"...

On Netwinder ARM - can not build (see: rtc_build.log)

OK, changed the include/asm/rtc.h to look like i386 == include 
asm-generic/rtc.h
Still does not build - see rtc_build2.log

Could you please check what other defs are missing on ARM?

Thanks, Woody

BTW. Current RTC is broken same way on Shark ARM as it is on Netwinder ARM:

 >>>
<anderson@netsweng.com>
As for the RTC patch, it does work on the shark, and is needed.
<<<

So is there a reason to have RTC build blocked on all ARM?



--------------000607050904010902050707
Content-Type: text/x-log;
	name="rtc_build.log"
Content-Disposition: inline;
	filename="rtc_build.log"

  CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/compile.h
  CHK     include/linux/utsrelease.h
  CC [M]  drivers/rtc/rtc-cmos.o
In file included from drivers/rtc/rtc-cmos.c:39:
include/asm/rtc.h:21: warning: 'struct rtc_time' declared inside parameter list
include/asm/rtc.h:21: warning: its scope is only this definition or declaration, which is probably not what you want
include/asm/rtc.h:22: warning: 'struct rtc_time' declared inside parameter list
include/asm/rtc.h:23: warning: 'struct rtc_wkalrm' declared inside parameter list
include/asm/rtc.h:24: warning: 'struct rtc_wkalrm' declared inside parameter list
include/asm/rtc.h:28: warning: 'struct rtc_time' declared inside parameter list
include/asm/rtc.h:33: warning: 'struct rtc_time' declared inside parameter list
include/asm/rtc.h: In function 'rtc_periodic_alarm':
include/asm/rtc.h:35: error: dereferencing pointer to incomplete type
include/asm/rtc.h:36: error: dereferencing pointer to incomplete type
include/asm/rtc.h:37: error: dereferencing pointer to incomplete type
include/asm/rtc.h:38: error: dereferencing pointer to incomplete type
include/asm/rtc.h:39: error: dereferencing pointer to incomplete type
include/asm/rtc.h:40: error: dereferencing pointer to incomplete type
drivers/rtc/rtc-cmos.c: At top level:
drivers/rtc/rtc-cmos.c:63: warning: 'struct rtc_time' declared inside parameter list
drivers/rtc/rtc-cmos.c: In function 'cmos_read_time':
drivers/rtc/rtc-cmos.c:69: warning: implicit declaration of function 'get_rtc_time'
drivers/rtc/rtc-cmos.c: At top level:
drivers/rtc/rtc-cmos.c:73: warning: 'struct rtc_time' declared inside parameter list
drivers/rtc/rtc-cmos.c: In function 'cmos_set_time':
drivers/rtc/rtc-cmos.c:81: warning: implicit declaration of function 'set_rtc_time'
drivers/rtc/rtc-cmos.c: At top level:
drivers/rtc/rtc-cmos.c:84: warning: 'struct rtc_wkalrm' declared inside parameter list
drivers/rtc/rtc-cmos.c: In function 'cmos_read_alarm':
drivers/rtc/rtc-cmos.c:96: error: dereferencing pointer to incomplete type
drivers/rtc/rtc-cmos.c:97: error: dereferencing pointer to incomplete type
drivers/rtc/rtc-cmos.c:99: error: 'rtc_lock' undeclared (first use in this function)
drivers/rtc/rtc-cmos.c:99: error: (Each undeclared identifier is reported only once
drivers/rtc/rtc-cmos.c:99: error: for each function it appears in.)
drivers/rtc/rtc-cmos.c:100: error: dereferencing pointer to incomplete type
drivers/rtc/rtc-cmos.c:100: warning: implicit declaration of function 'CMOS_READ'
drivers/rtc/rtc-cmos.c:100: error: 'RTC_SECONDS_ALARM' undeclared (first use in this function)
drivers/rtc/rtc-cmos.c:101: error: dereferencing pointer to incomplete type
drivers/rtc/rtc-cmos.c:101: error: 'RTC_MINUTES_ALARM' undeclared (first use in this function)

--------------000607050904010902050707
Content-Type: text/x-log;
	name="rtc_build2.log"
Content-Disposition: inline;
	filename="rtc_build2.log"

  CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/compile.h
  CHK     include/linux/utsrelease.h
  CC      arch/arm/common/rtctime.o
arch/arm/common/rtctime.c:34: error: static declaration of 'rtc_lock' follows non-static declaration
include/linux/mc146818rtc.h:20: error: previous declaration of 'rtc_lock' was here
arch/arm/common/rtctime.c: In function 'rtc_arm_read_time':
arch/arm/common/rtctime.c:76: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c: In function 'rtc_arm_set_time':
arch/arm/common/rtctime.c:85: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c: In function 'rtc_arm_read_alarm':
arch/arm/common/rtctime.c:93: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c:95: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c: In function 'rtc_arm_set_alarm':
arch/arm/common/rtctime.c:103: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c:104: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c: In function 'rtc_ioctl':
arch/arm/common/rtctime.c:276: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c:277: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c: In function 'rtc_open':
arch/arm/common/rtctime.c:291: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c:296: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c:296: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c: In function 'rtc_release':
arch/arm/common/rtctime.c:314: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c:315: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c:321: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c: In function 'rtc_read_proc':
arch/arm/common/rtctime.c:401: error: dereferencing pointer to incomplete type
arch/arm/common/rtctime.c:402: error: dereferencing pointer to incomplete type
make[1]: *** [arch/arm/common/rtctime.o] Error 1
make: *** [arch/arm/common] Error 2

--------------000607050904010902050707--
