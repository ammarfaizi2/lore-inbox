Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVAMREf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVAMREf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVAMRCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:02:41 -0500
Received: from canuck.infradead.org ([205.233.218.70]:50194 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261230AbVAMRBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:01:37 -0500
Subject: Re: thoughts on kernel security issues
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112205350.GM24518@redhat.com>
	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	 <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
	 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
	 <20050113082320.GB18685@infradead.org>
	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 18:01:02 +0100
Message-Id: <1105635662.6031.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 08:38 -0800, Linus Torvalds wrote:
> 
> NOTE! I'd personally hate some of the security things. For example, I
> think the "randomize code addresses" is absolutely horrible, just
> because
> of the startup overhead it implies (specifically no pre-linking). I
> also
> immensely dislike exec-shield because of the segment games it plays -
> I
> think it makes sense in the short run but not in the long run, so I
> much
> prefer that one as a "vendor feature", not as a "core feature". 

I think you are somewhat misguided on these: the randomisation done in
FC does NOT prohibit prelink for working, with the exception of special
PIE binaries. Does this destroy the randomisation? No: prelink *itself*
randomizes the addresses when creating it's prelink database (which is
in fedora once every two weeks with a daily incremental run inbetween;
the bi-weekly run is needed anyway to properly deal with new and updated
software, the daily runs are stopgapping only). This makes all *systems*
different, even though runs of the same app on the same machine right
after eachother are the same for the library addresses only.
That does not destroy the value of randomisation; it limits it slightly,
since this ONLY matters for libraries, not for the stack or heap and the
other things that get randomized. 

As for the segment limits (you call them execshield, but execshield is
actually a whole bunch of stuff that happens to include segment limits;
a bit like tree and forrest ;) yes they probably should remain a vendor
feature, no argument about that.


