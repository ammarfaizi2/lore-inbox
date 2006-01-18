Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWARMoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWARMoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWARMoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:44:05 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:63204 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932482AbWARMoD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:44:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XAmQXhq1F3rofVagMP2+BFTBwVEp0XKZyTDQ20/8cpVvJycYYYYUFjiQjYSKgaaYnNQFGCfHJHxplOQ37JnYL045/3Yk5Ecl/JPeUR+kInFxfPSEKKfYBZcqqyQ5G88dBUT3ajCI4rjxT5ReUJLmWxwW9DwnV8JvTFwlDnNbIFA=
Message-ID: <58cb370e0601180444i1af5a6c7y51156877db1ae826@mail.gmail.com>
Date: Wed, 18 Jan 2006 13:44:01 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: (For review) Teach libata to tune master/slave seperately
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <1137585865.25819.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1137531678.14135.105.camel@localhost.localdomain>
	 <58cb370e0601180340v529c04fdq5dc962285a6fc1c0@mail.gmail.com>
	 <1137585865.25819.27.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2006-01-18 at 12:40 +0100, Bartlomiej Zolnierkiewicz wrote:
> > The core logic is changed (in the positive way): ata_pio_modes()
> > is finally used for obtaining PIO mask to be used.
>
> Ah yes, Jeff hadn't previously merged the small version of that change.
> Indeed description is a little incorrect.
>
> > Please update the patch description or make it a separate change.
> >
> > The other functional change is the ordering of programming host/devices:
> >
> > previously:
> > * program PIO for device 0 [host]
> > * program PIO for device 1 [host]
> > * program DMA for device 0 [host]
> > * program DMA for device 1 [host]
> > * program xfer mode for device 0 [device]
> > * program xfer mode for device 1 [device]
> >
> > now:
> > * program PIO for device 0 [host]
> > * program DMA for device 0 [host]
> > * program xfer mode for device 0 [device]
> > * program PIO for device 1 [host]
> > * program DMA for device 1 [host]
> > * program xfer mode for device 0 [device]
> >
> > This change is OK but I wonder what is the reason for it?
>
> It simply how suffling the code re-ordered it. I don't think its a
> problem but if anyone has a problem I can go and re-re-order it.

I think it is fine, no need for change.

> libata also really should do adev->pio_mode = XFER_PIO_0; ->set_piomode
> before doing its initial identify etc because there is no guarantee the
> BIOS didn't leave the hardware in a bogus state.

seconded

Bartlomiej
