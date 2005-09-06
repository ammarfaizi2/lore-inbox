Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVIFTnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVIFTnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVIFTnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 15:43:06 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:45757 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750827AbVIFTnE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 15:43:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DO0vtw3yrTMMndNl+xSw70kurg0PtPVnQp+Az6joVQ52ynI9oa3gNGDmgdSWBnf21ptYdIXMx2da6yrB/UyT0zgE9yGFjKvwVf5Qy33W9Aq/SfLNXq6ju1s8jO76C3s3wbj/WLkRPRuEuzC2HEp7WH8MSNCHPhFoy4xOqG5cfqI=
Message-ID: <58d0dbf105090612421dcd9d8d@mail.gmail.com>
Date: Tue, 6 Sep 2005 21:42:53 +0200
From: Jan Kiszka <jan.kiszka@googlemail.com>
Reply-To: jan.kiszka@googlemail.com
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dfkjav$lmd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	 <1125854398.23858.51.camel@localhost.localdomain>
	 <p73aciqrev0.fsf@verdi.suse.de> <dfk5cp$19p$1@sea.gmane.org>
	 <58d0dbf10509061005358dce91@mail.gmail.com>
	 <dfkjav$lmd$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/9/6, Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>:
> Jan Kiszka wrote:
> 
> > The only way I see is to switch stacks back on ndiswrapper API entry.
> > But managing all those stacks correctly is challenging, as you will
> > likely not want to create a new stack on each switching point. Rather,
> 
> This is what I had in mind before I saw this thread here. I, in fact, did
> some work along those lines, but it is even more complicated than you
> mentioned here: Windows uses different calling conventions (STDCALL,
> FASTCALL, CDECL) so switching stacks by copying arguments/results gets
> complicated. So I gave up on that approach. For X86-64 drivers we use
> similar approach, but for that there is only one calling convention and we
> don't need to switch stacks, but reshuffle arguments on stack / in
> registers.
> 
> I am still hoping that Andi's approach is possible (I don't understand how
> we can make kernel see current info from private stack).
> 

The more I think about this the more it becomes clear that this path
will be too winding, especially when compared to the effort needed to
patch 8K (or more) back into the kernel as an intermediate workaround.

Moving the Windows code out of the kernel to userspace should be more
helpful on the long term. It would take a small stub, something like
tun/tap devices with wireless extensions, plus something to forward
PCI interrupts, and you could start hacking the wrapper in a save
harbour. If libusb is already prepared for such a task is not yet
clear to me (at least it is lacking USB 2.0 according to the docs).
But time will likely solve this as well.

Jan
