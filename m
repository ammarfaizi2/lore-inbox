Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWGVVEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWGVVEL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 17:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWGVVEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 17:04:11 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:7184 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750968AbWGVVEK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 17:04:10 -0400
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: Initial GPU layer addition. (03/07)
References: <11535827134076-git-send-email-airlied@linux.ie>
	<11535827133352-git-send-email-airlied@linux.ie>
	<11535827131612-git-send-email-airlied@linux.ie>
	<11535827132905-git-send-email-airlied@linux.ie>
From: Nix <nix@esperi.org.uk>
X-Emacs: freely redistributable; void where prohibited by law.
Date: Sat, 22 Jul 2006 22:04:06 +0100
In-Reply-To: <11535827132905-git-send-email-airlied@linux.ie> (Dave Airlie's message of "22 Jul 2006 16:40:13 +0100")
Message-ID: <87irlpgxmh.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice stuff! A couple of total nits and a check to see if I'm
understanding something.

On 22 Jul 2006, Dave Airlie noted:
> + * If the driver type matches thte device, call the bus match function.

Typo.

> +		printk(KERN_ERR "%s: to many buses\n", "gpu");

Another typo.

> +/**
> + * gpu_alloc_devices
> + *
> + * Allocate and initialise the GPU sub-devices.
> + */
> +int gpu_alloc_devices(struct gpu_bus *bus)
> +{
> +	struct gpu_device *dev;
> +	int i;
> +
> +	for (i=0; i<bus->num_subdev; i++) {
> +		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +		if (!dev)
> +			return -ENOMEM;
> +
> +		bus = gpu_bus_get(bus);
> +		if (!bus) {
> +			kfree(dev);
> +			return -ENOMEM;
> +		}

If we fall out of either of these paths, what does the bus look like?
Does it end up with half its sub-devices on? (I don't *think* we end up
leaking dev's allocated earlier....)

> +/**
> + * gpu_unregister_devices
> + */
> +int gpu_unregister_devices(struct gpu_bus *bus)
> +{
> +	int i;
> +
> +	for (i = 0; i < bus->num_subdev; i++) {
> +		struct gpu_device *gpu_dev = bus->devices[i];
> +
> +		device_del(&gpu_dev->dev);
> +
> +		kfree(gpu_dev);
> +		bus->devices[i] = NULL;
> +	}
> +	return 0;
> +}

... because I think this would still catch them. Am I right?

-- 
`We're sysadmins. We deal with the inconceivable so often I can clearly 
 see the need to define levels of inconceivability.' --- Rik Steenwinkel
