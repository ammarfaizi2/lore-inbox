Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKTRDa>; Mon, 20 Nov 2000 12:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQKTRDU>; Mon, 20 Nov 2000 12:03:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:7172 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129187AbQKTRDK>; Mon, 20 Nov 2000 12:03:10 -0500
Date: Mon, 20 Nov 2000 10:29:24 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jmerkey@timpanogas.org,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre22
Message-ID: <20001120102924.B30798@vger.timpanogas.org>
In-Reply-To: <20001119225041.C29253@vger.timpanogas.org> <Pine.LNX.4.10.10011201103390.31651-100000@chaos.thphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10011201103390.31651-100000@chaos.thphy.uni-duesseldorf.de>; from kai@thphy.uni-duesseldorf.de on Mon, Nov 20, 2000 at 11:10:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2000 at 11:10:21AM +0100, Kai Germaschewski wrote:
> 
> On Sun, 19 Nov 2000, Jeff V. Merkey wrote:
> 
> > ISDN_MODEM_ANZREG undefined on 2.4.0-10(11) and 2.2.18-22, rpm.spec is 
> > attached.
> 
> This has been fixed 2000/03/03, see below. Just use the latest version,
> ftp.isdn4linux.de/pub/isdn4linux/utils/isdn4k-utils.v3.1pre1.tar.gz
> 
> --Kai

This patch was not included in the pre1.tar.gz I downloaded last week.
You may want to check the binary and make certain it's got the later file.
I will check our archives as well.  You will note the rpm.spec file I sent
you was pulling the pre1.tar.gz off your site directly during the build,
(RPM is a studly tool).

Jeff


> 
> 
> Index: iprofd.c
> ===================================================================
> RCS file: /i4ldev/isdn4k-utils/iprofd/iprofd.c,v
> retrieving revision 1.7
> retrieving revision 1.8
> diff -u -r1.7 -r1.8
> --- iprofd.c	1999/09/06 08:03:25	1.7
> +++ iprofd.c	2000/03/03 12:45:53	1.8
> @@ -1,4 +1,4 @@
> -/* $Id: iprofd.c,v 1.7 1999/09/06 08:03:25 fritz Exp $
> +/* $Id: iprofd.c,v 1.8 2000/03/03 12:45:53 calle Exp $
>  
>   * Daemon for saving ttyIx-profiles to a file.
>   *
> @@ -22,6 +22,9 @@
>   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
>   * $Log: iprofd.c,v $
> + * Revision 1.8  2000/03/03 12:45:53  calle
> + * Make compile with newer versions of kernel drivers.
> + *
>   * Revision 1.7  1999/09/06 08:03:25  fritz
>   * Changed my mail-address.
>   *
> @@ -67,8 +70,12 @@
>  #ifndef ISDN_LMSNLEN
>  #define ISDN_LMSNLEN 0
>  #endif
> +
> +#ifndef ISDN_MODEM_NUMREG
> +#define ISDN_MODEM_NUMREG ISDN_MODEM_ANZREG
> +#endif
>  
> -#define BUFSZ ((ISDN_MODEM_ANZREG+ISDN_MSNLEN+ISDN_LMSNLEN)*ISDN_MAX_CHANNELS)
> +#define BUFSZ ((ISDN_MODEM_NUMREG+ISDN_MSNLEN+ISDN_LMSNLEN)*ISDN_MAX_CHANNELS)
>  
>  void
>  dumpModem(int dummy)
> 
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
