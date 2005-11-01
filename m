Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVKAATZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVKAATZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVKAATY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:19:24 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:57746 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S964915AbVKAATX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:19:23 -0500
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=from:to:subject:date:user-agent:cc:references:in-reply-to:
	mime-version:content-disposition:content-type:
	content-transfer-encoding:message-id;
	b=gpZLegWUtlzkCo+f+OgbInsmmYZe67mXsiGb5YjEY/ZDMiSSIR13cBiGu0BbCDz4r
	Q1+74p0dzaiE04yQh5waw==
From: David Brownell <david-b@pacbell.net>
To: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: Linux 2.6.14 ehci-hcd hangs machine
Date: Mon, 31 Oct 2005 16:24:31 -0800
User-Agent: KMail/1.7.1
Cc: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
References: <0EF82802ABAA22479BC1CE8E2F60E8C376CE22@scl-exch2k3.phoenix.com> <20051031221541.GA31948@gollum.tnic>
In-Reply-To: <20051031221541.GA31948@gollum.tnic>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510311624.31680.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 2:15 pm, Borislav Petkov wrote:
> > >and dies. This bug is actually in there since 2.6.14-rc4 (see:
> > >http://bugzilla.kernel.org/show_bug.cgi?id=5428) and David Brownell
> > >supplied a patch which turned out to be useless eventually 
> > >since _rebooting_ 
> > >the kernel with the 'usb-handoff' (and without the patch) 
> > >solved the problem. 

In current GIT kernels (2.6.14+) that patch is now merged, and
also usb-handoff is the default.


> > >As it turns out, it actually solves the problem only for the 
> > >reboot case.
> > >My machine still hangs on an initial boot with and without 
> > >'usb-handoff'.

Huh?  That's not what you'd reported before.  What changed?
You're saying that _with_ that patch, and usb-handoff, it fails?


> >   While running with 'usb-handoff' turned on, do you see something like
> > "EHCI early BIOS handoff failed" (in power on or reboot cases) ? 
>
> Nope,	nothing of the like in the serial console log.

If the problem was IRQs getting somehow enabled after the handoff,
that patch would probably be a very useful thing.  If that does
help, I'll suggest that be merged into 2.6.14.x ... it'd have been
good to merge for 2.6.14.0 but quick merges seem mostly to be a
thing of the past any more.

- Dave

