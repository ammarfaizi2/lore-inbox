Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSFYBUj>; Mon, 24 Jun 2002 21:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSFYBUi>; Mon, 24 Jun 2002 21:20:38 -0400
Received: from perplex.selfdestruct.net ([195.197.225.4]:1193 "EHLO
	perplex.selfdestruct.net") by vger.kernel.org with ESMTP
	id <S315439AbSFYBUi>; Mon, 24 Jun 2002 21:20:38 -0400
Date: Tue, 25 Jun 2002 04:16:29 +0300
From: Toni Viemero <toni.viemero@iki.fi>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another .text.exit error with 2.4.19-rc1
Message-ID: <20020625011629.GA3415@perplex.selfdestruct.net>
References: <20020624215619.GE27147@perplex.selfdestruct.net> <10787.1024958968@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10787.1024958968@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2002 at 08:49:28AM +1000, Keith Owens wrote:
> On Tue, 25 Jun 2002 00:56:19 +0300, 
> Toni Viemero <toni.viemero@iki.fi> wrote:
> >drivers/scsi/scsidrv.o(.data+0x3874): undefined reference to local symbols
> >in discarded section .text.exit'
> >aq144:/usr/src/linux# perl ../reference_discarded.pl 
> >Finding objects, 392 objects, ignoring 0 module(s)
> >Finding conglomerates, ignoring 35 conglomerate(s)
> >Scanning objects
> >Error: ./drivers/scsi/ips.o .data refers to 000000d4 R_386_32
> >.text.exit
> 
> Untested.
> 
> --- drivers/scsi/ips.c	Tue Jun  4 13:34:30 2002
> +++ drivers/scsi/ips.c.new	Tue Jun 25 08:48:25 2002
> @@ -284,7 +284,7 @@
>         name:		ips_hot_plug_name,
>         id_table:	ips_pci_table,
>         probe:		ips_insert_device,
> -       remove:		ips_remove_device,
> +       remove:		__devexit_p(ips_remove_device),
>     };
>  #endif

Tested and now compiles/works ok.

-- 
Toni Viemerö  |  http://selfdestruct.net
"The scars will take me far, they always do."
