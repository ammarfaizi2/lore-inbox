Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWAXW6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWAXW6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWAXW6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:58:14 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:44623 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750809AbWAXW6O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:58:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=muRp1v6ixnfXhzOoV4SA7tnuVeSkU8X6E2/SIPJbnunM7nX0vO/xiUEFYJ/qXbvCVebEEolJILre+GGrYAg++i83uuGBSxScLmmqMW791nQBBcmXgqoP25kCXqswbvOtVUgTz7hKAITpIQa2xWYRsrW1vImSezsz2j1Y0xxv2sA=
Message-ID: <58cb370e0601241458y6cdf702ey9caa261702a7948a@mail.gmail.com>
Date: Tue, 24 Jan 2006 23:58:11 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: kobject_register failed for Promise_Old_IDE (-17)
Cc: Vasil Kolev <vasil@ludost.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, frankt@promise.com, linux-ide@vger.kernel.org
In-Reply-To: <20060124223527.GA26337@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138093728.5828.8.camel@lyra.home.ludost.net>
	 <20060124223527.GA26337@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/06, Greg KH <greg@kroah.com> wrote:
> On Tue, Jan 24, 2006 at 11:08:47AM +0200, Vasil Kolev wrote:
> > Hello,
> > I have a machine that's currently running 2.4.28 with the promise_old
> > driver, which runs ok. I tried upgrading it last night to 2.6.15, and
> > the following error occured, and no drives were detected/made available:
> >
> >  [17179598.940000] kobject_register failed for Promise_Old_IDE (-17)
> >  [17179598.940000]  [dump_stack+21/23] dump_stack+0x15/0x17
> >  [17179598.940000]  [kobject_register+52/64] kobject_register+0x34/0x40
> >  [17179598.940000]  [bus_add_driver+69/163] bus_add_driver+0x45/0xa3
> >  [17179598.940000]  [driver_register+57/60] driver_register+0x39/0x3c
> >  [17179598.940000]  [__pci_register_driver+125/132] __pci_register_driver+0x7d/0x84
> >  [17179598.940000]  [__ide_pci_register_driver+19/53] __ide_pci_register_driver+0x13/0x35
> >  [17179598.940000]  [pg0+945449588/1069855744] pdc202xx_ide_init+0x12/0x16 [pdc202xx_old]
> >  [17179598.940000]  [sys_init_module+193/430] sys_init_module+0xc1/0x1ae
> >  [17179598.940000]  [syscall_call+7/11] syscall_call+0x7/0xb
>
> This means that some other driver tried to register with the same exact
> name for the same bus.  As it looks like this is the ide bus, I suggest
> asking on the linux ide mailing list.

I don't see a way how this can happen.  There is only one driver with
.name = "Promise_Old_IDE" and code dealing with driver registration
looks more or less sane (+ hasn't been changed recently except
.owner fixes).

Vasil, are you using vanilla 2.6.15 without any distro etc patches?
[ just to be 100% sure ]

Could you send dmesg command output?

Bartlomiej
