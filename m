Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTISIGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 04:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTISIGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 04:06:40 -0400
Received: from mail.videonetworks.com ([193.128.170.146]:51463 "EHLO
	natst.videonetworks.com") by vger.kernel.org with ESMTP
	id S261409AbTISIGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 04:06:39 -0400
Message-ID: <3F6ABA4A.64DF0652@videonetworks.com>
Date: Fri, 19 Sep 2003 09:11:54 +0100
From: Dominic Robinson <d.robinson@videonetworks.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 multicast address problem, pcap workaround
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc to d.robinson@videonetworks.com

My source machine sends multicast packets on all the following
addresses: 230.1.1.1, 230.1.1.2 through to 230.1.1.64

My target machine (on local network, or with cross-over cable)
joins all these multicast groups, and receives packets on all
of these addresses EXCEPT 230.1.1.18 and 230.1.1.32.  

However, if I run tcpdump at the same time as my program, I
find my program suddenly starts receiving on 230.1.1.[18,32]
If I kill tcpdump, my program stops receiving.  It's the
"pcap_open_live()" function in tcpdump which causes this, 
and as a workaround I just call it direct in my receiver.

Could this be a bug in the multicast kernel code?

NOTES: 
(1) 230.1.1.1 to 230.1.64.1 and 230.1.1.1 to 230.64.1.1
    has the same problem.
(2) 230.1.1.1 to 230.1.1.63 works
(3) 230.1.1.1 to 230.1.1.128 fails with slightly different
    behaviour
(4) It makes no difference if I run a single program 
    listening on all addresses, or 64 individual programs
    each listening on a single address.

Thanks and regards,
Dominic
