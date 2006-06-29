Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWF2VRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWF2VRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWF2VRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:17:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11432
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932533AbWF2VRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:17:20 -0400
Date: Thu, 29 Jun 2006 14:17:03 -0700 (PDT)
Message-Id: <20060629.141703.59468770.davem@davemloft.net>
To: mingo@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: SA_TRIGGER_* vs. SA_SAMPLE_RANDOM
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since SA_SAMPLE_RANDOM is defined as "SA_RESTART", it
could be just about any value.

On sparc, it's value is "2", so it aliases some of
the SA_TRIGGER_* defines the new genirq code adds.
And therefore we get a bunch of these on sparc64:

[   16.650540] setup_irq(2) SA_TRIGGERset. No set_type function available

(btw: missing space in the kernel log message between 'SA_TRIGGER'
      and 'set' :-)

I can't see any reason why SA_SAMPLE_RANDOM is set to
a signal mask value, or why IRQ flags are defined in
linux/signal.h :-)

Anyways, probably the best bet for now is to define
SA_SAMPLE_RANDOM explicitly to some value instead of
relying on the arbitrary platform definition of SA_RANDOM.

Ingo could you cook up and submit a patch which does this?
Thanks.
