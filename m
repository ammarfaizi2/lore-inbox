Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161190AbWJOXoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbWJOXoO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 19:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWJOXoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 19:44:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21689 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932216AbWJOXoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 19:44:13 -0400
Date: Sun, 15 Oct 2006 16:44:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Brownell <david-b@pacbell.net>, matthew@wil.cx,
       val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-Id: <20061015164402.f9b8b4d2.akpm@osdl.org>
In-Reply-To: <1160956960.5732.99.camel@localhost.localdomain>
References: <1160161519800-git-send-email-matthew@wil.cx>
	<20061015191631.DE49D19FEC8@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20061015123432.4c6b7f15.akpm@osdl.org>
	<200610151545.59477.david-b@pacbell.net>
	<20061015161834.f96a0761.akpm@osdl.org>
	<1160956960.5732.99.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 01:02:40 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Sul, 2006-10-15 am 16:18 -0700, ysgrifennodd Andrew Morton:
> > No.  If pci_set_mwi() detects an unexpected error then the driver should
> > take some action: report it, recover from it, fail to load, etc.  If the
> > driver fails to do any of this then it's a buggy driver.
> 
> Wrong and there are several drivers in the kernel that are proof of
> this.

Let me restore the words from my earlier email which you removed so that
you could say that:

  For you the driver author to make assumptions about what's happening
  inside pci_set_mwi() is a layering violation.  Maybe the bridge got
  hot-unplugged.  Maybe the attempt to set MWI caused some synchronous PCI
  error.  For example, take a look at the various implementations of
  pci_ops.read() around the place - various of them can fail for various
  reasons.  


> > You, the driver author _do not know_ what pci_set_mwi() does at present, on
> > all platforms, nor do you know what it does in the future.  For you the
> 
> You don't care. It isn't an error for set_mwi to fail. In fact the only
> reason set_mwi even needs to bother with a return code is that some
> chips want you to set other config private to the device if it is
> available and active.
> 

Let me restore the words from my earlier email which you removed which
address that:

  Now it could be that an appropriate solution is to make pci_set_mwi()
  return only 0 or 1, and to generate a warning from within pci_set_mwi()
  if some unexpected error happens.  In which case it is legitimate for
  callers to not check for errors.


