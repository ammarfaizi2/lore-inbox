Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUIGROD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUIGROD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268116AbUIGRNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 13:13:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58555 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268154AbUIGRMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 13:12:02 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16701.60264.560942.236743@segfault.boston.redhat.com>
Date: Tue, 7 Sep 2004 13:10:00 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netpoll trapped question
In-Reply-To: <20040907165942.GY31237@waste.org>
References: <16692.45331.968648.262910@segfault.boston.redhat.com>
	<20040906213502.GU31237@waste.org>
	<16701.58093.63886.734877@segfault.boston.redhat.com>
	<20040907165014.GX31237@waste.org>
	<16701.59261.688607.284454@segfault.boston.redhat.com>
	<20040907165942.GY31237@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netpoll trapped question; Matt Mackall <mpm@selenic.com> adds:

mpm> On Tue, Sep 07, 2004 at 12:53:17PM -0400, Jeff Moyer wrote: A random
mpm> lock private to a given driver, for instance one taken on entry to the
mpm> IRQ handler. If said driver tries to do a printk inside that lock and
mpm> we recursively call the handler in netconsole, we're in trouble.
mpm> These are the issues that will have to be cleaned up in individual
mpm> drivers. So far, I haven't seen any reports, but I'm pretty sure such
mpm> cases exist. I suppose it's also possible for us to disable recursion
mpm> in netconsole instead of at the netpoll level.
>> Recursion in netconsole is protected by the console semaphore.

mpm> Yes, true. But we're still in trouble if we have nic irq handler ->
mpm> take private lock -> printk -> netconsole -> nic irq handler -> take
mpm> private lock. See?

Okay, so that one has to be addressed on a per-driver basis.  There's no
way for us to detect that situation.  And how do drivers address this?
Simply don't printk inside the lock?  I think that's reasonable.

-Jeff
