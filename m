Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbRCPWL4>; Fri, 16 Mar 2001 17:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131402AbRCPWLi>; Fri, 16 Mar 2001 17:11:38 -0500
Received: from boreas.isi.edu ([128.9.160.161]:37076 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S130216AbRCPWLV>;
	Fri, 16 Mar 2001 17:11:21 -0500
To: "David S. Miller" <davem@redhat.com>
cc: "Mathieu Giguere (LMC)" <lmcmgig@lmc.ericsson.se>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Claude LeFrancois (LMC)" <lmcclef@lmc.ericsson.se>
Subject: Re: UDP stop transmitting packets!!! 
In-Reply-To: Your message of "Fri, 16 Mar 2001 13:28:49 PST."
             <15026.34193.887865.142525@pizda.ninka.net> 
Date: Fri, 16 Mar 2001 14:10:37 -0800
Message-ID: <9186.984780637@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In fact, the current choice is optimal.  If the problem is that we are
>being hit with too many packets too quickly, the most desirable course
>of action is the one which requires the least amount of computing
>power.  Doing nothing to the receive queue is better than trying to
>"dequeue" some of the packets there to allow the new one to be added.

	A study by Greg Finn <finn@isi.edu> determined that randomly
dropping packets in a congested queue may be preferable to dropping
only newly received packets.  Dropping only newly-arrived packets can
be suboptimal, depending upon the details of how your packets are
generated, of course. YMMV.

"A Connectionless Congestion Control Algorithm"
Finn, Greg
ACM Computer Communication Review, Vol. 19, No. 5., pp. 12-31,Oct. 1989.

	The way I view this result is that each packet is part of a
flow (true even for most UDP packets).  Dropping a packet penalizes
the flow.  All packets in a queue contribute to the queue's
congestion, not simply the most recently-arrived packet.  Dropping a
random packet in the queue distributes the penalty among the flows in
the queue.  Over the statistical average, this is more optimal than
dropping the latest packet.

					Craig Milo Rogers
