Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVLGOpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVLGOpW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVLGOpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:45:21 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:9133 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751108AbVLGOpV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:45:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LSBfxzK4iiIeAHgPMyqsmMnsF88XnpgDkarcFIHxYhz6itBP+qiCdizNwwEpaTHyhA80xAn7fWi4JkthxeIhpzj5ms+ZE7Yww3VHMQAw9HenmvJ/oNdaz7Dkr6Jc585tTaKpw9qSpaogoI7D8wkDFgeg0jgjOVyY1YNyD+5QM9U=
Message-ID: <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
Date: Wed, 7 Dec 2005 15:45:19 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
In-Reply-To: <20051207143337.GA16938@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Dec 07, 2005 at 03:19:07PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On 12/7/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > On Wed, Dec 07, 2005 at 09:17:31AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > >
> > > > Isn't ide-io.c:ide_{start,complete}_power_step() enough?
> > >
> > > No.
> >
> > Why? :)
>
> Heh :) The failure is (IIRC, I don't have the serial logs to hand)
> before ide_start_power_step() is called. We get to start_request(), and
> the system then fails with "bus not ready on wakeup" and "drive not
> ready on wakeup". Calling the _GTM and _STM ACPI methods before then
> lets the system come back up normally.

OK, I understand it now - when using 'ide-generic' host driver for IDE
PCI device, resume fails (for obvious reason - IDE PCI device is not
re-configured) and this patch fixes it through using ACPI methods.

Thanks,
Bartlomiej
