Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWIZO0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWIZO0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 10:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWIZO0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 10:26:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:43942 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751380AbWIZO0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 10:26:43 -0400
Date: Tue, 26 Sep 2006 07:26:40 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH 30/47] Driver core: create devices/virtual/ tree
Message-ID: <20060926142640.GB11999@kroah.com>
References: <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <d120d5000609260624j4fb1f45en6ce2339843fcc1ad@mail.gmail.com> <20060926134119.GA11435@kroah.com> <d120d5000609260651s7a47e038x707e910829fd5c76@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000609260651s7a47e038x707e910829fd5c76@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 09:51:04AM -0400, Dmitry Torokhov wrote:
> On 9/26/06, Greg KH <greg@kroah.com> wrote:
> >On Tue, Sep 26, 2006 at 09:24:15AM -0400, Dmitry Torokhov wrote:
> >> On 9/26/06, Greg KH <greg@kroah.com> wrote:
> >> >From: Greg Kroah-Hartman <gregkh@suse.de>
> >> >
> >> >This change creates a devices/virtual/CLASS_NAME tree for struct devices
> >> >that belong to a class, yet do not have a "real" struct device for a
> >> >parent.  It automatically creates the directories on the fly as needed.
> >> >
> >>
> >> Why do you need multiple virtual devices? All parentless class devices
> >> could grow from a single virtual device.
> >
> >They could, but it's a mess of a single directory if you do that.
> >Having /sys/devices/virtual/tty/ as a place for all tty virtual device
> >is nicer than /sys/devices/virtual/ as a single place for all of them
> >(mem, network, tty, misc, etc.)
> >
> 
> You supposed to use classes for classification, and devices to
> represent the tree so that would be /sys/class/tty/...

Yes, the symlink is still in /sys/class/tty, that hasn't gone away:
$ tree /sys/class/tty/
/sys/class/tty/
|-- console -> ../../devices/virtual/tty/console
|-- ptmx -> ../../devices/virtual/tty/ptmx
|-- tty -> ../../devices/virtual/tty/tty
|-- tty0 -> ../../devices/virtual/tty/tty0
|-- tty1 -> ../../devices/virtual/tty/tty1
|-- tty10 -> ../../devices/virtual/tty/tty10
...

It's just that /sys/devices/virtual would look very messy otherwise:
$ ls /sys/devices/virtual/
cpuid  input  mem  misc  msr  net  pci_bus  ppp  sound  tty  vc vtconsole

$ ls /sys/devices/virtual/*/ | wc -l
133

Also, that would mean that we could not have the name of a device
associated with a class to be the same as any other device associated
with any other class.  In the future that might be a problem, as our
namespace is only so big :)

thanks,

greg k-h
