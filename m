Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317664AbSHHRFt>; Thu, 8 Aug 2002 13:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317667AbSHHRFt>; Thu, 8 Aug 2002 13:05:49 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:22022 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317664AbSHHRFb>;
	Thu, 8 Aug 2002 13:05:31 -0400
Date: Thu, 8 Aug 2002 10:06:11 -0700
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation
Message-ID: <20020808170611.GA21821@kroah.com>
References: <Pine.LNX.4.33.0208061714560.16357-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208061714560.16357-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 11 Jul 2002 16:02:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 05:16:30PM -0400, Scott Murray wrote:
> I've been using this for several weeks now, and it allows me to hot
> insert new devices quite well.  However, my goal for my CompactPCI work
> is to get it into the mainline kernel so people can add drivers for
> other boards and chassis on top of it.  If this resource reservation
> scheme is too distasteful, or there is indeed a "cleaner" way, I'd
> really like comments or suggestions before I push on much further.

Hm, now that it looks like this is going to be necessary for cPCI
hotplug drivers, could you make up a 2.5 version of it?

The code should only be compiled in if CONFIG_HOTPLUG_PCI_CPCI is
enabled, and hopefully with the splitup of the PCI code in the 2.5 tree,
you should be able to contain it to one file, much like this patch has.

One small comment:

> @@ -2031,6 +2031,10 @@
>  	struct pci_dev *dev;
> 
>  	pcibios_init();
> +
> +#ifdef CONFIG_HOTPLUG_PCI
> +	pci_hp_reserve_resources();
> +#endif

Move this #ifdef to a header file file, so it doesn't show up in the .c
file.

thanks,

greg k-h
