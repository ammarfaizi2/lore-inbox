Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132613AbRDCUBy>; Tue, 3 Apr 2001 16:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132633AbRDCUBp>; Tue, 3 Apr 2001 16:01:45 -0400
Received: from pat.uio.no ([129.240.130.16]:26001 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S132613AbRDCUBi>;
	Tue, 3 Apr 2001 16:01:38 -0400
To: Caleb Epstein <cae@bklyn.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client code slow in 2.4.3
In-Reply-To: <20010403145615.C1049@hagrid.bklyn.org>
	<20010403150852.A1310@hagrid.bklyn.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 03 Apr 2001 22:00:47 +0200
In-Reply-To: Caleb Epstein's message of "Tue, 3 Apr 2001 15:08:52 -0400"
Message-ID: <shsn19xpxcg.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Caleb Epstein <cae@bklyn.org> writes:

     > On Tue, Apr 03, 2001 at 02:56:15PM -0400, Caleb Epstein wrote:
    >> I am having problems with timeouts and generaly throughput in
    >> the 2.4.3 NFS client side code which are not present in the
    >> 2.4.2 kernel running in the same configuraiton on the same
    >> hardware.  The machines are on a 100 Mbit switched local
    >> network with essentially no other trafic.

     > 	On second thought, it looks like 2.4.2 may also exhibit the
     > 	same behaviro after a little while.  Now that the machine has
     > 	been up for a half hour or so, NFS traffic has become slow on
     > 	my 2.4.2 client again.  I am seeing messages like this in my
     > 	kernel log:

     > Apr 3 15:01:54 hagrid kernel: nfs: server tela not responding,
     > still trying Apr 3 15:01:54 hagrid kernel: nfs: server tela OK

The above is a generic message that simply is stating that NFS traffic
is congested because the server isn't responding for whatever reason.

In 99% of all cases, this means that the server is not seeing all the
packets that the client is sending it. This forces the client to
throttle back the number of requests it can have on the fly, and then
to wait until the given packet times out, and then to resend.

Try checking whether or not the server is seeing all the packets that
the client is sending by comparing the output of tcpdump/ethereal
between the client and the server.
If the packet loss is large, try fiddling with the hardware: typically
stuff such as overriding the NIC autoconfiguration, swapping the NIC,
checking for noisy cables,...

If you're unable to trace the problem, try playing around with
rsize/wsize, timeo and retrans (man 5 nfs). The smaller the packet,
the less the chances are of UDP fragments getting lost.
You might also want to try out the NFS ping patch from
   http://www.fys.uio.no/~trondmy/src/2.4.2

Cheers,
   Trond
