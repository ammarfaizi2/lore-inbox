Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269021AbRHLVJW>; Sun, 12 Aug 2001 17:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269436AbRHLVJL>; Sun, 12 Aug 2001 17:09:11 -0400
Received: from dv1.dataventures.com ([207.188.144.122]:4323 "EHLO
	dv1.dataventures.com") by vger.kernel.org with ESMTP
	id <S269021AbRHLVI5>; Sun, 12 Aug 2001 17:08:57 -0400
Message-ID: <3B76F05B.59E7E66E@dataventures.com>
Date: Sun, 12 Aug 2001 15:08:43 -0600
From: Donald Thompson <dlt@dataventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stallion EasyIO and devfs
In-Reply-To: <Pine.LNX.4.31.0107161135530.13603-100000@dv1.dataventures.com> <200107310112.f6V1C5e13968@mobilix.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works correctly. Didn't patch properly into 2.4.7 properly, think it
just
had the wrong line numbers. But patching it in by hand was no problem.
I'm 
missing compatability symlinks, so that I get links from /dev/ttyE/* to 
/dev/ttyE*, but thats another problem.

-Don

Richard Gooch wrote:
> 
> Donald Thompson writes:
> > I've got a stallion EasyIO PCI 4 port card running on kernel 2.4.4.
> > Loading the stallion.o module does not seem to create the proper device files
> > for me using devfs.
> >
> > Upon loading the module I get the following devices created:
> >
> > /dev/ttyE
> > /dev/cue
> > /dev/staliomem/0
> > /dev/staliomem/1
> > /dev/staliomem/2
> > /dev/staliomem/3
> >
> > I don't get /dev/ttyE0 through /dev/ttyE3 or /dev/ttyE/0 through
> > /dev/ttyE/3, which is what I believe should be happening.
> 
> Please apply the following patch to drivers/char/stallion.c and let me
> know if that helps.
> 
>                                 Regards,
> 
>                                         Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca
> 
> --- stallion.c~ Fri Mar  2 14:12:07 2001
> +++ stallion.c  Mon Jul 30 21:08:34 2001
> @@ -139,8 +139,13 @@
>  static char    *stl_drvtitle = "Stallion Multiport Serial Driver";
>  static char    *stl_drvname = "stallion";
>  static char    *stl_drvversion = "5.6.0";
> +#ifdef CONFIG_DEVFS_FS
> +static char    *stl_serialname = "ttyE/%d";
> +static char    *stl_calloutname = "cue/%d";
> +#else
>  static char    *stl_serialname = "ttyE";
>  static char    *stl_calloutname = "cue";
> +#endif
> 
>  static struct tty_driver       stl_serial;
>  static struct tty_driver       stl_callout;
