Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312136AbSCaRyY>; Sun, 31 Mar 2002 12:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312148AbSCaRyP>; Sun, 31 Mar 2002 12:54:15 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:29967 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312136AbSCaRx7>;
	Sun, 31 Mar 2002 12:53:59 -0500
Date: Sun, 31 Mar 2002 09:53:11 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5: hotplug config
Message-ID: <20020331175311.GB26801@kroah.com>
In-Reply-To: <3CA65AAE.4917313E@eyal.emu.id.au> <E16rfuv-0006gt-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 03 Mar 2002 15:11:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 03:02:45PM +0100, Alan Cox wrote:
> > -dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86_IO_APIC $CONFIG_X86
> > +if [ "$CONFIG_X86_IO_APIC" = "y" ]; then
> > +   dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86
> > +fi
> 
> What if I want hot plug and no apic??

No, the IBM driver will not work without apic.  Or at least that's what
the original authors of the driver told me :)

I thought the 'dep_tristate' rule would have caught this, but it looks
like this is the correct fix.

> See the fix in the 2.4.19-ac tree, that one ought to have been sufficient

I don't see a fix for this in your tree.  I only see the static->global
variable fix there.  Am I missing something?

thanks,

greg k-h
