Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbWBNGzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbWBNGzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWBNGzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:55:19 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:58936 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030502AbWBNGzS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:55:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qf0IOoif5gO8gFpWKG16ArdR48UZT/MZ9QpuWZgk/2jGm/GGz6iSg2lkY9lOpOcrLuaSWrgjHjj/GLCkF5m5suTEjeNUZC0vqgRTsRviNGTA/nwkp2H+qUPjKFmV3Ch/3LbO9VnUUvPKv7xM9OBPKnEQbZJq6ctjEFwXUmBXorc=
Message-ID: <21d7e9970602132255l5a7ff5feqa82ccad2c90ac4d8@mail.gmail.com>
Date: Tue, 14 Feb 2006 17:55:16 +1100
From: Dave Airlie <airlied@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, davej@redhat.com,
       dri-devel@lists.sourceforge.net
Subject: Re: IRQ disabled (i915?) when switchig between gnome themes (gnome-theme-manager)
In-Reply-To: <20060130203809.GA8098@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060130203809.GA8098@dominikbrodowski.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> Hi,
>
> Something strange goes on when I try to switch more than two times between
> gnome themes using gnome-theme-manager: the X server is killed -- that also
> happens with 2.6.15, and that is surely an userspace bug, and the login
> manager restarts. With current git and also with 2.6.16-rc1-mm3 and -mm4
> sometimes the screen, and _only_ the screen is "frozen", and all the time
> IRQ 10 is disabled:
>
>  10:      34430          XT-PIC  Intel 82801DB-ICH4, Intel 82801DB-ICH4
> Modem, yenta, yenta, ehci_hcd:usb1, uhci_hcd:usb2, i915@pci:0000:00:02.0
>
> What's a bit strange about this is that the IRQ handler for i915 seems to be
> gone right at the moment the "nobody cared" check triggers -- maybe the IRQ
> handler is unregistered (a bit) too early?
>
> CONFIG_AGP_INTEL=y
> CONFIG_DRM_I915=y
>
> 00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
> 00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
> 00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
> 00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
> 00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
>

Can you try the patch at
http://www.skynet.ie/~airlied/patches/dri/i915_irq_stop.diff

I think it might fix it, it cleans up any pending interrupts on disable..

Dave.
