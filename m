Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131125AbRBVWlg>; Thu, 22 Feb 2001 17:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130298AbRBVWlU>; Thu, 22 Feb 2001 17:41:20 -0500
Received: from [199.239.160.155] ([199.239.160.155]:1037 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S131120AbRBVWlK>; Thu, 22 Feb 2001 17:41:10 -0500
Date: Thu, 22 Feb 2001 14:40:55 -0800
From: Robert Read <rread@datarithm.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use correct include dir for build tools
Message-ID: <20010222144055.B20752@tenchi.datarithm.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010222123940.A20319@tenchi.datarithm.net> <E14W4EP-00055G-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14W4EP-00055G-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 22, 2001 at 10:28:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, my bad, I forgot about cross-compiles. The problem was
scripts/split-include.c includes errno.h, which requires linux/errno.h
to exist, and I thought it would be better to use the current kernel's
version, rather than the system version. I guess not.

robert


On Thu, Feb 22, 2001 at 10:28:58PM +0000, Alan Cox wrote:
> >  FINDHPATH      = $(HPATH)/asm $(HPATH)/linux $(HPATH)/scsi $(HPATH)/net
> >  
> >  HOSTCC         = gcc
> > -HOSTCFLAGS     = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
> > +HOSTCFLAGS     = -I$(HPATH) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
> 
> That seems odd. Which build tools need to find kernel includes for this kernel
> not the standard C includes
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
