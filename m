Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275307AbTHMSDH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275323AbTHMSDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:03:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:57254 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275307AbTHMSCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:02:49 -0400
Date: Wed, 13 Aug 2003 11:02:45 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@redhat.com>, rddunlap@osdl.org, davej@redhat.com,
       willy@debian.org, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813180245.GC3317@kroah.com>
References: <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3A79CA.6010102@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 01:47:54PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> ># add PCI_DEVICE() macro to make pci_device_id tables easier to read.
> >
> >diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
> >--- a/drivers/net/tg3.c	Wed Aug 13 10:29:08 2003
> >+++ b/drivers/net/tg3.c	Wed Aug 13 10:29:08 2003
> 
> 
> This patch is ok with me.
> 
> And I agree with David that, in generic, C99 initializers is the way to 
> go.  However, the higher level point remains:
> 
> PCI IDs, and data like them, are fundamentally not C code.

But the kernel, using C code, uses those ids to match drivers to
devices.  So we have to create C structures out of those ids some how.

The idea was that since the kernel already keeps track of these ids, we
might as well export them to userspace, so that it too can see what the
kernel support.  That brought forth the modules.*map files and enabled
the hotplug scripts to automatically load a module based on a device id
(this is much nicer than other os schemes which force a text file to be
created for every driver listing these ids.  They are usually created by
hand, and can get out of sync.)

I agree that now that more and more tools are using this data, we should
put it into a form that everyone can easily get at, without having to
parse module attributes or even the modules.*map files.

Any suggestions that do not involve XML?  :)

thanks,

greg k-h
