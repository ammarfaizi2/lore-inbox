Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWARQw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWARQw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWARQw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:52:58 -0500
Received: from mx.pathscale.com ([64.160.42.68]:3266 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932464AbWARQw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:52:57 -0500
Subject: Re: Why is wmb() a no-op on x86_64?
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <200601181729.36423.ak@suse.de>
References: <1137601417.4757.38.camel@serpentine.pathscale.com>
	 <200601181729.36423.ak@suse.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 18 Jan 2006 08:52:49 -0800
Message-Id: <1137603169.4757.50.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 17:29 +0100, Andi Kleen wrote:

> Actually it is a compiler optimizer barrier, not a no-op.

Sorry, braino.

> Hmm, I suppose one could add a wc_wmb() or somesuch, but WC 
> is currently deeply architecture specific so I'm not sure
> how you can even use it portably.
> 
> Why do you need the barrier?

On x86_64, we fiddle with the MTRRs to enable write combining, which
makes a huge difference to performance.  It's not clear to me what we
should even do on other architectures, since the only generic entry
point that even exposes write combining is pci_mmap_page_range, which is
for PCI mmap through userspace, and half the arches I've looked at
ignore its write_combine parameter.

	<b

