Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSEOCYm>; Tue, 14 May 2002 22:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316297AbSEOCYl>; Tue, 14 May 2002 22:24:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46349 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316289AbSEOCYl>; Tue, 14 May 2002 22:24:41 -0400
Subject: Re: InfiniBand BOF @ LSM - topics of interest
To: Tony.P.Lee@nokia.com
Date: Wed, 15 May 2002 03:35:00 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, lmb@suse.de, woody@co.intel.com,
        linux-kernel@vger.kernel.org, zaitcev@redhat.com
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A206F@mvebe001.NOE.Nokia.com> from "Tony.P.Lee@nokia.com" at May 14, 2002 06:29:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177od2-0000wp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Good points,  I prefer to see IB as replacement for
> SCSI, FibreChannel, IDE, with its RDMA, messaging and

Fibrechannel can have congestion control failures. Its not something
you see badly because scsi timeouts are incredibly conservative (often
30 seconds for a read or write). They do deal with head of queue blocking
but thats a tiny bit of it

> I don't know if IB over multi-nodes/multi-hops in a WAN like
> setup works or not.  I like to see network experts like=20
> yourself try to break that since all the congestion control which
> is "supposely" done in HW as compare to doing that in software as=20
> in TCP/IP.  It would be nice to know how solid is the overall=20
> IB congestion control design in that environment and at=20
> what point does it break.  =20

According to folks at Quantum the IB stuff isnt doing 'true' congestion
control. At the moment its hard to tell since 1.0a doesn't deal with
congestion management and the 2.0 congestion stuff isnt due out until
later this year. Even then the Infiniband trade association folks use
words like "hopefully eliminating the congestion" in their presentation to 
describe their mechanism.

I've seen no mathematical proofs and no nice answers to the fact that FECN
has latencies and that the notification assumes the Ack packet with CA set
doesn't actually get dropped. People seem to model FECN as if the feedback
was instant whereas the feedback is one round trip on a loaded network if
the acks get back. For unreliable you end up introducing congestion 
notifications which I'm also not clear is perfect. I understand folks have
been doing the maths on this stuff though and it will be interesting to
see what they conclude

Finally for the centralised congestion manager the IBTA completely wash
their hands of policy - thats less of a problem as its mostly about telling the
boss to buy bigger toys.

TCP itself btw has issues over infiniband, stuff like convergence time,
clocking rates and window management reno style all begin to break down
at 10Gbit. On the other hand we have to solve those anyway along with other
upcoming horrors like extreme packet re-ordering.

(oh now I found it - the reference for the great internet congestion
 collapse is
	ACM computer communications review august 1988)
