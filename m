Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWHCX0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWHCX0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWHCX0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:26:46 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:54276 "EHLO
	mms1.broadcom.com") by vger.kernel.org with ESMTP id S1751387AbWHCX0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:26:45 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: "Michael Chan" <mchan@broadcom.com>
To: "David Miller" <davem@davemloft.net>
cc: tytso@mit.edu, herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060803.144845.66061203.davem@davemloft.net>
References: <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au>
 <1154630207.3117.17.camel@rh4> <20060803201741.GA7894@thunk.org>
 <20060803.144845.66061203.davem@davemloft.net>
Date: Thu, 03 Aug 2006 16:28:19 -0700
Message-ID: <1154647699.3117.26.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006080308; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230312E34344432383542312E303032352D422D2F342B574C684A754433704B705975633943514C71513D3D;
 ENG=IBF; TS=20060803232635; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006080308_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68CC59A00HW63071446-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 14:48 -0700, David Miller wrote:
> From: Theodore Tso <tytso@mit.edu>
> Date: Thu, 3 Aug 2006 16:17:41 -0400
> 
> > eth0: Tigon3 [partno(BCM95704s) rev 2100 PHY(serdes)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:14:5e:86:44:24
> 
> The 5704 chip will set TG3_FLAG_TAGGED_STATUS, and therefore
> doesn't need the periodic poking done by tg3_timer().
> 

True.  But they also have ASF enabled which requires tg3_timer() to send
the heartbeat periodically.  If the heartbeat is late, ASF may reset the
chip believing that the system has crashed.

> eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[0] TSOcap[0]

We'll see if we can do away with the timer-based heartbeat.  That's
probably the best solution.

