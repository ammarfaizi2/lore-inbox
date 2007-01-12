Return-Path: <linux-kernel-owner+w=401wt.eu-S1751182AbXALOnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXALOnz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 09:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbXALOnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 09:43:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:4590 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbXALOny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 09:43:54 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lsWJVtvvSF7g6vsAeo1HSfGUIguflPZo40KFzhgKlKxa52WLA7Qr2gfhLOhTNR+gVBuJFf0lZEYncF/kOZtTJZT0Sp7GOBdxJb8uVqv909nIkre7KmzxvHefmRpzYZIWvkn8FlPm/rpLSjIZclW9nvET6IAOfvAsxI4kQ8o9n7E=
Message-ID: <58cb370e0701120643l5274bd5bn9d9f3661808a455c@mail.gmail.com>
Date: Fri, 12 Jan 2007 15:43:51 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 18/19] ide: add ide_use_fast_pio() helper
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20070112143037.7d5bf10f@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	 <20070112042800.28794.95095.sendpatchset@localhost.localdomain>
	 <20070112100836.58738dbc@localhost.localdomain>
	 <58cb370e0701120600pc65b237w4865c9637fc1b6e6@mail.gmail.com>
	 <20070112143037.7d5bf10f@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> >               if(strstr(id->model, "Integrated Technology Express")) {
> >                       /* In raid mode the ident block is slightly buggy
> >                          We need to set the bits so that the IDE layer knows
> >                          LBA28. LBA48 and DMA ar valid */
> >                       id->capability |= 3;            /* LBA28, DMA */
> >
> > and we are better off using generic helper if we can
> > (which may later allow us to use generic tuning code).
>
> IT8212 in smart mode has no tuning at all, the real modes are hidden by
> the controller. Some firmware versions don't seem to be like being fed
> set features commands either hence the total lack of tuning.

[ The discussed "ide: add ide_use_fast_pio() helper" patch doesn't fix it
  but it doesn't break anything either (it doesn't change the current
behavior). ]

It seems that it821x_tune_chipset() is buggy since it sends SET FEATURES
command even when in smart mode.  Shouldn't there be "don't tune" flag
in it812x_fixups() to tell it821x_tune_chipset() to not send SET FEATURES
commands?

Bart
