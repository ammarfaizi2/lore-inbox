Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316521AbSEOX6f>; Wed, 15 May 2002 19:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316523AbSEOX6f>; Wed, 15 May 2002 19:58:35 -0400
Received: from fmr01.intel.com ([192.55.52.18]:59328 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S316521AbSEOX6d>;
	Wed, 15 May 2002 19:58:33 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C0BFB7E85@orsmsx108.jf.intel.com>
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "'Russell Leighton'" <russ@elegant-software.com>, Tony.P.Lee@nokia.com
Cc: wookie@osdl.org, alan@lxorguk.ukuu.org.uk, lmb@suse.de,
        "Woodruff, Robert J" <woody@co.intel.com>,
        linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: RE: InfiniBand BOF @ LSM - topics of interest
Date: Wed, 15 May 2002 16:58:24 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>OR is it saner to layer TCP/IP etc. over IB... it seems to me the point
>others were making was that  there is more to "network"  style services
>than just passing bits from here to there...will IB have low level
>support many of the features people have come to expect?

Yes someone will layer IP over IB to support the gazillion applications
that currently run over that protocol without any code changes. This should
perform
as well as 10 gigabit Ethernet, but may cost less. 

However, since InfiniBand is already a reliable transport, one can bypass
TCP, 
so someone could invent a new address family for sockets,
say AF_INFINIBANDO, that is much more light weight than the existing TCP/IP
stack.
Thus with a small change to the application, a good performance increase can
be attained.
This is probably how the InfiniBand standard sockets direct protocol will be
initially
implemented for Linux. Next, one could entertain a concept similar to
Winsock Direct,
where no change is needed to the application, and the kernel has a swtich in
the
AF_INET code path that bypasses the TCP processing for packets destined for
the InfiniBand subnet.  This will likely have to come later for Linux 
after the performance value of bypassing TCP has 
actually been demonstrated. People are currently skeptical that 
a concept that has been demonstrated to have performance advantages
in Windows 2000 will achieve the same result if implemented in 
Linux. 

Finally, there are those that want to run on almost the bare metal. These
are 
typically the high performance computing types, or some of the large data
base
vendors that want to use InfiniBand for clustering.
For them, there is an InfiniBand Access Layer that allows 
direct access to the hardware (via a thin S/W layer)
from user space applications. One could
probably mmap() an ethernet NIC registers into user space, but 
probably only one process. 
InfiniBand was designed to specifically allow mmap()ing the hardware 
into user space,  even for multiple processes. 

As for a high level answer to the security question,
InfiniBand has the concept of protection domains
and read and write keys with checking built into the hardware. 
This provides protection from people RDMAing to the wrong place. 

Kind of a high level simplistic view, see the InfiniBand 
specification for details. There is also an open source
project on sourceforege that is working on code. See 
the home page for details.

http://sourceforge.net/projects/infiniband





