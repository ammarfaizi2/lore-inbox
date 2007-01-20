Return-Path: <linux-kernel-owner+w=401wt.eu-S965320AbXATRTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbXATRTu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 12:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbXATRTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 12:19:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:11396 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965310AbXATRTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 12:19:49 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MUtL9xz0w1k87XFJeRtU2CrjKex9fZ+M3biHjgUEiHIET9hoeFl48q1U4CBjoXLld8CNLgbobYdmt+W9RtaQ2qJrtdWDJiwBZGJvMB7D59ql+GcMsT6JUfumILjcqtMaU9VppepiBJJnINElZCmNZDBP3c/7/y0g3YUGD6a7yfw=
Message-ID: <61ec3ea90701200919kd6593bdl8dcd47824ed03f49@mail.gmail.com>
Date: Sat, 20 Jan 2007 18:19:47 +0100
From: "Franck Bui-Huu" <fbuihuu@gmail.com>
To: "Hugh Dickins" <hugh@veritas.com>
Subject: Re: unable to mmap /dev/kmem
Cc: "Nadia Derbey" <Nadia.Derbey@bull.net>, "Andi Kleen" <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0701191634070.6398@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45AFA490.5000508@bull.net>
	 <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
	 <61ec3ea90701190331y459ad373n21a610157df03282@mail.gmail.com>
	 <Pine.LNX.4.64.0701191634070.6398@blonde.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/07, Hugh Dickins <hugh@veritas.com> wrote:
>
> Apology surely accepted, it's a confusing area (inevitably: in a driver
> for mem, the distinction between addresses and offsets become blurred).
>
> But please note, the worst of it was, that your patch comment gave no
> hint that you were knowingly changing its behaviour on the "main"
> architectures: it reads as if you were simply fixing it up on a
> few less popular architectures where an anomaly had been missed.
>

Because I was thinking that the expected behaviour was the one
implemented before 2.6.12. So I really thought to fix a bug, again
sorry for not having checked the history...

That said, it's really confusing to pass a virtual address as an
offset because:

    (a) mmap() has always worked with offset not addresses;

    (b) the kernel will treat this virtual address as an offset
        until kmem driver convert it back to a virtual
        address. And it seems that during this convertion the
        lowest bits of the virtual address will be lost...

Maybe read/write behaviours should be changed to use the offset as an
offset and not as a virtual address.

> > > I guess it's reassuring to know that not many are actually
> > > using mmap of /dev/kmem, so you're the first to notice: thanks.
> >
> > yes it doesn't seems to be used. In my case, I was just playing with
> > it when I submitted the patch but have no real usages.
>
> Have I got it right, that actually the problem you thought you were
> fixing does not even exist?

yes, see above.

>  __pa was already doing the right thing on
> all architectures, wasn't it?  So we can simply ask Linus to revert your
> patch?

yes we can if the desired behaviour is the one introduced by 2.6.12.

> I don't think your PFN_DOWN or virt_to_phys were improvements:
> though mem.c happens to live in drivers/char/, imagine it under mm/.
>

I don't get your point here. Do you mean that virt_to_phys() is only
meant for drivers ? If so, I would have said that virt_to_phys() is
prefered once boot memory init is finished...

		Franck
