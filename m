Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTJAIKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJAIKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:10:44 -0400
Received: from main.gmane.org ([80.91.224.249]:46498 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261683AbTJAIKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:10:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Florian Zwoch <zwoch@backendmedia.com>
Subject: Re: e1000 -> 82540EM on linux 2.6.0-test[45] very slow in one direction
Date: Wed, 01 Oct 2003 10:02:18 +0200
Message-ID: <ble1ma$ul9$1@sea.gmane.org>
References: <bkeli5$8l2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030909 Thunderbird/0.2
X-Accept-Language: en-us, en
In-Reply-To: <bkeli5$8l2$1@sea.gmane.org>
Cc: netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

issue seems to partly solved. the e1000 driver seems to be ok!
i reconfigured my kernel and intentionally left out netfilter options. 
after that my network performance was back to normal.

netfilter was only compiled in the kernel. it was not used with any rules!

so my wild guess would be that something with the netfilter code (i am 
not 100% sure it was netfilter.. _maybe_ it was some small odd kernel 
option i accidently enabled/disabled) is broken since test3 (again 
uncertified. but i firstly noticed this switching from test3 to test4).

Florian Zwoch wrote:
> hi,
> this has been discussed very roughly before. but unfortunately no real 
> solution has been brought up so far (or i have not read it yet).
> 
> problem in short: the 82540EM intel gigabit adapter became very slow as 
> of 2.6.0-test4. maybe earlier versions were als affected aswell, but i 
> noticed this behaviour on test4 and later. the 'slowness' of the adapter 
> only affects a certain data direction. i performed the following tests 
> to show you what is wrong.
> 
> dummy data file was 34257856 bytes (34.3MB).
> test machines were a pentium4 with the intel adapter, and a pentium2 266 
> with a lowcost realtek card (runs linux 2.4).
> 
> SCP:
>   e1000 -> 8139too    28.6KB/s
>   e1000 <- 8139too    4.6MB/s
> 
> SMB:
>   e1000 -> 8139too    3.0MB/s
>   e1000 <- 8139too    3.3MB/s
> 
> FTP
>   e1000 -> 8139too    54KB/s
>   e1000 <- 8139too    9.4MB/s
> 
> as you can see reveiving data is no problem at all (maybe another 
> protocol can create some problems in this case?). but sending data is 
> awesome slow! exception is the samba protocol. why is that? i thought 
> that samba may use udp instead of tcp. but iptraf did not show any udp 
> packets going around so i guess i was wrong.
> 
> the problem gets worse while trying to test things over the internet. 
> scp stalls incredibly often on my 256kbit/s upstream. so does ftp and 
> irc dcc protocol. irc dcc ends up with sending 0.3KB/s on a megabyte 
> sized file.
> 
> before people again trying to tell me that some duplex settings could be 
> messed up - then tell me why this should happen. when i boot into 2.4 
> kernel with that test machine the nic works without problems. so IF 
> duplex stuff is the reason for the hickups something must be wrong with 
> the duplex detection code in the new driver/kernel?
> 
> i tried vanilla 2.6.0-test5, 2.6.0-test5-mm2 and mm3 + 2.6.0-test5-bk4. 
> none of these gave any difference regarding network performance.



