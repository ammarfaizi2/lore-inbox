Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWEVLKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWEVLKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWEVLKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:10:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:2353 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750743AbWEVLKr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:10:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ItaH2O9Vm5m6M8L2+yEvi37zqiw32IodF8jhfpDayJHBn6j3wtJHtg990QNJDASHy9oc4TsCceWl94YT3fs+hsLDYM+vXHRfDoExOC6nxByFRDy64LLqKVEoTmmjz488o11f9XA5vpsGgmhnm4XeG/K7RyuIQpjJo+85EcDG4BQ=
Message-ID: <756b48450605220410w4623fda3p23ddc4b38e64516b@mail.gmail.com>
Date: Mon, 22 May 2006 07:10:46 -0400
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH/RFC 2.6.17-rc4 1/1] ACPI: Atlas ACPI driver v3
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060522093301.GB25624@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605220333.k4M3Xkg6020638@localhost.localdomain>
	 <20060522093301.GB25624@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/06, Pavel Machek <pavel@ucw.cz> wrote:
> ACK, but I guess you should cc Dmitry (input maintainer) and possibly
> Andrew Morton to get it in... Ok, few more nits.

Will do.

>
> > +#else
> > +#define atlas_free_input(...)
> > +#define atlas_setup_input(...) 0
> > +#define atlas_input_report(...)
> > +#endif
>
> Does the driver actually do anything useful in this case?

Depends on the application I guess. If CONFIG_INPUT is disabled, then
only applications that read /proc/acpi/event will see the ASIM events.

>
> > +     }
> > +
> > +     return status ;
>
> Extra " " before ;.

Sorry. Corrected.

>
> > +static struct acpi_driver atlas_acpi_driver = {
> > +     .name = ACPI_ATLAS_NAME,
> > +     .class = ACPI_ATLAS_CLASS,
> > +     .ids = ACPI_ATLAS_BUTTON_HID,
> > +     .ops = {
> > +             .add = atlas_acpi_button_add,
> > +             .remove = atlas_acpi_button_remove,
> > +             },
>
> Extra tab before }.

I hope I understood you correctly, the } on .ops after .remove should
align with the . ops right?. I tried to conform with button.c and
others. I will make the change I think you are suggesting anyway since
it seems more natural.

 74 static struct acpi_driver acpi_button_driver = {
 75         .name = ACPI_BUTTON_DRIVER_NAME,
 76         .class = ACPI_BUTTON_CLASS,
 77         .ids = "ACPI_FPB,ACPI_FSB,PNP0C0D,PNP0C0C,PNP0C0E",
 78         .ops = {
 79                 .add = acpi_button_add,
 80                 .remove = acpi_button_remove,
 81                 },
 82 };

 71 static struct acpi_driver acpi_video_bus = {
 72         .name = ACPI_VIDEO_DRIVER_NAME,
 73         .class = ACPI_VIDEO_CLASS,
 74         .ops = {
 75                 .add = acpi_video_bus_add,
 76                 .remove = acpi_video_bus_remove,
 77                 .match = acpi_video_bus_match,
 78                 },
 79 };

>
> > +MODULE_SUPPORTED_DEVICE("Atlas ACPI");
>
> Are you sure this si good idea?

You are right. It's a bad idea, none of the other drivers do it. I'll
take it out.

Thanks,
jayakumar
