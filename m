Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270256AbTGMQIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270255AbTGMQIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:08:16 -0400
Received: from webmail.hamiltonfunding.la ([12.162.17.40]:33127 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S270252AbTGMQH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:07:56 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: "Alan Shih" <alan@storlinksemi.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
	<20030713004818.4f1895be.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 13 Jul 2003 09:22:32 -0700
In-Reply-To: <20030713004818.4f1895be.davem@redhat.com>
Message-ID: <52u19qwg53.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Jul 2003 16:22:34.0890 (UTC) FILETIME=[F7BF4EA0:01C3495A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> TOE is evil, read this:

    David> http://www.usenix.org/events/hotos03/tech/full_papers/mogul/mogul.pdf

    David> TOE is exactly suboptimal for the very things performance
    David> matters, high connection rates.

    David> Your return is also absolutely questionable.  Servers
    David> "serve" data and we offload all of the send side TCP
    David> processing that can reasonably be done (segmentation,
    David> checksumming).

    David> I've never seen an impartial benchmark showing that TCP
    David> send side performance goes up as a result of using TOE
    David> vs. the usual segmentation + checksum offloading offered
    David> today.

    David> On receive side, clever RX buffer flipping tricks are the
    David> way to go and require no protocol changes and nothing gross
    David> like TOE or weird buffer ownership protocols like RDMA
    David> requires.

    David> I've made postings showing how such a scheme can work using
    David> a limited flow cache on the networking card.  I don't have
    David> a reference handy, but I suppose someone else does.

Your ideas are certainly very interesting, and I would be happy to see
hardware that supports flow identification.  But the Usenix paper
you're citing completely disagrees with you!  For example, Mogul writes:

 "Nevertheless, copy-avoidance designs have not been widely adopted,
  due to significant limitations. For example, when network maximum
  segment size (MSS) values are smaller than VM page sizes, which is
  often the case, page-remapping techniques are insufficient (and
  page-remapping often imposes overheads of its own.)"

In fact, his conclusion is:

 "However, as hardware trends change the feasibility and economics of
  network-based storage connections, RDMA will become a significant
  and appropriate justification for TOEs."

 - Roland
