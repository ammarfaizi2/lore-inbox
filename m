Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262612AbSI0WaE>; Fri, 27 Sep 2002 18:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262619AbSI0WaE>; Fri, 27 Sep 2002 18:30:04 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:34318 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262612AbSI0WaD>;
	Fri, 27 Sep 2002 18:30:03 -0400
Date: Fri, 27 Sep 2002 15:33:39 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Message-ID: <20020927223338.GX12909@kroah.com>
References: <20BF5713E14D5B48AA289F72BD372D6821CE34@AUSXMPC122.aus.amer.dell.com> <Pine.LNX.4.44.0209271606001.16331-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209271606001.16331-100000@humbolt.us.dell.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks nice, just a few minor comments:

> $ cat int13_dev80/host_bus
> PCI     02:01.0  channel: 0
> $ cat int13_dev80/interface
> SCSI            id: 0  lun: 0
> $ cat int13_dev80/info
> 80 30 01 00                                             .0..
> 1e 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00         ................
> 3a b9 8b 08 00 00 00 00 00 02 ff ff ff ff be dd         :...............
> 2c 00 00 00 50 43 49 00 53 43 53 49 00 00 00 00         ,...PCI.SCSI....
> 02 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00         ................
> 00 00 00 00 00 00 00 00 00 28                           .........(
> version: 3.0
> Extensions:
>         Fixed disk access
> Info Flags:
>         dma_boundry_error_transparent
>         write_verify
> num_default_cylinders: 0
> num_default_heads: 0
> sectors_per_track: 0
> number_of_sectors: 88bb93a
> PCI     02:01.0  channel: 0
> SCSI            id: 0  lun: 0
> 
> Warning: Spec violation.  Key should be 0xBEDD, is 0xDDBE
> 

Don't you already get the PCI and SCSI lines in the info file, from the
host_bus and interface files?

And that's a nice way to export binary data through a text file :)

Any way to split out the fields as individual files (version,
extensions, info_flags, num_default_cylinders, and so on)?

> @@ -981,3 +981,13 @@
>    absence of features.
>  
>    For more information take a look at Documentation/swsusp.txt.
> +
> +CONFIG_EDD
> +  Say Y or M here if you want to enable BIOS Enhanced Disk Device
> +  Services real mode BIOS calls to determine which disk
> +  BIOS tries boot from.  This feature creates a /proc/edd directory
> +  and files for each BIOS device detected.

You should fix up this wording as you aren't doing anything in the /proc
fs anymore :)

thanks,

greg k-h
