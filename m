Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131443AbQKXET1>; Thu, 23 Nov 2000 23:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131544AbQKXETR>; Thu, 23 Nov 2000 23:19:17 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:42762 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S131443AbQKXETC>; Thu, 23 Nov 2000 23:19:02 -0500
Date: Thu, 23 Nov 2000 21:48:38 -0600
To: Brian Kress <kressb@fsc-usa.com>
Cc: Mauelshagen@sistina.com, mge@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: Modularize /proc/partitons (was Re: /proc/partitions for LVM)
Message-ID: <20001123214838.B8881@wire.cadcamlab.org>
In-Reply-To: <3A1C3523.A111CDD9@fsc-usa.com> <20001122221152.B4406@srv.t-online.de> <3A1C3A57.9768247B@fsc-usa.com> <20001122235335.C4687@srv.t-online.de> <3A1D7587.D990B92E@fsc-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A1D7587.D990B92E@fsc-usa.com>; from kressb@fsc-usa.com on Thu, Nov 23, 2000 at 02:52:39PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Brian Kress]
> 1)  Add a function pointer to struct gendisk called hd_name.
> 
> 2)  Make disk_name in fs/partitions/check.c use that function
>     pointer if its non-null.
> 
> 3)  Change the following drivers to use this method. (adding the
>     driver specific method and removing the old code in check.c)

Looks good to me ... except that cpqarray.c, cciss.c and DAC960.c have
basically duplicate functions.  Would this be a net win:

  char *typical_disk_name(struct gendisk *, int major_base, int minor, char *buf);

...exported from check.c?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
