Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTEOUoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTEOUoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:44:18 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:5512 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP id S264219AbTEOUoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:44:17 -0400
Message-ID: <3EC3FF1C.7090202@mvista.com>
Date: Thu, 15 May 2003 15:57:00 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem with e100 driver and latency on different packet sizes
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D6D0@orsmsx402.jf.intel.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010107D6D0@orsmsx402.jf.intel.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the response.

I looked at the code, and there doesn't seem to be a way to turn it off
dynamically or with a bootline option.  I have to have the driver
compiled into the kernel (because I'm netbooting with NFS) so I can't
really use a module parameter.

A dynamic field in /proc would be quite nice.

-Corey

Feldman, Scott wrote:

>>I've attached a small program to measure latency of 
>>round-trip time on UDP.  If I send 85-byte packets between 
>>two of my machines, I get 170us round-trip latency.  If I 
>>send 86-byte packets, I get 1329us latency. 
>>This seems quite odd.  If I test on the eepro100 driver, I 
>>get expected linear increase in round-trip time as the packet 
>>size increases, and it never gets close to 1300us.
>>    
>>
>
>This sounds like a side-effect of the "CPU Cycle Saver" feature to
>bundle Rx packets per one interrupt.  See
>Documentation/networking/e100.txt.  I haven't tried your setup, but I
>would guess that you can play around with the BundleSmallFr module
>parameter, or better yet, if you want the lowest latencies, turn off CPU
>Saver (ucode=0).
>
>CPU Saver trades latency for reduced interrupts, resulting in CPU
>savings, hence the name.
>
>Hope this helps.
>
>-scott
>
>
>  
>


