Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUEQWXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUEQWXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUEQWWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:22:54 -0400
Received: from mail.tmr.com ([216.238.38.203]:60164 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262910AbUEQWTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:19:46 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: ACPI problems with 2.6.6
Date: Mon, 17 May 2004 18:21:59 -0400
Organization: TMR Associates, Inc
Message-ID: <c8bdjm$lhn$1@gatekeeper.tmr.com>
References: <200405150401.44686.dj@david-web.co.uk> <1084612906.29632.5.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084832182 22071 192.168.12.100 (17 May 2004 22:16:22 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <1084612906.29632.5.camel@paragon.slim>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer wrote:
> On Sat, 2004-05-15 at 05:01, David Johnson wrote:
> 
>>Hi,
>>
>>I've got some serious strangeness being caused by ACPI on 2.6.6.
>>
>>2.6.3 works perfectly on the same machine. I don't use any acpi option on the 
>>kernel command line so it's just using the default options.
>>
>>The first problem is that a strange device appears as eth0:
>>
>>eth0      Link encap:UNSPEC  HWaddr 
>>00-90-F5-00-00-22-91-25-00-00-00-00-00-00-00-00
>>          BROADCAST MULTICAST  MTU:1500  Metric:1
>>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>          collisions:0 txqueuelen:1000
>>          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>>
>>It seems to be some incarnation of the real ethernet adaptor, but even when I 
>>manually configure it it is unable to actually talk to the network.
>>I can configure the real ethernet adaptor (8139too) as eth1 with no problems.
>>
>>Also, for some reason the loopback device is not added to the routing table 
>>which in turn causes a stack more problems.
>>Lots of other stuff also doesn't work including X.
>>
>>But if I boot 2.6.3 or set acpi=off for 2.6.6 everything works perfectly. The 
>>same problems exist in 2.6.5 but I haven't tried 2.6.4.
>>
>>I've attached my dmesg and .config - let me know what else is needed.
>>
>>Thanks,
>>David.
> 
> This is not a ACPI problem. Here's the culprit:
> 
> CONFIG_IEEE1394_ETH1394=m
> 
> The IEEE1394 ethernet module is loaded and is now eth0. Tell tail sings
> are the long MAC address and the Link encap. which is set to
> unspecified.

Could you clarify that a bit? Why is this correct behaviour on 2.6.6 and 
not 2.6.3? Actually, if there's no adaptor I wouldn't think the module 
would be loaded, and if there is I would hope it would be configured 
usefully.

I do understand why loading would cause problems, my question is why 
loading is correct on this system, and why ACPI is doing so now and not 
in 2.6.3.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
