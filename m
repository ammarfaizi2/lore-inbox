Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315750AbSENPFr>; Tue, 14 May 2002 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315755AbSENPFq>; Tue, 14 May 2002 11:05:46 -0400
Received: from [168.159.40.71] ([168.159.40.71]:36101 "EHLO
	srexchimc2.lss.emc.com") by vger.kernel.org with ESMTP
	id <S315750AbSENPFq>; Tue, 14 May 2002 11:05:46 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D1A51@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Jes Sorensen'" <jes@wildopensource.com>
Cc: "'Steve Whitehouse'" <Steve@ChyGwyn.com>, linux-kernel@vger.kernel.org
Subject: RE: Kernel deadlock using nbd over acenic driver.
Date: Tue, 14 May 2002 11:05:40 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But the acenic driver author suggested that sndbuf should be at least
262144, and the sndbuf can not exceed r/wmem_default. Is that correct?

So for gigabit Ethernet driver, what is the optimal mem configuration
for performance and reliability?

Thanks,

Xiangping

-----Original Message-----
From: Jes Sorensen [mailto:jes@wildopensource.com]
Sent: Tuesday, May 14, 2002 10:59 AM
To: chen, xiangping
Cc: 'Steve Whitehouse'; linux-kernel@vger.kernel.org
Subject: Re: Kernel deadlock using nbd over acenic driver.


>>>>> "xiangping" == chen, xiangping <chen_xiangping@emc.com> writes:

xiangping> Hi, When the system stucks, I could not get any response
xiangping> from the console or terminal.  But basically the only
xiangping> network connections on both machine are the nbd connection
xiangping> and a couple of telnet sessions. That is what shows on
xiangping> "netstat -t".

xiangping> /proc/sys/net/ipv4/tcp_[rw]mem are "4096 262144 4096000",
xiangping> /proc/sys/net/core/*mem_default are 4096000,
xiangping> /proc/sys/net/core/*mem_max are 8192000, I did not change
xiangping> /proc/sys/net/ipv4/tcp_mem.

Don't do this, setting the [rw]mem_default values to that is just
insane. Do it in the applications that needs it and nowhere else.

xiangping> The system was low in memory, I started up 20 to 40 thread
xiangping> to do block write simultaneously.

If you have a lot of outstanding connections and active threads, it's
not unlikely you run out of memory if each socket eats 4MB.

Jes
