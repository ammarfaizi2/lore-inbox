Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVDCH2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVDCH2g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 03:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVDCH2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 03:28:36 -0400
Received: from [67.177.11.57] ([67.177.11.57]:47488 "EHLO vger")
	by vger.kernel.org with ESMTP id S261588AbVDCH2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 03:28:09 -0400
Message-ID: <424F9424.6030902@utah-nac.org>
Date: Sat, 02 Apr 2005 23:58:44 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 Adaptec 4 Port Starfire Sickness
References: <424F73F8.8020108@utah-nac.org> <20050403054746.GA7858@alpha.home.local>
In-Reply-To: <20050403054746.GA7858@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It works fine with the Intel Dual Port Pro-1000 MT adapters without 
these problems. I am using testing scenarios
with Jumbo Frames as well. I am guessing the PCI bus contention is high 
due to the disk I/O bandwidth and
this is causing conditions the adapter does not normally see. 
Documentation states that this message should be very
rare, and not spool off into the logs at this rate.

See http://www.ibiblio.org/mdw/HOWTO/Ethernet-HOWTO-8.html

Jeff

Willy Tarreau wrote:

>Hi Jeff,
>
>I've also experienced those messages under 2.4, but they were harmless,
>and I never had a machine hang even after weeks of full load (the adapter
>was mounted on a stress test machine before being used in firewalls for
>months).
>
>So I wonder how you can be sure that it is this driver which finally locks
>the bus. Perhaps the system locks for any other reason (eg: race condition).
>Have you tried with any other 4-port NIC (tulip or sun for example) ? Sun
>QFE would be the most interesting to test as it also supports 64 bits /
>66 MHz.
>
>Regards,
>Willy
>
>On Sat, Apr 02, 2005 at 09:41:28PM -0700, jmerkey wrote:
>  
>
>>With linux 2.6.9 running at 192 MB/S network loading and protocol 
>>splitting drivers routing packets out of
>>a 2.6.9 device at full 100 mb/s (12.5 MB/S) simultaneously over 4 ports, 
>>the adaptec starfire driver goes into
>>constant Tx FIFO reconfiguration mode and after 3-4 days of constantly 
>>resetting the Tx FIFO window and
>>generating a deluge of messages such as:
>>
>>ethX:  PCI bus congestion, resetting Tx FIFO window to X bytes
>>
>>pouring into the system log file at a rate of a dozen per minute.  After 
>>several days, the PCI bus totally locks up
>>and hangs the system.  Need a config option to allow the starfire to 
>>disable this feature.  At very
>>high bus loading rates, the starfire card will completely lock the bus 
>>after 3-4 days
>>of constant Tx FIFO reconfiguration at very high data rates with 
>>protocol splitting and routing.
>>
>>Jeff
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>  
>

