Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313495AbSC3QXi>; Sat, 30 Mar 2002 11:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313493AbSC3QX2>; Sat, 30 Mar 2002 11:23:28 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:7181 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313495AbSC3QXN>;
	Sat, 30 Mar 2002 11:23:13 -0500
Date: Sat, 30 Mar 2002 08:22:43 -0800
From: Greg KH <greg@kroah.com>
To: Ashok Raj <ashokr2@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux PCI hotplug
Message-ID: <20020330162243.GA17719@kroah.com>
In-Reply-To: <20020325.234400.03241011.davem@redhat.com> <PPENJLMFIMGBGDDHEPBBAEGGCMAA.ashokr2@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 02 Mar 2002 14:11:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2002 at 06:09:56AM -0800, Ashok Raj wrote:
> Hello.
> 
> I have a question on pci hotplug capability.
> 
> when a new device is inserted, the hotplug driver enumerates pci, and if the
> driver is already loaded....
> 
> for each new device
> 	pci_insert->pci_announce->pci_probe
> 
> if i need to remove a device, the pci_remove would be called, but it does
> not call to check if the device is ready for removal. If there are other
> apps working on this device, how would the hotplug removal be authenticated
> before removal?

What function can the pci_hotplug core call to "check"?

> pci_remove() has no return value, means it cannot fail....

This is correct.  If the user asks for the device to be powered down, it
will be powered down, even if the driver attached to that device is busy
doing something.

For 2.5, this will probably change, as we will have the option to ask
the driver if it's ok to shutdown (better power management hooks.)

thanks,

greg k-h
