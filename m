Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWDSABs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWDSABs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWDSABr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:01:47 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:54933 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750882AbWDSABr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:01:47 -0400
Date: Tue, 18 Apr 2006 16:01:30 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jon Masters <jonathan@jonmasters.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
In-Reply-To: <20060418234156.GA28346@apogee.jonmasters.org>
Message-ID: <Pine.LNX.4.62.0604181550380.22439@qynat.qvtvafvgr.pbz>
References: <20060418234156.GA28346@apogee.jonmasters.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon,
   would it be possible to have something less then an initrd that would 
allow the firmware blob to be packaged with the kernel? Your approach is 
just fine if the things that will need firmware are compiled as modules 
(the firmware can be placed on the same filesystem image as the modules 
that need it) but some people prefer to build monolithic kernel images, 
and in those cases there is no way for the kernel to get the firmware as 
there is no filesystem available yet.

I know that Rob Landley is doing some tricks with firmware linux to append 
an initramfs to the kernel image (http://www.landley.net/code/firmware/). 
There is already support in the kconfig for specifying the initramfs 
source, why culdn't we have the build process fetch any firmware needed by 
the non-modular portions and store them at the end of the kernel image so 
that they can be found during boot.

if nothing else make a skeleton initramfs that contains the modules and 
just enough other logic to continue the boot process as if the initramfs 
wasn't involved.

right now I have a laptop that's not working on wireless due to this exact 
problem (ipw2200 driver, and I haven't taken the time to setup modules for 
it yet)

David Lang


On Wed, 19 Apr 2006, Jon Masters wrote:

> Date: Wed, 19 Apr 2006 00:41:56 +0100
> From: Jon Masters <jonathan@jonmasters.org>
> To: akpm@osdl.org, linux-kernel@vger.kernel.org
> Subject: [PATCH] MODULE_FIRMWARE for binary firmware(s)
> 
> From: Jon Masters <jcm@redhat.com>
>
> Right now, various kernel modules are being migrated over to use
> request_firmware in order to pull in binary firmware blobs from userland
> when the module is loaded. This makes sense.
>
> However, there is right now little mechanism in place to automatically
> determine which binary firmware blobs must be included with a kernel in
> order to satisfy the prerequisites of these drivers. This affects
> vendors, but also regular users to a certain extent too.
>
> The attached patch introduces MODULE_FIRMWARE as a mechanism for
> advertising that a particular firmware file is to be loaded - it will
> then show up via modinfo and could be used e.g. when packaging a kernel.
>
> Signed-off-by: Jon Masters <jcm@redhat.com>
>
> diff -urN linux-2.6.16.2_orig/include/linux/module.h linux-2.6.16.2_dev/include/linux/module.h
> --- linux-2.6.16.2_orig/include/linux/module.h  2006-04-07 17:56:47.000000000 +0100
> +++ linux-2.6.16.2_dev/include/linux/module.h   2006-04-12 13:51:56.000000000 +0100
> @@ -155,6 +155,8 @@
> */
> #define MODULE_VERSION(_version) MODULE_INFO(version, _version)
>
> +#define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
> +
> /* Given an address, look for it in the exception tables */
> const struct exception_table_entry *search_exception_tables(unsigned long add);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

