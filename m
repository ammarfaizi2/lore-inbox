Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUH2NvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUH2NvV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUH2Nuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:50:44 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:38317 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S267835AbUH2NuK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:50:10 -0400
Message-ID: <4131DF0F.5040306@free.fr>
Date: Sun, 29 Aug 2004 15:50:07 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, Karol Kozimor <sziwan@hell.org.pl>,
       "Brown, Len" <len.brown@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1 and Asus L3C : problematic change found, can be reverted.
 Real fix still missing
References: <B44D37711ED29844BEA67908EAF36F039A1877@pdsmsx401.ccr.corp.intel.com> <41245F59.4080608@free.fr> <20040829130423.GD17032@dominikbrodowski.de>
In-Reply-To: <20040829130423.GD17032@dominikbrodowski.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> On Thu, Aug 19, 2004 at 10:05:45AM +0200, Eric Valette wrote:
> 
>>Li, Shaohua wrote:
>>
>>>Eric,
>>>The patch for bug 3049 has been in 2.6.8.1 and should fix the IO port
>>>problem. If the Asus quirk is just because of IO port problem, I'd like
>>>to remove it.
> 
> It's not because of the IO port problem -- actually, this "IO" problem is a
> new appearance, while the Asus quirk works perfectly for many people.
> 
> 
>>>Note PNP driver also reserves the IO port for the SMBus
>>>and lets SMBus driver to use it. ACPI motherboard driver behaves the
>>>same as PNP driver.
>>
>>Unfortunately, as I understand it, the fix is done to "unhide" the SMBus 
>>that otherwyse is not seen but it has unexpected side effect of messing 
>>ioports allocation/reservation. I guess lspci with and without the fix 
>>could help to understand the problem.
> 
> 
> Indeed. lspci without the fix doesn't show the device, lspci with the fix
> shows the device.
> 
> 	Dominik

Dominik,

This is a little bit late. There are already two fixes for the SMBus 
unhidding : one generic by linux, that is in 2.6.9-rc1-bk2 or 
2.6.9-rc1-mm1 that fixes the SMBus but that is not really SMBus related 
and one specific that you can find at 
<http://bugme.osdl.org/show_bug.cgi?id=3191>. Linux blessed this patch 
as it makes clear that unhiding the bus without reserving the IO space 
is the root of the real problem but did not incorporate it probably 
because the other fix is already in and mine should be done for buggy 
BIOS (DTST) that access the hidden SMBus not indirect the IO BAR but via 
  hardwired values,

Patch is not yet merged and may well never be as now problem is masked,


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



