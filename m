Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269041AbTCAVhY>; Sat, 1 Mar 2003 16:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269042AbTCAVhX>; Sat, 1 Mar 2003 16:37:23 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53772 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S269041AbTCAVhV>;
	Sat, 1 Mar 2003 16:37:21 -0500
Date: Sat, 1 Mar 2003 13:38:53 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.63
Message-ID: <20030301213853.GA1975@kroah.com>
References: <20030228235947.GA29946@kroah.com> <Pine.LNX.4.44.0303011053310.16800-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303011053310.16800-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 10:55:50AM -0800, Linus Torvalds wrote:
> 
> On Fri, 28 Feb 2003, Greg KH wrote:
> > 
> > I've merged with your latest tree again, and it's available at the above
> > place.  Could you please pull these changes?
> 
> This causes
> 
> 	drivers/built-in.o(.text+0xedc7e): In function `cb_free':
> 	: undefined reference to `pci_remove_device'
> 	make: *** [.tmp_vmlinux1] Error 1
> 
> Ehh?

Oops, looks like Russell and I didn't test on a cardbus machine :)
I've made the following change to the repository, so you can just pull
it if you want to (from bk://kernel.bkbits.net/gregkh/linux/pci-2.5 ) or
you can just apply this patch.

It looks right to me, but I don't have a working cardbus machine at the
moment, so I can't test it, sorry.

Again, sorry about this.

greg k-h


# Cardbus: change cb_free to use pci_remove_device_safe()

diff -Nru a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
--- a/drivers/pcmcia/cardbus.c	Sat Mar  1 13:49:27 2003
+++ b/drivers/pcmcia/cardbus.c	Sat Mar  1 13:49:27 2003
@@ -313,7 +313,7 @@
 
 		s->cb_config = NULL;
 		for (i = 0 ; i < s->functions ; i++)
-			pci_remove_device(&c[i].dev);
+			pci_remove_device_safe(&c[i].dev);
 
 		kfree(c);
 		printk(KERN_INFO "cs: cb_free(bus %d)\n", s->cap.cb_dev->subordinate->number);
