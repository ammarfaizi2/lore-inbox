Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132560AbRDKMR4>; Wed, 11 Apr 2001 08:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132561AbRDKMRq>; Wed, 11 Apr 2001 08:17:46 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:11904 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S132560AbRDKMRh>; Wed, 11 Apr 2001 08:17:37 -0400
Message-ID: <3AD45949.5D925566@AnteFacto.com>
Date: Wed, 11 Apr 2001 14:16:57 +0100
From: Padraig Brady <Padraig@AnteFacto.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bart Trojanowski <bart@jukie.net>
CC: antonpoon@hongkong.com, linux-kernel@vger.kernel.org
Subject: Re: How can I add a function to the kernel initialization
In-Reply-To: <Pine.LNX.4.30.0104110718010.31213-100000@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These things usually sit off a serial port.
I.E. /dev/lcd is a link to /dev/ttyS0 or whatever.
Anyway the main point is you don't have access to libc.
So how can you access the serial port from the booting
kernel. Well to spit kernel messages out the serial
port you pass the console=ttyS1,19200 or equivalent
parameter to the kernel. So see what that is done 
in the kernel code and copy.

Note www.kernelnewbies.org is probably more appropriate 
for this sort of question.

Padraig.

Bart Trojanowski wrote:
> 
> First it does not work because you do not have access to libc in the
> kernel.  Secondly your LCD driver is not available at the time of
> start_kernel so there is no one to listen to the /dev/lcd.
> 
> The quickest hack would be to find your lcd driver and modify it to spit
> out the Loading Kernel, after it initializes.
> 
> B.
> 
> On Wed, 11 Apr 2001, antonpoon@hongkong.com wrote:
> 
> > I have written a driver for a character set LCD module using parallel port. I want to display a message when the kernel is initialized.
> >
> > I added the following to start_kernel() in init/main.c
> >
> > #include <stdio.h>
> >
> > {
> >   int i;
> >   char line = "Loading Kernel";
> >   FILE *ptr;
> >   ptr = fopen("/dev/lcd","w");
> >
> >   for (i=0;i<10;i++)
> >   {
> >       fprintf(ptr, "%s\n", line);
> >   }
> >   fclose(ptr);
> > }
> >
> > Error was found, it looks like that it can not include stdio.h in the initialization.
> > How can I do that?
> >
> > I wish to be personally CC'ed the answers/comments posted to the list in response to my posting. Thank you.
> >
> > Best Regards,
> > Anton
