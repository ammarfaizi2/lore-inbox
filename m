Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWFOBpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWFOBpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 21:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWFOBpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 21:45:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42965 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932381AbWFOBpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 21:45:22 -0400
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, brice@myri.com
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled because of e820
References: <44907A8E.1080308@myri.com> <44907B13.2030402@linux.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 15 Jun 2006 03:45:10 +0200
In-Reply-To: <44907B13.2030402@linux.intel.com>
Message-ID: <p73ac8fqjix.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

> Brice Goglin wrote:er.
> > What would you think of a patch implementing the following strategy:
> > 1) if MMCONFIG works, always use it (no change)

One problem in your proposal Bryan is that just trying to access
bogus hardware mappings might cause nasty effects like machine
checks or trigger chipset errata.

> > 2) if MMCONFIG is disabled and we are accessing the regular config
> > space, use direct conf (no change, should ensure that any machine will
> > still boot fine)

That's already the case.

> > 3) if MMCONFIG is disabled but we are accessing the _extended_ config
> > space, try mmconfig anyway since there's no other way to do it.

(3) sounds dangerous to me.

> an OS isn't allowed to mix old and new access methods realistically so I don't think
> this is a viable good solution...

Why is it not allowed? We already do it in some cases.

Anyways I would say that if the BIOS can't get MCFG right then 
it's likely not been validated on that board and shouldn't be used.

-Andi
