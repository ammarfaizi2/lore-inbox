Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVKCWKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVKCWKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVKCWKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:10:38 -0500
Received: from www.eclis.ch ([144.85.15.72]:19082 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1751270AbVKCWKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:10:37 -0500
Message-ID: <436A8ADB.2090307@eclis.ch>
Date: Thu, 03 Nov 2005 23:10:35 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dean@arctic.org, zippel@linux-m68k.org
Subject: Re: NTP broken with 2.6.14
References: <4369464B.6040707@eclis.ch>	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>	 <43694DD1.3020908@eclis.ch>	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>	 <43695D94.10901@eclis.ch>	 <1130980031.27168.527.camel@cog.beaverton.ibm.com>	 <43697550.7030400@eclis.ch>	 <1131046348.27168.537.camel@cog.beaverton.ibm.com>	 <436A7D4B.8080109@eclis.ch> <1131054087.27168.595.camel@cog.beaverton.ibm.com>
In-Reply-To: <1131054087.27168.595.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz a écrit :
> On Thu, 2005-11-03 at 22:12 +0100, Jean-Christian de Rivaz wrote:
> 
>>A have tested 7 differents vanilla kernel on the same suspect hardware:
>>
>>                2.6.8  : ntpd working : drift from    -77ppm to   -144ppm
>>                2.6.9  : ntpd working : drift from    -99ppm to   -231ppm
>>                2.6.10 : ntpd failed  : drift from -37825ppm to -29912ppm
>>                2.6.12 : ntpd failed  : drift from -43429ppm to -45251ppm
> 
> 
> Ok, that makes it pretty clear we have a regression w/ 2.6.10. I really
> appreciate your helping narrow down this issue. If you have the time,
> could you test the three 2.6.10-rcX patches? 
> 
> You can find them here: 
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/
> 
> And they apply independently (not cumulatively) ontop of 2.6.9

I will try, but compiling the kernels take time even with 3 machines 
(one per kernel version)...


I compared the dmesg log of the different kernel, but since I don't know 
what I should find it's a little difficult. There is many differences 
between each kernels. Despit that, I noticed this difference between the 
kernel 2.6.9 (ntps working) and the kernel 2.6.10 (ntpd failed):

--- linux-2.6.9.txt  2005-11-03 22:49:29.000000000 +0100
+++ linux-2.6.10.txt  2005-11-03 22:48:41.000000000 +0100
[...snip...]
@@ -67,16 +68,12 @@
   Enabling unmasked SIMD FPU exception support... done.
   Checking 'hlt' instruction... OK.
   ENABLING IO-APIC IRQs
- vector=0x31 pin1=2 pin2=-1
- 8254 timer not connected to IO-APIC
- ...trying to set up timer (IRQ0) through the 8259A ...  failed.
- ...trying to set up timer as Virtual Wire IRQ... failed.
- ...trying to set up timer as ExtINT IRQ... works.
+ vector=0x31 pin1=0 pin2=-1
   Registered protocol family 16
   PCI BIOS revision 2.10 entry at 0xfbbb0, last bus=3
   Using configuration type 1
[..snip...]

Maybe a way to go ?

-- 
Jean-Christian de Rivaz
