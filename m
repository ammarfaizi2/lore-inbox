Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbRGYPHj>; Wed, 25 Jul 2001 11:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266949AbRGYPH3>; Wed, 25 Jul 2001 11:07:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266941AbRGYPHQ>; Wed, 25 Jul 2001 11:07:16 -0400
Date: Wed, 25 Jul 2001 11:07:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ben Greear <greearb@candelatech.com>
cc: "M. Tavasti" <tawz@nic.fi>, linux-kernel@vger.kernel.org
Subject: Re: Select with device and stdin not working
In-Reply-To: <3B5EDF6E.BB56B55A@candelatech.com>
Message-ID: <Pine.LNX.3.95.1010725110441.1108A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 25 Jul 2001, Ben Greear wrote:

> "M. Tavasti" wrote:
> > 
> > I found this problem first time in 2.2 kernels, when doing own device
> > driver. Then it was not an issue for me, and I suspected it's my
> > fault. Now, with 2.4 again I tried to solve problem, but I can't find
> > my way out of this, and looks like there in-kernel drivers which have
> > same symptoms.
> > 
> > Here program where I get problems:
> > 
> > int fd;
> > fd_set rfds;
> > 
> > fd = open("/dev/random", O_RDWR );
> > 
> > while(1) {
> >         FD_ZERO(&rfds);
> >         FD_SET(fd,&rfds);
> >         FD_SET(fileno(stdin),&rfds);
> >         if( select(fd+1, &rfds, NULL, NULL, NULL  ) > 0) {
> >                 fprintf(stderr,"Select\n");
> >                 fflush(stderr);
> >                 if(FD_ISSET(fd,&rfds)) {
> >                  .......
> >                 } else if(FD_ISSET(fileno(stdin),&rfds) ) {
> >                  ......
> >                 }
> >         }
> > }


Change: 
                 } else if(FD_ISSET(fileno(stdin),&rfds) ) {
To:
                 } if(FD_ISSET(fileno(stdin),&rfds) ) {

Both of these bits can be (probably are) set.
 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


