Return-Path: <linux-kernel-owner+w=401wt.eu-S932854AbXASXKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854AbXASXKP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 18:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932868AbXASXKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 18:10:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:58632 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932854AbXASXKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 18:10:13 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AHzUwSJTr8TMCewr7sq56T31xSdBHI5nksDNkCLZ8yzQafNa7Z2KpA1U5mfokCpgoP1PbUTLB93H4i6GHR2TL7t3/ohL8C1xvjN110csprR22JHR9zU15GSiLMZEKtQHfUeiLvuipxMm6KPVnxNvkqd+1A6AyUI3VDt16vQ6VUg=
Message-ID: <305c16960701191510g2ed9ef4ev184d09c7b7d75408@mail.gmail.com>
Date: Fri, 19 Jan 2007 21:10:11 -0200
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Len Brown" <lenb@kernel.org>
Subject: Re: BUG: linux 2.6.19 unable to enable acpi
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Luming Yu" <luming.yu@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <305c16960701191003k3e69cf65o135cc2a9b1249943@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <305c16960701162001j5ec23332hcd398cbe944916e1@mail.gmail.com>
	 <200701170408.54220.lenb@kernel.org>
	 <305c16960701171310v727963aevd4f29eba34316ed9@mail.gmail.com>
	 <200701190336.20236.lenb@kernel.org>
	 <305c16960701191003k3e69cf65o135cc2a9b1249943@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/07, Matheus Izvekov <mizvekov@gmail.com> wrote:
> On 1/19/07, Len Brown <lenb@kernel.org> wrote:
> > I guess I'm losing my mind, because when I read this code,
> > there are only two ways out of the while(retry) loop.
> > Either return with success, or retry is 0.
> > So how the heck is retry printed as 142?!
> >
> > did you notice any delay between the last two lines of printout above?
> >
> > please boot with "acpi_dbg_layer=2" "acpi_dbg_level=0xffffffff"
> > so that we can see each read and write of the hardware look like.
> > Success is measured here by looking for SCI_EN being set
> > to indicate that we successfully entered ACPI mode.
> >
> > I guess we should see about 142 reads looking for SCI_EN...
> >
> > It would be interesting if you could boot a windows disk on this box
> > to see if they are able to get into ACPI mode.  You'd be able to
> > tell by dumping the interrupt list, looking at the device tree,
> > or observing if the power button gives immediate poweroff
> > or does an OS shutdown.
> >
> > thanks,
> > -Len
>
> printk("ACPI: retry %d\n") -> printk("ACPI: retry %d\n", retry)
> ;)
> ill try this again soon.
>

Ok, here is what i got:

  hwacpi-0207 [C031D380] [04] hw_get_mode           : ----Entry
  hwregs-0273 [C031D380] [05] get_register          : ----Entry
  hwregs-0487 [C031D380] [06] hw_register_read      : ----Entry
  hwregs-0810 [C031D380] [06] hw_low_level_read     : Read:  00000000
width 16 from 0000000000000404 (SystemIO)
  hwregs-0575 [C031D380] [06] hw_register_read      : ----Exit- AE_OK
  hwregs-0300 [C031D380] [05] get_register          : Read value
00000000 register 3
  hwregs-0303 [C031D380] [05] get_register          : ----Exit- AE_OK
  hwacpi-0226 [C031D380] [04] hw_get_mode           : ----Exit- 0000000000000002
ACPI: retry 0
ACPI Error (hwacpi-0185): Hardware did not change modes [20060707]
  hwacpi-0186 [C031D380] [03] hw_set_mode           : ----Exit-
****Exception****: AE_NO_HARDWARE_RESPONSE
ACPI Error (evxfevnt-0084): Could not transition to ACPI mode [20060707]
ACPI Warning (utxface-0154): AcpiEnable failed [20060707]
ACPI: Unable to enable ACPI
