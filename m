Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUCKHdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbUCKHde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:33:34 -0500
Received: from palrel12.hp.com ([156.153.255.237]:32986 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261455AbUCKHd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:33:28 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16464.5702.108960.33261@napali.hpl.hp.com>
Date: Wed, 10 Mar 2004 23:33:26 -0800
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, davidm@hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] fix PCI interrupt setting for ia64
In-Reply-To: <MDEEKOKJPMPMKGHIFAMAIEMADGAA.kaneshige.kenji@jp.fujitsu.com>
References: <20040311.103447.10929472.t-kochi@bq.jp.nec.com>
	<MDEEKOKJPMPMKGHIFAMAIEMADGAA.kaneshige.kenji@jp.fujitsu.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji,

Your patch failed to apply apparently because all tabs got replaced by
blanks.  I fixed it by hand for now, but in the future, I'd appreciate
it if you could either fix your mailer config so it doesn't muck with
whitespace (or don't paste & cut patches if that's how the patch got
mangled).  As a last resort, send patches as a MIME attachment.

>>>>> On Thu, 11 Mar 2004 14:29:59 +0900, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> said:

  Kenji> I think you are right. Probe_irq_on() still have another
  Kenji> problems even if my patch is applied. For example, if buggy
  Kenji> PCI device generates interrupts during its device driver
  Kenji> calls probe_irq_on(), these interrupts might be considered as
  Kenji> spurious and IRQ probing will fail. I think this is another
  Kenji> problem than I pointed out.

That should be OK.  The probe_irq_on() interface never was guaranteed
to work under all circumstances.

  Kenji> In addition to this, if probe_irq_on() is used for PCI
  Kenji> interrupts (level triggered), interrupts are generated
  Kenji> repeatedly because there are no handlers which clears these
  Kenji> interrupt request. But I think this is not a problem, because
  Kenji> these interrupts will be masked by probe_irq_on() or
  Kenji> probe_irq_off() soon. If this is a problem, I think
  Kenji> probe_irq_on() should never be used for PCI (level triggered)
  Kenji> interrupt probing.

That's a good point but I doubt it's going to cause trouble because of
the history behind this interface (it's mostly needed for ISA
devices).  If it did, it wouldn't be hard to fix, but I'm not sure
it's worth bothering.  Perhaps it would be a good idea to get rid of
the interface altogether in the 2.7 timeframe (for ia64 and other
ISA-free platforms at least; I don't think it can be gotten rid of for
x86).

	--david
