Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVAJL7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVAJL7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVAJL7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:59:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12928 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262218AbVAJL7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:59:33 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050107192158.GA30096@kroah.com> 
References: <20050107192158.GA30096@kroah.com>  <OF4C49B1DD.0FAC66D2-ON86256F81.0059D64B@raytheon.com> 
To: Greg KH <greg@kroah.com>
Cc: Mark_H_Johnson@Raytheon.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm1 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Mon, 10 Jan 2005 11:59:15 +0000
Message-ID: <27089.1105358355@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH <greg@kroah.com> wrote:

> > [1] Should the code generating the warning be active without CONFIG_PM
> > being set?

I believe the code is attempting to make sure the device is properly powered
on in the first place. CONFIG_PM only governs later power management.

> > [2] Can you explain why the message is generated (why not silently ignore
> > the older hardware) or is there something in an init script (I am using
> > Fedora Core 2) that [incorrectly] assumes power management is available to
> > cause the message to be printed?
> 
> David, any ideas?  Should I just revert this change for now?

Please don't. A system with this Promise 20269 card in it hangs without this
patch, I can see the splat happen with a PCI analyser.

The function being altered is almost certainly _wrong_ for non-PM-version-2
cards, but I don't have an old enough PCI spec to check.

A better solution would be to drop the level of the printk() to KERN_DEBUG or
to delete it entirely, assuming the patch otherwise works for Mark.

David
