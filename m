Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275315AbTHMS00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275316AbTHMS00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:26:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58801 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275315AbTHMS0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:26:24 -0400
Message-ID: <3F3A82C3.5060006@pobox.com>
Date: Wed, 13 Aug 2003 14:26:11 -0400
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
References: <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com> <20030813180245.GC3317@kroah.com>
In-Reply-To: <20030813180245.GC3317@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Aug 13, 2003 at 01:47:54PM -0400, Jeff Garzik wrote:
> 
>>Greg KH wrote:
>>
>>># add PCI_DEVICE() macro to make pci_device_id tables easier to read.
>>>
>>>diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
>>>--- a/drivers/net/tg3.c	Wed Aug 13 10:29:08 2003
>>>+++ b/drivers/net/tg3.c	Wed Aug 13 10:29:08 2003
>>
>>
>>This patch is ok with me.
>>
>>And I agree with David that, in generic, C99 initializers is the way to 
>>go.  However, the higher level point remains:
>>
>>PCI IDs, and data like them, are fundamentally not C code.
> 
> 
> But the kernel, using C code, uses those ids to match drivers to
> devices.  So we have to create C structures out of those ids some how.
> 
> The idea was that since the kernel already keeps track of these ids, we
> might as well export them to userspace, so that it too can see what the
> kernel support.  That brought forth the modules.*map files and enabled
> the hotplug scripts to automatically load a module based on a device id
> (this is much nicer than other os schemes which force a text file to be
> created for every driver listing these ids.  They are usually created by
> hand, and can get out of sync.)

Oh, no argument about how we got here.  The ids started out in C code 
for good reasons.  Linus always says "do what you need to do, and no 
more" and IMO he's right.  And we did exactly that :)


> I agree that now that more and more tools are using this data, we should
> put it into a form that everyone can easily get at, without having to
> parse module attributes or even the modules.*map files.
> 
> Any suggestions that do not involve XML?  :)

Again, my philosophy:  put the data in its most natural form.  In 
CS-speak, domain-specific languages.  So, just figure out what you want 
the data files to look like, and I'll volunteer to write the parser for it.

An overall goal for metadata is to collect it in one place.  I mentioned 
earlier about moving the simple "obj-$(foo) += foo.o" out of Makefiles 
and into Kconfig.  So putting PCI IDs in Kconfig files is one idea. 
Note that Kconfigs can be split up and #include'd, so it can be 
partitioned neatly in a single directory as the maintainer desires.

Another option is a few collections of files:  drivers/net/pci.ids, 
drivers/sound/pci.ids, and these would hold pci ids and driver assocations.

I'm sure the people CC'd here have even better suggestions.

One the PCI ID data format is chosen, automated tools generate the 
required C code so that the kernel source code (and behavior) is 
essentially unchanged.

	Jeff


