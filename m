Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSFXMqW>; Mon, 24 Jun 2002 08:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSFXMqV>; Mon, 24 Jun 2002 08:46:21 -0400
Received: from mail.zmailer.org ([62.240.94.4]:48305 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S313125AbSFXMqT>;
	Mon, 24 Jun 2002 08:46:19 -0400
Date: Mon, 24 Jun 2002 15:46:20 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>
Cc: Chris McDonald <chris@cs.uwa.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
Message-ID: <20020624154620.P19520@mea-ext.zmailer.org>
References: <3D16DE83.3060409@tiscalinet.it> <200206240934.g5O9YL524660@budgie.cs.uwa.edu.au> <3D16F252.90309@tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D16F252.90309@tiscalinet.it>; from dangelo.sasaman@tiscalinet.it on Mon, Jun 24, 2002 at 12:20:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2002 at 12:20:02PM +0200, Salvatore D'Angelo wrote:
> In this piece of code I convert seconds and microseconds in 
> milliseconds. I think the problem is not in my code, in fact I wrote the 
> following piece of code in Java, and it does not work too. In the for 
> loop the 90% of times b > a while for 10% of times not.
> 
...
>                     long a = System.currentTimeMillis();
>                     long b = System.currentTimeMillis();
>                     if (a > b) {
>                          System.out.println("Wrong!!!!!!!!!!!!!");
>                     }


   So in 10% of the cases, two successive calls yield time
   rolling BACK ?

   I used  gettimeofday()  call, and compared the original data
   from the code.

   At a modern uniprocessor machine I never get anything except
   monotonously increasing time (TSC is used in betwen timer ticks
   to supply time increase.)   At a dual processor machine, on
   occasion I do get SAME value twice.   I have never seen time
   rolling backwards.

   Uh..  correction:  216199245  0:-1  -- it did step backwards,
   but only once within about 216 million gettimeofday() calls.
   (I am running 2.4.19-pre8smp at the test box.)

/Matti Aarnio
