Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTIXDPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTIXDPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:15:15 -0400
Received: from palrel11.hp.com ([156.153.255.246]:54732 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261332AbTIXDPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:15:06 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16240.42563.834328.584444@napali.hpl.hp.com>
Date: Tue, 23 Sep 2003 13:00:03 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, kevin.vanmaren@unisys.com,
       peter@chubb.wattle.id.au, bcrl@kvack.org, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030923121044.483d3a5c.davem@redhat.com>
References: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
	<20030923105712.552dbb1e.davem@redhat.com>
	<16240.36993.148535.613568@napali.hpl.hp.com>
	<20030923114744.137d5dac.davem@redhat.com>
	<16240.40001.632466.644215@napali.hpl.hp.com>
	<20030923121044.483d3a5c.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 23 Sep 2003 12:10:44 -0700, "David S. Miller" <davem@redhat.com> said:

  >> Look, this may be difficult for you to understand, but different
  >> people find different policies useful.

  David> You, sure.  But you are not the only user of the ia64 port just
  David> as I am not the only user of the sparc64 port and if sparc64 generated
  David> diagnostic messages not useful to people other than me I'd have to
  David> quiet them by default.

But they _are_ useful.  Peter certainly noticed very quickly that
there was a problem with the ns83820 driver.  Do you think it would
have been better for the kernel to run silently at greatly degraded
performance?  I think not.

The optimistic assumption that the network stack is making about
headers being aligned works as long as unaligned headers are
relatively rare.  If unaligned headers are common, we'll have to do
something about that for ia64 (and Alpha, SPARC, PA-RISC, MIPS, etc.),
because performance will otherwise suck.

BTW: Peter, I'm not quite sure I understand why your machine got into
real problems because of the printks.  The messages are supposed to be
rated limited to at most 5 per 5 second interval.  Each message is
about 80 bytes in size, so we're talking about 80 bytes/s.  Do you
know what really went wrong here?  Did the rate limiting not work as
expected or is there something strange about your setup?

	--david
