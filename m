Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbQKJWBm>; Fri, 10 Nov 2000 17:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130868AbQKJWBe>; Fri, 10 Nov 2000 17:01:34 -0500
Received: from lsne-cable-1-p21.vtxnet.ch ([212.147.5.21]:43794 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S131468AbQKJWBX>;
	Fri, 10 Nov 2000 17:01:23 -0500
Date: Fri, 10 Nov 2000 23:00:56 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "David S. Miller" <davem@redhat.com>
Cc: ecki@lina.inka.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
Message-ID: <20001110230056.C8753@almesberger.net>
In-Reply-To: <E13syeh-00018h-00@calista.inka.de> <200011070334.TAA01403@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011070334.TAA01403@pizda.ninka.net>; from davem@redhat.com on Mon, Nov 06, 2000 at 07:34:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Any workaround which ignores TCP resets is broken from the start and
> is not to be implemented.

Hmm, what actual consequences (besides being non-conformant to RFC793)
would you expect ? I can see mainly two of them:

 - non-ECN but otherwise healthy sites get an extra SYN packet for each
   RST they send to an ECN-capable host using this recovery scheme
   (strikes me as relatively harmless; note that any retry mechanism at
   a higher protocol layer would have the same characteristics)
 - if such a host receives a RST due to an ECN-unfriendly firewall, and
   this RST was duplicated in the network, the duplicated RST will
   probably reach the sender before the non-RST response reaches it, so
   the connection fails unnecessarily.

The second scenario suggests that perhaps TCP should pick a new ISN in
this case. But I'm not sure the scenario would happen all that often in
real life ...

I'm much more worried about the "fall back immediately after single
failure" problem.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
