Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTE3JfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 05:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTE3JfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 05:35:05 -0400
Received: from catv-50622120.szolcatv.broadband.hu ([80.98.33.32]:22145 "EHLO
	catv-50622120.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S263503AbTE3Je6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 05:34:58 -0400
Message-ID: <3ED728DF.8030203@freemail.hu>
Date: Fri, 30 May 2003 11:48:15 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm2
References: <3ED70B9A.5050104@freemail.hu> <20030530012710.57cca756.akpm@digeo.com>
In-Reply-To: <20030530012710.57cca756.akpm@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------070802020207040405050704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070802020207040405050704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton wrote:

>Boszormenyi Zoltan <zboszor@freemail.hu> wrote:
>  
>
>>Hi,
>>
>>I am testing it now with your two extra patches.
>>I started vmware but I don't notice it now. Everything is snappy.
>>The system is a RH9 with upgrades. The latest errata kernel still
>>stops for seconds sometimes and vmware (and rsync between two drives
>>for that matter) makes a noticable performance impact. With .70-mm2,
>>I can still work on other things and not wait for other things to
>>finish first.
>>    
>>
>
>OK, thanks.
>
>  
>
>>However there are problems: Basically, the autoload fails.
>>My eth0/eth1 (both use 8139too) are down.
>>The iptables modules do not load so the iptables service is failing.
>>When I modprobe the needed modules, the things start working.
>>    
>>
>
>Make sure that you've correctly enabled the "Kernel Module Loader" in the
>"Loadable Mudule Support" menu.
>

 From my .config, you can see it was enabled.

>And read the readme file in mudule-init-tools carefully.  You need to build
>the /etc/modprobe.conf file with all the aliases in it.  It takes a bit of
>fiddling, but demand-modloading does work.
>

OK, I read it's FAQ, and the answer for the first question helped.
Attached is a small patch against RH9 /etc/rc.d/rc.sysinit.
This solved most of my problems.

>>E.g. named can be started after I modprobe capabilities. I brought up
>>named for example because the kernel logs messages for this one:
>>
>>process `rndc' is using obsolete setsockopt SO_BSDCOMPAT
>>process `named' is using obsolete setsockopt SO_BSDCOMPAT
>>    
>>
>
>That's OK.  It's just the kernel spamming the application developers ;)
>

OK. :-) However, "modprobe capability" is still not automatic.
What is the alias line for capability? I can't figure it out myself.
Perhaps it's not supported configuring capability
(aka CONFIG_SECURITY_CAPABILITIES) as a module?
It's definitely allowed...

>This is a bug in rpm.  It can be worked around with:
>
>	alias rpm='LD_ASSUME_KERNEL=2.2.5 rpm'
>  
>

Thanks for the answers.

Best regards,
Zoltán



--------------070802020207040405050704
Content-Type: text/plain;
 name="rc.sysinit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rc.sysinit.patch"

--- rc.sysinit~	2003-05-30 10:45:01.000000000 +0200
+++ rc.sysinit	2003-05-30 10:45:01.000000000 +0200
@@ -357,7 +357,7 @@
     IN_INITLOG=
 fi
 
-if ! LC_ALL=C grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then
+if ! LC_ALL=C grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/modules ]; then
     USEMODULES=y
 fi
 

--------------070802020207040405050704--

