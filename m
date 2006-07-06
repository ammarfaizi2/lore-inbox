Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWGFV77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWGFV77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWGFV77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:59:59 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41222 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750880AbWGFV76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:59:58 -0400
Date: Thu, 6 Jul 2006 23:59:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Henne <henne@nachtwindheim.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Neela.Kolli@engenio.com,
       kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [KJ] [PATCH] fix legacy megaraid-driver to compile without CONFIG_PROC_FS
Message-ID: <20060706215957.GX26941@stusta.de>
References: <44AD6A5A.5060403@nachtwindheim.de> <20060706131447.ed46c3cb.rdunlap@xenotime.net> <44AD73AD.5080402@nachtwindheim.de> <20060706204252.GV26941@stusta.de> <44AD78A1.5010708@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AD78A1.5010708@nachtwindheim.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 10:54:57PM +0200, Henne wrote:
> Adrian Bunk schrieb:
> > On Thu, Jul 06, 2006 at 10:33:49PM +0200, Henne wrote:
> >>>> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> >>>>
> >>>> Create an empty inline function to make the legacy megaraid-driver compile
> >>>> without PROC_FS.
> >>>> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
> >>>> ---
> >>>>
> >>>> --- linux-2.6.18-rc1/drivers/scsi/megaraid.h    2006-06-18 03:49:35.000000000 +0200
> >>>> +++ linux/drivers/scsi/megaraid.h       2006-07-06 21:39:59.000000000 +0200
> >>>> @@ -1039,6 +1039,9 @@
> >>>>  static int proc_rdrv_30(char *, char **, off_t, int, int *, void *);
> >>>>  static int proc_rdrv_40(char *, char **, off_t, int, int *, void *);
> >>>>  static int proc_rdrv(adapter_t *, char *, int, int);
> >>>> +#else
> >>>> +static inline void
> >>>> +mega_create_proc_entry(int index, struct proc_dir_entry *parent) {}
> >>>>  #endif
> >>>>
> >>>>  static int mega_adapinq(adapter_t *, dma_addr_t);
> >>> Already in -mm:
> >>> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/broken-out/drivers-scsi-megaraidc-add-a-dummy-mega_create_proc_entry-for-proc_fs=y.patch
> >> Great, but isn't it better to put that define stuff into the headers?
> > 
> > No - the function itself is static (and has therefore itself no 
> > prototype in any header).
> > 
> > If the function was global, I'd agree with you.
> > 
> >> Thanks and Greets,
> >> Henne
> > 
> > cu
> > Adrian
> > 
> The header I mean is /drivers/scsi/megaraid.h and is only used by megaraid.c.
> And there are the prototypes, in dependency of CONFIG_PROC_FS, for all these other proc-related functions.
> Thats why I decided to make the change there and not in megaraid.c .

Prototypes for static functions don't belong into header files.

That this has been done in megaraid.h in the past is something that 
should be cleaned up, not a good example.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

