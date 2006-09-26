Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWIZRPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWIZRPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWIZRPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:15:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:46423 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932157AbWIZRPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:15:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uz6rdgMzUjFAOHMSC2XzJjIopxTztpSIuyjBd8nWK0nXKef0Uf+S0dkeDTgUv7Omaw2R1vdhvcLNLTmSnOMFzcZxjl9J5ZDgjhvgOLSLjLeTm2Hf5QKmq7KOWtgHidHrcLx//BmlSRgHRM7dnPP8hnPIwzDyCLDZkIUDcyvhz7A=
Message-ID: <d120d5000609261015h5b80d311t4b3a4303f6eeed4d@mail.gmail.com>
Date: Tue, 26 Sep 2006 13:15:22 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH 30/47] Driver core: create devices/virtual/ tree
Cc: linux-kernel@vger.kernel.org, "Kay Sievers" <kay.sievers@vrfy.org>
In-Reply-To: <20060926142640.GB11999@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11592491611339-git-send-email-greg@kroah.com>
	 <11592491672052-git-send-email-greg@kroah.com>
	 <11592491704137-git-send-email-greg@kroah.com>
	 <11592491744040-git-send-email-greg@kroah.com>
	 <1159249177618-git-send-email-greg@kroah.com>
	 <11592491803904-git-send-email-greg@kroah.com>
	 <d120d5000609260624j4fb1f45en6ce2339843fcc1ad@mail.gmail.com>
	 <20060926134119.GA11435@kroah.com>
	 <d120d5000609260651s7a47e038x707e910829fd5c76@mail.gmail.com>
	 <20060926142640.GB11999@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, Greg KH <greg@kroah.com> wrote:
> On Tue, Sep 26, 2006 at 09:51:04AM -0400, Dmitry Torokhov wrote:
> > On 9/26/06, Greg KH <greg@kroah.com> wrote:
> > >On Tue, Sep 26, 2006 at 09:24:15AM -0400, Dmitry Torokhov wrote:
> > >> On 9/26/06, Greg KH <greg@kroah.com> wrote:
> > >> >From: Greg Kroah-Hartman <gregkh@suse.de>
> > >> >
> > >> >This change creates a devices/virtual/CLASS_NAME tree for struct devices
> > >> >that belong to a class, yet do not have a "real" struct device for a
> > >> >parent.  It automatically creates the directories on the fly as needed.
> > >> >
> > >>
> > >> Why do you need multiple virtual devices? All parentless class devices
> > >> could grow from a single virtual device.
> > >
> > >They could, but it's a mess of a single directory if you do that.
> > >Having /sys/devices/virtual/tty/ as a place for all tty virtual device
> > >is nicer than /sys/devices/virtual/ as a single place for all of them
> > >(mem, network, tty, misc, etc.)
> > >
> >
> > You supposed to use classes for classification, and devices to
> > represent the tree so that would be /sys/class/tty/...
>
> Yes, the symlink is still in /sys/class/tty, that hasn't gone away:
> $ tree /sys/class/tty/
> /sys/class/tty/
> |-- console -> ../../devices/virtual/tty/console
> |-- ptmx -> ../../devices/virtual/tty/ptmx
> |-- tty -> ../../devices/virtual/tty/tty
> |-- tty0 -> ../../devices/virtual/tty/tty0
> |-- tty1 -> ../../devices/virtual/tty/tty1
> |-- tty10 -> ../../devices/virtual/tty/tty10
> ...
>
> It's just that /sys/devices/virtual would look very messy otherwise:

It is supposed to be messy - it shows "physical" connections. If you
want to have nice separation look in /dev/class...

> $ ls /sys/devices/virtual/
> cpuid  input  mem  misc  msr  net  pci_bus  ppp  sound  tty  vc vtconsole
>
> $ ls /sys/devices/virtual/*/ | wc -l
> 133
>
> Also, that would mean that we could not have the name of a device
> associated with a class to be the same as any other device associated
> with any other class.  In the future that might be a problem, as our
> namespace is only so big :)
>

That is a better reason for separating it but I don;t think we have
clashes right now and as we converting more and more drivers to the
driver model your virtual directory should start shrinking, not
growing.

-- 
Dmitry
