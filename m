Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVASReW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVASReW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVASRcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:32:54 -0500
Received: from palrel10.hp.com ([156.153.255.245]:10131 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261780AbVASRbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:31:08 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16878.39257.133688.118974@napali.hpl.hp.com>
Date: Wed, 19 Jan 2005 09:31:05 -0800
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@osdl.org>,
       "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: pipe performance regression on ia64
In-Reply-To: <41EE5601.7060700@yahoo.com.au>
References: <200501181741.j0IHfGf30058@unix-os.sc.intel.com>
	<Pine.LNX.4.58.0501180951050.8178@ppc970.osdl.org>
	<41ED9D06.1070301@yahoo.com.au>
	<16877.60406.192245.106565@napali.hpl.hp.com>
	<41EE5601.7060700@yahoo.com.au>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 19 Jan 2005 23:43:45 +1100, Nick Piggin <nickpiggin@yahoo.com.au> said:

  Nick> Oh that's quite true. A bad score on SMP on the pipe benchmark
  Nick> does not mean anything is broken.

  Nick> And IMO, probably many (most?) lmbench tests should be run
  Nick> with all processes bound to the same CPU on SMP systems to get
  Nick> the best repeatability and an indication of the basic serial
  Nick> speed of the operation (which AFAIK is what they aim to
  Nick> measure).

We need to keep an eye on both the intra- and the inter-cpu
pipe-bandwidth and should measure them explicitly.  The problem is
that at the moment, we get one, the other, or a mixture of the two,
subject to the vagaries of the scheduler.  If we could reliably
measure both intra and inter-cpu cases, we may well find new
optimization opportunities (I'm almost certain that's the case for the
cross-cpu case; which is probably the more important case, actually).

	--david
