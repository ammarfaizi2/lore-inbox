Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131215AbRCGV5i>; Wed, 7 Mar 2001 16:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131218AbRCGV5V>; Wed, 7 Mar 2001 16:57:21 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42894 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131216AbRCGV4j>;
	Wed, 7 Mar 2001 16:56:39 -0500
Message-ID: <3AA6AE66.700D806@mandrakesoft.com>
Date: Wed, 07 Mar 2001 16:55:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.3 and new aic7xxx
In-Reply-To: <3AA5CA13.8C19FC7E@neuronet.pitt.edu> <200103070546.f275keO22502@aslan.scsiguy.com> <200103070611.WAA01595@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I suspect it's easier to just make the PCI layer call the probe function
> in that order, instead of working around it in your driver.

That seems like a really good idea, especially in light of the fact that
some drivers are doing (have to do?) -reverse- order PCI scanning.

I would prefer to sort the list at probe not boot time.  That makes it
easy to reverse the order on the fly, depending on what the driver
requests at runtime.  It's SMP-friendly, because I can grab a private
copy of the PCI device list, sort it, and scan it.  You don't have to
re-sort at every pci_insert_device, for hotplug machines.  The only
potential downside is I need to check and see if the bootmem case needs
to be handled, when making a private copy of the pci devices list for
sorting.

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
