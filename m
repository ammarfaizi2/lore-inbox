Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269760AbRHDBm2>; Fri, 3 Aug 2001 21:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269750AbRHDBmS>; Fri, 3 Aug 2001 21:42:18 -0400
Received: from mail.zmailer.org ([194.252.70.162]:13072 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S269758AbRHDBmM>;
	Fri, 3 Aug 2001 21:42:12 -0400
Date: Sat, 4 Aug 2001 04:42:02 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Brad Bonkoski <bbonkoski@xyterra.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fw: select(2)
Message-ID: <20010804044202.G11046@mea-ext.zmailer.org>
In-Reply-To: <03f101c11c5b$b53a19d0$6e00a8c0@BBONKOSKI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f101c11c5b$b53a19d0$6e00a8c0@BBONKOSKI>; from bbonkoski@xyterra.com on Fri, Aug 03, 2001 at 01:34:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 01:34:34PM -0700, Brad Bonkoski wrote:
> > Hello,
> >
> > this code:
> > fd_set set;
> > struct timeval timeout;
> > int len_inet;
> > int n;
> > FD_ZERO(&set);
> > timeout.tv_sec = 1L;

  I would venture a guess that as you don't EXPLICITELY
  initialize the   timeout.tv_usec  value to be
  within  0  to   999999   it may get some system dependent
  sometimes random, sometimes fixed value (the joys of these
  stack-allocated "automatic" variables..)

  For short:  Smells of UNINITIALIZED PARAMETER DATA.

> > FD_SET(sc_sock,&set);
> > n = select(sc_sock+1, &set, NULL, NULL, &timeout);
> > if (n == -1)
> >
> 
> >   perror("select()\n");
> >   exit(1);
> > }
> >
> > Works just fine on one machine, i.e. select() does not return a '-1' which
> lets it run through the rest of the code.  However, on other machines, it
> does not work fine, -1 is always returned by select() with error of: Invalid
> arguement
> >
> > Any ideas on where I could look to fix this problem?  Something in the
> syntax of the posted code, or should I be looking at the creation of the
> socket?
> > TIA.
> > Brad
> >
> >
> >
> >
> >
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
