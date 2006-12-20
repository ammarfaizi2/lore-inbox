Return-Path: <linux-kernel-owner+w=401wt.eu-S964940AbWLTIvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWLTIvn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 03:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWLTIvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 03:51:43 -0500
Received: from [202.112.49.247] ([202.112.49.247]:61425 "EHLO
	netarchlab.tsinghua.edu.cn" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964940AbWLTIvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 03:51:42 -0500
X-Greylist: delayed 1706 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 03:51:41 EST
Date: Wed, 20 Dec 2006 16:22:49 +0800
From: "xlz" <xlz@netarchlab.tsinghua.edu.cn>
To: "netfilter-devel" <netfilter-devel@lists.netfilter.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: A problem of netfilter HOOK point
Message-ID: <200612201622446099344@netarchlab.tsinghua.edu.cn>
X-mailer: Foxmail 6, 5, 104, 21 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I have a problem of the netfilter HOOK point. I load my handle function in HOOK point NF_IP6_LOCAL_OUT. But, its behavior is likely to be in the HOOK point NF_IP6_POST_ROUTING. The detail is shown as follows:

	I configrue a 6to4 tunnel between two linux hosts (2.6 kernel) by adding a interface "6to4tun". The route table in one of the host is:
		2002:c0a8:101::/48   dev 6to4tun
		default              via   3ffe:250:cccc::1  dev eth0
	The 6to4 tunnel works well before I load my own handle function in the hook point NF_IP6_LOCAL_OUT.

	In the hook point NF_IP6_LOCAL_OUT, my handle funtion changes the destination address of the packet from global ipv6 address (ex. 3ffe:250:cccd::2) to 6to4 address (ex. 2002:c0a8:101::1). In my expection, after changing the destination address in hook point NF_IP6_LOCAL_OUT, the host will look up the route table according the destination address, which is a 6to4 address. And then the host will send the packet from the interface "6to4tun". However, the experiment result is: the packets are sent from the interface eth0. It seems that the host looks up the route table according the global address. That means my own function seems to work in the hook point  NF_IP6_POST_ROUTING.
	What is the problem?
	
	Thank you in advance for any help!

Lizhong Xie
2006-12-20

