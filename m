Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269046AbUJTJBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269046AbUJTJBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270054AbUJTI6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:58:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27603 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270262AbUJTIrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:47:23 -0400
Date: Wed, 20 Oct 2004 10:48:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: New consolidate irqs vs . probe_irq_*()
Message-ID: <20041020084838.GA25798@elte.hu>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com> <20041020083358.GB23396@elte.hu> <1098261745.6263.9.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098261745.6263.9.camel@gaston>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Do you have any objection if I send a patch making the whole
> probe_irq_* stuff optional on a CONFIG_ option ? (turning it into nops
> like we used to have on ppc until now, if the option isn't set).
> 
> I really don't want to mess with that racy mecanism that makes sense
> for ISA only afaik, and it seems some drivers are trying to use it now
> that it's there (/me looks toward yenta_socket) and I'm afraid of the
> consequences since I cannot see how that thing can work properly in
> the first place ;)

yeah. I've put it into a separate autoprobe.c file specifically for that
reason, you can exclude it in the Makefile and can provide your own
architecture version. Or should we make the no-autoprobing choice
generic perhaps?

	Ingo
