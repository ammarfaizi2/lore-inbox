Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSLMGuM>; Fri, 13 Dec 2002 01:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSLMGuM>; Fri, 13 Dec 2002 01:50:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:17089 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261527AbSLMGuK>; Fri, 13 Dec 2002 01:50:10 -0500
From: David Stevens <dlstevens@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
To: "David S. Miller" <davem@redhat.com>
Cc: matti.aarnio@zmailer.org, niv@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       stefano.andreani.ap@h3g.it, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF38D59D15.E0619D28-ON88256C8E.0023807F@us.ibm.com>
Date: Thu, 12 Dec 2002 23:55:35 -0700
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 6.0 [IBM]|November 8, 2002) at
 12/12/2002 23:55:38
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





      I believe the very large BSD number was based on the large
granularity of the timer (500ms for slowtimeout), designed for use on a VAX
780. The PC on my desk is 3500 times faster than a VAX 780, and you can
send a lot of data on Gigabit Ethernet instead of sitting on your hands for
an enormous min timeout on modern hardware. Switched gigabit isn't exactly
the same kind of environment as shared 10 Mbps (or 2 Mbps) when that stuff
went in, but the min timeouts are the same.
      I think the exponential back-off should handle most issues for
underestimated timers, and the min RTO should be the timer granularity.
Variability in that is already accounted for by the RTT estimator.
      I certainly agree it needs careful investigating, but it's been a pet
peeve of mine for years on BSD systems that it forced an arbitrary minimum
that had no accounting for hardware differences over the last 20 years.

                                    +-DLS


"David S. Miller" <davem@redhat.com>@vger.kernel.org on 12/12/2002 09:23:35
PM

Sent by:    linux-net-owner@vger.kernel.org


To:    matti.aarnio@zmailer.org
cc:    niv@us.ltcfwd.linux.ibm.com, alan@lxorguk.ukuu.org.uk,
       stefano.andreani.ap@h3g.it, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject:    Re: R: Kernel bug handling TCP_RTO_MAX?



   From: Matti Aarnio <matti.aarnio@zmailer.org>
   Date: Fri, 13 Dec 2002 05:39:28 +0200

   On Thu, Dec 12, 2002 at 06:26:45PM -0800, Nivedita Singhvi wrote:
   > Assuming you are on a local lan, your round trip
   > times are going to be much less than 200 ms, and
   > so using the TCP_RTO_MIN of 200ms ("The algorithm
   > ensures that the rto cant go below that").

     The RTO steps in only when there is a need to RETRANSMIT.
     For that reason, it makes no sense to place its start
     any shorter.

Actually, TCP_RTO_MIN cannot be made any smaller without
some serious thought.

The reason it is 200ms is due to the granularity of the BSD
TCP socket timers.

In short, the repercussions are not exactly well known, so it's
a research problem to fiddle here.
-
To unsubscribe from this list: send the line "unsubscribe linux-net" in
the body of a message to majordomo@vger.kernel.org
 More majordomo info at  http://vger.kernel.org/majordomo-info.html


