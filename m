Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263300AbUKZXHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbUKZXHu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbUKZTsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:48:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262402AbUKZT3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:29:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16806.21992.295157.530799@cargo.ozlabs.ibm.com>
Date: Fri, 26 Nov 2004 09:00:08 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, brking@us.ibm.com,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
In-Reply-To: <1100954543.11822.8.camel@localhost.localdomain>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
	<1100917635.9398.12.camel@localhost.localdomain>
	<1100934567.3669.12.camel@gaston>
	<1100954543.11822.8.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> That doesn't mean it is the right implementation. Most devices don't
> need
> this check so might as well have a fast path. You can at least reduce
> the cost by setting a flag on devices that potentially have this problem

But that's exactly what Brian's later patch does!  Did you actually
read the patch?  All that we are doing is testing one bit in the
struct pci_dev to see whether to do the actual access or not.  Or do
you want one bit to tell us whether to go and look at another bit to
see whether to do the access? :)

> (or a PCI_ANY PCI_ANY quirk for platforms with it globally)

How would you use a quirk to block config space accesses?  The two are
unrelated.

> >  - The device he's working on, which sometimes need to trigger a BIST
> > (built-in self test). During this operation, the device stops responding
> > on the PCI bus, which can be sort-of fatal if anything (userland playing
> > with /sys/bus/pci/* for example) touches the config space.
> 
> That will be fun given some laptop SMM touches config space.

Well, I can see that that would limit your power management options,
but fortunately we don't have SMM on the machines where we need this
config access blocking.

> Some of the Intel CPU's are very bad at lock handling so it is an issue.

There is no extra locking introduced by Brian's patch.  Config
accesses were already taking the pci_lock and that hasn't changed.

> I dislike the "Hey it sucks, lets make it suck more" approach when it
> seems easy to do the job well.

Perhaps you could expand on what you mean by "do the job well"?

Paul.
