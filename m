Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTAHNXH>; Wed, 8 Jan 2003 08:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTAHNXH>; Wed, 8 Jan 2003 08:23:07 -0500
Received: from smtp03.iprimus.com.au ([210.50.30.52]:56587 "EHLO
	smtp03.iprimus.com.au") by vger.kernel.org with ESMTP
	id <S267436AbTAHNXF>; Wed, 8 Jan 2003 08:23:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Paul <krushka@iprimus.com.au>
Reply-To: krushka@iprimus.com.au
To: linux-kernel@vger.kernel.org
Subject: Re: Fwd: File system corruption
Date: Wed, 8 Jan 2003 23:38:22 +1000
X-Mailer: KMail [version 1.2]
References: <0301062138130A.01466@paul.home.com.au> <1041865580.17472.17.camel@irongate.swansea.linux.org.uk> <20030107130832.A4953@bitwizard.nl>
In-Reply-To: <20030107130832.A4953@bitwizard.nl>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>
MIME-Version: 1.0
Message-Id: <03010823382201.01198@paul.home.com.au>
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 08 Jan 2003 13:31:43.0771 (UTC) FILETIME=[48C52EB0:01C2B71A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have put the gzipped image here if anyone wants to take a peek :)
size==348k, unzips to ~64Mb

http://home.iprimus.com.au/krushka/img.gz

On Tue,  7 Jan 2003 10:08 pm, you wrote:
> On Mon, Jan 06, 2003 at 03:06:20PM +0000, Alan Cox wrote:
> > Might be interesting to see what it does given a totally not FAT
> > environment (eg fill the disk start to end with each sector filled
> > with its sector number repeatedly) and see what comes out the other
> > end.
>
> How about the following program to do this.
>
> 			Roger.
>
>
> /* Written By R.E.Wolff@BitWizard.nl
>  *
>  * This program is distributed under GPL. */
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <string.h>
>
> int main (int argc, char **argv)
> {
>   int i;
>   int ascii = 0;
>   int size = 512;
>   long long secno;
>   char *buf;
>   int s;
>
>   for (i=1;i<argc;i++) {
>     if (strcmp (argv[i], "-a") == 0) {
>       ascii = 1;
>     }
>     if (strcmp (argv[i], "-b") == 0) {
>       ascii = 0;
>     }
>
>     if (strncmp (argv[i], "-s", 2) == 0) {
>       if (strlen (argv[i]) > 2)
> 	size = atoi (argv[i]+2);
>       else
> 	/* Sorry. Will crash if you specify -s as the last argument */
> 	size = atoi (argv[++i]);
>     }
>   }
>
>   buf = malloc (size + 16);
>
>   if (!buf) {
>     fprintf (stderr, "Can't allocate buffer.\n");
>     exit (1);
>   }
>
>   secno = 0;
>   while (1) {
>     if (ascii) {
>       sprintf (buf, "%lld\n", secno);
>       s = strlen (buf);
>       for (i=s;i<size;i+=s)
> 	sprintf (buf+i, "%lld\n", secno);
>     } else {
>       for (i=0;i<size;i+=sizeof (long long))
> 	*(long long *)(buf+i) = secno;
>     }
>     if (write (1, buf, size) < 0)
>       break;
>     secno++;
>   }
>   exit (0);
> }
