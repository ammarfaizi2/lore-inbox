Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbTAOW5Z>; Wed, 15 Jan 2003 17:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTAOW5Z>; Wed, 15 Jan 2003 17:57:25 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:16908 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267354AbTAOW5Y>;
	Wed, 15 Jan 2003 17:57:24 -0500
Date: Wed, 15 Jan 2003 15:05:54 -0800
From: Greg KH <greg@kroah.com>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       stormy_peters@hp.com, john.cagle@hp.com, dan.zink@hp.com
Subject: Re: [PATCH-2.4.20] PCI-X hotplug support for Compaq driver
Message-ID: <20030115230554.GC25816@kroah.com>
References: <20030115095513.GA2761@tmathiasen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115095513.GA2761@tmathiasen>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 10:55:13AM +0100, Torben Mathiasen wrote:
> Hi Greg,
> 
> Attached is a patch against 2.4.20 (should apply to .21-pre3 and BK-current as
> well) that adds 66/100/133MHz PCI-X support to the Compaq Hotplug driver.
> 
> Please apply.

Looks almost ready.  Could you make up a 2.5 version first?  I don't
like to have new features in 2.4 before they go into 2.5.

>  /* inline functions */
> -
> +extern inline struct slot *find_slot (struct controller *ctrl, u8 device);

Can you just make this a normal function then, with a more private name?

> +/*
> + * get_controller_speed - find the current frequency/mode of controller.
> + *
> + * @ctrl: controller to get frequency/mode for.
> + *
> + * Returns controller speed.
> + *
> + */
>  static inline u8 get_controller_speed (struct controller *ctrl)

Thanks for documenting this and get_adapter_speed().

> +static char *get_speed_string (int speed)
> +{
> +	switch(speed) {
> +		case(PCI_SPEED_33MHz):
> +			return "33MHz PCI";
> +		case(PCI_SPEED_66MHz):
> +			return "66MHz PCI";
> +		case(PCI_SPEED_50MHz_PCIX):
> +			return "50MHz PCI-X";
> +		case(PCI_SPEED_66MHz_PCIX):
> +			return "66MHz PCI-X";
> +		case(PCI_SPEED_100MHz_PCIX):
> +			return "100MHz PCI-X";
> +		case(PCI_SPEED_133MHz_PCIX):
> +			return "133MHz PCI-X";
> +		default:
> +			return "UNKNOWN";
> +	}
> +}

Ick, why?  Just for a debugging message?  That /proc file is on the
short list of things to delete :)

> --- linux-2.4.20/drivers/hotplug/pci_hotplug.h	Thu Nov 28 17:53:13 2002
> +++ linux-2.4.20-pcix/drivers/hotplug/pci_hotplug.h	Mon Jan  6 22:54:47 2003
> @@ -33,9 +33,10 @@
>  enum pci_bus_speed {
>  	PCI_SPEED_33MHz			= 0x00,
>  	PCI_SPEED_66MHz			= 0x01,
> -	PCI_SPEED_66MHz_PCIX		= 0x02,
> -	PCI_SPEED_100MHz_PCIX		= 0x03,
> -	PCI_SPEED_133MHz_PCIX		= 0x04,
> +	PCI_SPEED_50MHz_PCIX		= 0x02,
> +	PCI_SPEED_66MHz_PCIX		= 0x03,
> +	PCI_SPEED_100MHz_PCIX		= 0x04,
> +	PCI_SPEED_133MHz_PCIX		= 0x05,
>  	PCI_SPEED_66MHz_PCIX_266	= 0x09,
>  	PCI_SPEED_100MHz_PCIX_266	= 0x0a,
>  	PCI_SPEED_133MHz_PCIX_266	= 0x0b,

Where are you getting the PCI_SPEED_50MHz_PCIX value from?  I took these
values from the Hotplug PCI draft spec.  Has 02 been reserved for 50MHz
PCIX and the other values changed?

If it's not in the spec, I'd recommend adding it to the end of the list,
with a big comment about why it's different from the spec values.

thanks,

greg k-h

