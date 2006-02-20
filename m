Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWBTKt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWBTKt4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWBTKt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:49:56 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:38258 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964873AbWBTKtz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:49:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lc9ocbSJqFMeM28nF7HYAg9kf3Oqve5D0Vd5tjU/KJhqOIw7lm4lpS2tM+U3LQ0Nfclqp1BJhqngtPAuy1c0d+Ub/HaQExCx+A4rPM7BqmvEi4X37G/AoP+cNtjPoiyN3t5ST4lFqUgzjgHx0PS15yOD4kkQ2AFgEeHJFdFseyg=
Message-ID: <756b48450602200249k1b79b108u42bfef68e1e9dba8@mail.gmail.com>
Date: Mon, 20 Feb 2006 18:49:54 +0800
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060220102639.GA4342@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602200213.k1K2DrDW013988@ns1.clipsalportal.com>
	 <20060220102639.GA4342@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, Feb 20, 2006 at 10:13:53AM +0800, jayakumar.acpi@gmail.com wrote:
>
> > +     /* setup proc entry to set and get lcd brightness */
> > +     proc = create_proc_read_entry("lcd", S_IFREG | S_IRUGO | S_IWUSR,
> > +                     atlas_proc_dir, atlas_read_proc_lcd, atlas_dev);
>
> For basic sanity, could this please be a standard backlight driver
> rather than sticking yet another backlight control under yet another
> directory in /proc? It makes userspace much, much easier.

I'm not sure how standard that is. For example, I looked at the asus
and toshiba drivers. These ACPI board drivers use
/proc/acpi/somedevice/lcd. For example,

asus_acpi.c
894                 asus_proc_add(PROC_LCD, &proc_write_lcd,
&proc_read_lcd, mode,
895                               device);

toshiba_acpi.c
472         {"lcd", read_lcd, write_lcd},

So, that's why I chose to do the same in my implementation. I'd have
much rather used a generic sysfs entry but that's not what any ACPI
drivers appear to do. Further, I see that Patrick Mochel is rewriting
the whole acpi driver model (and incorporating sysfs) anyway so I
figured I'd go with the flow of existing drivers. Perhaps someone
could clarify what the consensus is. I'd be happy to make any desired
adjustments.

> drivers/video/backlight/corgi_bl.c is an example, but also see my posts
> to acpi-devel with patches that add it to existing acpi drivers.

I'll go take a look at that. I didn't look for an acpi driver outside
of the drivers/acpi directory. But if that's the consensus, shouldn't
someone also mod the toshiba and asus drivers?

>
> > +             return atlas_acpi_button_add(device);
>
> What buttons does the hardware have? Would it make more sense for it to

Standard wallmount stuff. There's 8 buttons on the one I'm using for
testing. Vol up/down. Brightness up/down. Then several buttons for
miscellaneous usage by people who customize the chassis. Most apps for
this type of board are custom written and tend to just select on
/proc/acpi/event.

> be an input driver rather than (or as well as) just dropping stuff in
> acpi/events?

I would have loved to make it an input driver. But looking at the
mailing list archives, that seems to be a bone of contention and hence
I chose to go with the flow. I'll be happy to switch it over to an
input driver if there is consensus around that. Please do let me know.

Thanks,
jayakumar

>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
>
