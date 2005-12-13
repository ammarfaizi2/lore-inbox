Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbVLMTEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbVLMTEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVLMTEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:04:20 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:41976 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932580AbVLMTET convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:04:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WKF6tnSZeboosrs3sGrID1Wb7HG2y3PCHale7K4R8va/s2SKeWTEyCes8EU2GTqQlXRNTdo7iDAXmxY50hi+mdmB6IZgEQ5jzR7bgQh5H6jtmIXWsgYZySJXWYOM2a/rsvIiLg4pWZVL0jqAxrN4mLMQY6cY/lmWp5gxiRIPHMo=
Message-ID: <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
Date: Tue, 13 Dec 2005 14:04:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>, Stelian Pop <stelian@popies.net>
Subject: Re: [RFT] Sonypi: convert to the new platform device interface
In-Reply-To: <20051213183248.GA3606@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512130219.41034.dtor_core@ameritech.net>
	 <20051213183248.GA3606@inferi.kami.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Mattia Dongili <malattia@linux.it> wrote:
> On Tue, Dec 13, 2005 at 02:19:40AM -0500, Dmitry Torokhov wrote:
> > Hi,
> >
> > Now that we allow manual binding and unbinding devices through sysfs it
> > is better if main device initialization is done in ->probe() instead of
> > module_init(). The following patch converts sonypi driver to this model.
> >
> > The patch compiles but I was unable to test it since I don't have the
> > hardware...
> [...]
> > +static int __devinit sonypi_setup_irq(struct sonypi_device *dev,
> > +                                   const struct sonypi_irq_list *irq_list)
> > +{
> > +     while (irq_list->irq) {
> > +
> > +             if (!request_irq(dev->irq, sonypi_irq,
>                                 ^^^^^^^^
> this should be irq_list->irq
>
> other than that seems to work here on a type2 model:
>
> sonypi: Sony Programmable I/O Controller Driver v1.26.
> sonypi: trying irq 11
> input: Sony Vaio Jogdial as /class/input/input8
> input: Sony Vaio Keys as /class/input/input9
> sonypi: detected type2 model, verbose = 1, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
> sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
> sonypi: device allocated minor is 63
> sonypi: unknown event port1=0x0f,port2=0x05
>

Thank you very much for testing and debugging the patch. I will fix
the irq thing and repost.

> Oh, there seems to be a spurious interrupt happening at modules
> insertion (I suspect sonypi_enable triggering and ignoring it), but this
> happens with the old module too and I never noticed it before. Wouldn't
> make more sense to print the warning even if verbose=0 to be able to
> catch it timely? I mean it's since 2.4 times I don't enable verbose mode
> in sonypi...
>

Probably, let's see what Stelian will say.

--
Dmitry
