Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271820AbRHRMoT>; Sat, 18 Aug 2001 08:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271824AbRHRMoG>; Sat, 18 Aug 2001 08:44:06 -0400
Received: from [203.117.131.2] ([203.117.131.2]:54003 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S271822AbRHRMn5>; Sat, 18 Aug 2001 08:43:57 -0400
Message-ID: <3B7E6301.50833345@metaparadigm.com>
Date: Sat, 18 Aug 2001 20:43:45 +0800
From: Michael Clark <michael@metaparadigm.com>
Reply-To: michael@metaparadigm.com
Organization: Metaparadigm Pte Ltd
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Guyett <justin@soze.net>
CC: Jim Roland <jroland@roland.net>, linux-kernel@vger.kernel.org
Subject: Re: Aliases
In-Reply-To: <Pine.LNX.4.33.0108180245070.27721-100000@kobayashi.soze.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Guyett wrote:

> presuming this isn't an ifconfig limit instead of a kernel limit, trying
> "ifconfig eth0:x" works for x < 10000, anything > 10000 and x becomes
> x%10000.

must be a limit in your version of ifconfig.

# ifconfig --version
net-tools 1.60
ifconfig 1.42 (2001-04-13)

# ifconfig lo:10001 127.0.0.2
# ifconfig lo:20001 127.0.0.3
# ifconfig lo:10001
lo:10001  Link encap:Local Loopback  
          inet addr:127.0.0.2  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1

# ifconfig lo:20001  
lo:20001  Link encap:Local Loopback  
          inet addr:127.0.0.3  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1

> However, 2.4 also has multiple addresses of the same type per device;
> unfortunately it's fairly slow.  Adding or deleting addresses seems to
> take ~5 seconds per 255 addresses on my machine, and listing addresses
> takes about 1 second / 300 addresses on the same machine.

I can raise 1000 interfaces in 1.6 seconds with 2.4.8 on a 500MHz PIII using my
custom written ifconfig program designed for raising a batch of IPS in one go.
I've actually got up to about 64000 IPs on one interface but performance
degrades rapidly after about 8000 probably due to the kernel ip hash size - i
didn't try any higher than this. Anybody wanting more than a Class B of ip
aliases on one machine has gotta have some sort of problem so I don't think its
really an issue.

# time ./vifup -q -f ip.list internal
available interfaces for internal network: eth1
raised 1020 of 1020

real	0m1.671s
user	0m0.820s
sys	0m0.850s

> Also, listing addresses for another interface isn't any faster, which is
> unfortunate; ip shouldn't need to check addresses of all interfaces just
> to get the ones for the requested interface.

It does need to. The kernel ioctl SIOCGIFCONF only lets you fetch info for all
interfaces so you have to search through the whole lot to find the ones your
interested in. This is a standard BSD interface - or is there a new interface
used by ip??.

~mc
