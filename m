Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129756AbRBVAu7>; Wed, 21 Feb 2001 19:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbRBVAut>; Wed, 21 Feb 2001 19:50:49 -0500
Received: from foobar.napster.com ([64.124.41.10]:21520 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S129923AbRBVAue>; Wed, 21 Feb 2001 19:50:34 -0500
Message-ID: <3A94623F.FB65BDF5@napster.com>
Date: Wed, 21 Feb 2001 16:50:07 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: ookhoi@dds.nl, Vibol Hou <vibol@khmer.cc>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, sim@stormix.com,
        netdev@oss.sgi.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev issues 
 (3c905B))
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc>
		<20010221104723.C1714@humilis>
		<14995.40701.818777.181432@pizda.ninka.net>
		<3A9453F4.993A9A74@napster.com> <14996.21701.542448.49413@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Jordan Mendelson writes:
>  > Now, if it didn't have the side effect of dropping packets left and
>  > right after ~4000 open connections (simultaneously), I could finally
>  > move our production system to 2.4.x.
> 
> The change I posted as-is, is unacceptable because it adds unnecessary
> cost to a fast path.  The final change I actually use will likely
> involve using the TCP sequence numbers to calculate an "always
> changing" ID number in the IPv4 headers to placate these broken
> windows machines.

Just for kicks I modified the fast path to use a globally incremented
count to see if it would fix both Win9x problem and my 4K connection
problem and it appears to be working just fine.

What probably happened was the sheer number of packets at 4K connections
without the fast path just slowed everything down to a crawl.


Thanks Dave,

Jordan
