Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWJORp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWJORp6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 13:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWJORp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 13:45:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3790 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161035AbWJORp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 13:45:56 -0400
Date: Sun, 15 Oct 2006 10:45:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [Bulk] Re: [PATCH 1/2] [PCI] Check that MWI bit really did get
 set
Message-Id: <20061015104544.5de31608.akpm@osdl.org>
In-Reply-To: <20061015135756.GD22289@parisc-linux.org>
References: <1160161519800-git-send-email-matthew@wil.cx>
	<20061013214135.8fbc9f04.akpm@osdl.org>
	<20061014140249.GL11633@parisc-linux.org>
	<20061014134855.b66d7e65.akpm@osdl.org>
	<20061015032000.GP11633@parisc-linux.org>
	<20061015070809.978C714552@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<1160922082.5732.51.camel@localhost.localdomain>
	<20061015135756.GD22289@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006 07:57:56 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Sun, Oct 15, 2006 at 03:21:22PM +0100, Alan Cox wrote:
> > Ar Sul, 2006-10-15 am 00:08 -0700, ysgrifennodd David Brownell:
> > > Since it's not an error, there should be no such printk ... which
> > > is exactly how it's coded above.
> > 
> > The underlying bug is that someone marked pci_set_mwi must-check, that's
> > wrong for most of the drivers that use it. If you remove the must check
> > annotation from it then the problem and a thousand other spurious
> > warnings go away.
> 
> There's only about 20 users of pci_set_mwi ... about 12 of them seem to
> check it, one of them uses a variable called
> compiler_warning_pointless_fix which leaves about 7 warnings to be
> removed by removing the __must_check.
> 
> However, I do believe the __must_check should be removed.  For example,
> the LSI 53c1030 has *nothing* to be done if setting MWI fails.  It just
> doesn't work, and the device copes.

If the drivers doesn't care and if it makes no difference to performance
then just delete the call to pci_set_mwi().

But if MWI _does_ make a difference to performance then we should tell
someone that it isn't working rather than silently misbehaving?
