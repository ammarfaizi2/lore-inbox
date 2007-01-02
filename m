Return-Path: <linux-kernel-owner+w=401wt.eu-S1755297AbXABPQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbXABPQY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 10:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbXABPQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 10:16:24 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34639 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755297AbXABPQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 10:16:23 -0500
Date: Tue, 2 Jan 2007 10:16:21 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: Greg KH <greg@kroah.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] OHCI: disallow autostop when wakeup is not available
In-Reply-To: <200701012007.52396.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.44L0.0701021013470.4122-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2007, Andrey Borzenkov wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Wednesday 15 November 2006 00:28, Alan Stern wrote:
> > This patch (as822) prevents the OHCI autostop mechanism from kicking in
> > if the root hub is not able or not allowed to issue wakeup requests.
> >
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> >
> > ---
> >
> > Greg:
> >
> > This patch should go into 2.6.19-rc ASAP.  It does solve a real problem.
> > The larger-scale changes Dave and I have been discussing will be submitted
> > separately, for inclusion in 2.6.20.
> >
> 
> Is the original problem (OHCI constantly attempting and failing to suspend 
> root hub) supposed to be fixed in 2.6.20?

No.  It can't be fixed in the kernel because it is a hardware bug.

>  Currently in rc3 I have
...
> ohci_hcd 0000:00:02.0: auto-stop root hub
> ohci_hcd 0000:00:02.0: auto-wakeup root hub
> ohci_hcd 0000:00:02.0: auto-stop root hub
> ohci_hcd 0000:00:02.0: auto-wakeup root hub
> ...
> 
> and it goes on and on until I stop it manually by usual method:
> 
> usb usb1: remote wakeup needed for autosuspend

The patch mentioned above allows the manual method to work.  Without the 
patch you would not be able to stop these messages at all, as you already 
have seen.

Alan Stern

