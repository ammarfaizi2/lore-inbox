Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268567AbRGYNPJ>; Wed, 25 Jul 2001 09:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268568AbRGYNO7>; Wed, 25 Jul 2001 09:14:59 -0400
Received: from mx1.nameplanet.com ([62.70.3.31]:54797 "HELO mx1.nameplanet.com")
	by vger.kernel.org with SMTP id <S268567AbRGYNOs>;
	Wed, 25 Jul 2001 09:14:48 -0400
Date: Wed, 25 Jul 2001 15:53:34 +0200 (CEST)
From: Ketil Froyn <ketil@froyn.com>
To: "M. Tavasti" <tawz@nic.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Select with device and stdin not working
In-Reply-To: <m266chnqyd.fsf@akvavitix.vuovasti.com>
Message-ID: <Pine.LNX.4.30.0107251550370.20050-100000@pccn3.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 25 Jul 2001, M. Tavasti wrote:

> Here program where I get problems:
>
> int fd;
> fd_set rfds;
>
> fd = open("/dev/random", O_RDWR );
>
> while(1) {
>         FD_ZERO(&rfds);
>         FD_SET(fd,&rfds);
>         FD_SET(fileno(stdin),&rfds);
>         if( select(fd+1, &rfds, NULL, NULL, NULL  ) > 0) {
>                 fprintf(stderr,"Select\n");
>                 fflush(stderr);
>                 if(FD_ISSET(fd,&rfds)) {
>                  .......
>                 } else if(FD_ISSET(fileno(stdin),&rfds) ) {
>                  ......
>                 }
>         }
> }

It looks like you are sending the original fd_set to select. Remember that
it is modified in place. What is probably happening is that select returns
at once when it gets something from /dev/random, and rfds is now modified
to only contain this. The next time select runs, it will only be checking
for input from /dev/random. You have to make a copy of rfds that is set
every time, and send that instead.

Ketil

