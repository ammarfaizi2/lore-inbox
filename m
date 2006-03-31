Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWCaQhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWCaQhA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWCaQhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:37:00 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:16992 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751308AbWCaQg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:36:59 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] updated InfiniBand 2.6.17 merge plans
X-Message-Flag: Warning: May contain useful information
References: <ada7j6f8xwi.fsf@cisco.com> <ada1wwj1r7r.fsf@cisco.com>
	<adawtebzfxm.fsf@cisco.com> <20060331063239.GA31436@infradead.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 31 Mar 2006 08:36:57 -0800
In-Reply-To: <20060331063239.GA31436@infradead.org> (Christoph Hellwig's message of "Fri, 31 Mar 2006 07:32:39 +0100")
Message-ID: <adaodzmzi3a.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 Mar 2006 16:36:58.0851 (UTC) FILETIME=[547D4B30:01C654E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> * Get rid of option for building IPoIB and mthca debug
    Roland> output unless EMBEDDED=y

    Christoph> NACK.  Just add a FOO_DEBUG config option, this has
    Christoph> noþhing to do with EMBEDDED.

I think you misunderstood (probably because what I wrote was very
unclear).  What I meant to say was that I wanted to make
CONFIG_INFINIBAND_IPOIB_DEBUG=y, without the option to disable it,
unless CONFIG_EMBEDDED is set.  In Kconfig language, change it to:

	config INFINIBAND_IPOIB_DEBUG
		bool "IP-over-InfiniBand debugging" if EMBEDDED
		depends on INFINIBAND_IPOIB
		default y

Do you still have a problem with that?  The rationale is that we want
the debugging output compiled in (it still needs to be enabled at
runtime) unless the user really really knows they don't want it,
because by the time we know we want the output, it's too late to
recompile to kernel.

 - R.
