Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131392AbRCPVaF>; Fri, 16 Mar 2001 16:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131400AbRCPV3z>; Fri, 16 Mar 2001 16:29:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24463 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131392AbRCPV3n>;
	Fri, 16 Mar 2001 16:29:43 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15026.34193.887865.142525@pizda.ninka.net>
Date: Fri, 16 Mar 2001 13:28:49 -0800 (PST)
To: "Mathieu Giguere (LMC)" <lmcmgig@lmc.ericsson.se>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Claude LeFrancois (LMC)" <lmcclef@lmc.ericsson.se>
Subject: Re: UDP stop transmitting packets!!!
In-Reply-To: <7E67DE81C0B6D311B30500805FFEBAAE03078E3E@lmc35.lmc.ericsson.se>
In-Reply-To: <7E67DE81C0B6D311B30500805FFEBAAE03078E3E@lmc35.lmc.ericsson.se>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathieu Giguere (LMC) writes:
 > The problem with the previous code, when the queue become full (for any
 > reason) you don't try to de-queue packet form it.

That is right, UDP is an unreliable transport so it doesn't
matter which packets we drop in such a case.

In fact, the current choice is optimal.  If the problem is that we are
being hit with too many packets too quickly, the most desirable course
of action is the one which requires the least amount of computing
power.  Doing nothing to the receive queue is better than trying to
"dequeue" some of the packets there to allow the new one to be added.

Later,
David S. Miller
davem@redhat.com
