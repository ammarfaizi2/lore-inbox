Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275285AbTHMRsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275289AbTHMRsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:48:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59568 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275285AbTHMRsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:48:18 -0400
Message-ID: <3F3A79CA.6010102@pobox.com>
Date: Wed, 13 Aug 2003 13:47:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "David S. Miller" <davem@redhat.com>, rddunlap@osdl.org, davej@redhat.com,
       willy@debian.org, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com> <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com>
In-Reply-To: <20030813173150.GA3317@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> # add PCI_DEVICE() macro to make pci_device_id tables easier to read.
> 
> diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
> --- a/drivers/net/tg3.c	Wed Aug 13 10:29:08 2003
> +++ b/drivers/net/tg3.c	Wed Aug 13 10:29:08 2003


This patch is ok with me.

And I agree with David that, in generic, C99 initializers is the way to 
go.  However, the higher level point remains:

PCI IDs, and data like them, are fundamentally not C code.

I'm a strong believer in putting data in its most natural form, and then 
transforming it via automated tools into the desired form.  C code is a 
natural form of data that describes "process and procedure", and the 
compiler is the automated tool that transforms it.  PCI ID tables are 
data that is not process/procedure, but instead much more of a 
traditional data table.  So it should be a form more suitable for its 
multiple uses.  Distro installers and other utilities already pay 
attention to the PCI ID tables in drivers.  Why are we compiling 
non-code into ELF .o objects, and then forcing people to extract that 
non-code from .o files?  In the South we call it "going around your 
elbow to get to your thumb" :)

	Jeff



