Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136579AbREIQUK>; Wed, 9 May 2001 12:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136582AbREIQUA>; Wed, 9 May 2001 12:20:00 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:57631 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136579AbREIQTx>; Wed, 9 May 2001 12:19:53 -0400
Message-ID: <3AF96E87.98357637@redhat.com>
Date: Wed, 09 May 2001 12:21:27 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benedict Bridgwater <bennyb@ntplx.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
In-Reply-To: <E14xWXu-0002fq-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > IRQ11 appearing on IRQ10 sounds exactly like the INTA-D line setting for IRQ
> > > 11 is wrong and we connected it to IRQ 10
> >
> > Which brings me back to my question in my previous email.  Why are we
> > remapping working configs again?  I'm at a loss here.  This isn't a hot plug
> > capably motherboard, we don't have to worry about new PCI cards getting thrown
> > in, and yet we are remapping the IRQs.  Why?
> 
> Ok and how do you propose to implement
> 
>         int gee_whiz_this_configuration_works(void)

The obvious one would be

int gee_whiz_this_configuration_works(struct pdev *pdev) {
	return(device_is_bootable_device(pdev));
}

> Now how about checking the BIOS tables and seeing if they are wrong. If so then
> someone can do something about it. Right now this is speculation and needs
> verifying.

Which is what I said also in my last email.  I'm more than happy to write this
off as a BIOS bug, and it is highly likely that the fact that Windows doesn't
see a problem is because of the exact test I mentioned above.  The BIOS has to
setup all possible boot devices, only devices non-essential to the boot
process (sound cards, modems, crap like that) get left unconfigured.  Not
touching already configured devices would seem to be a reasonable thing to do
in my opinion.  Not that I think configuring things is wrong, but it does make
you vulnerable to BIOS table bugs like this likely exposes, where as if you
didn't touch boot devices, then buggy BIOSes wouldn't bring your kernel to a
halt as easily.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
