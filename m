Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319782AbSIMUXm>; Fri, 13 Sep 2002 16:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319783AbSIMUXm>; Fri, 13 Sep 2002 16:23:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:35713 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S319782AbSIMUXl>; Fri, 13 Sep 2002 16:23:41 -0400
Subject: RE: Killing/balancing processes when overcommited
From: "Timothy D. Witham" <wookie@osdl.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Jim Sibley <jlsibley@us.ibm.com>, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org,
       Thunder from the hill <thunder@lightweight.ods.org>
In-Reply-To: <XFMail.20020913100519.pochini@shiny.it>
References: <XFMail.20020913100519.pochini@shiny.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Sep 2002 13:23:29 -0700
Message-Id: <1031948609.1458.181.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 01:05, Giuliano Pochini wrote:
> 
> > I still favor an installation file in /etc specifying the order in which
> > things are to be killed. Any alogrithmic assumptions are bound to fail at
> > some point to the dissatisfaction of the installation.
> 

  There is another solution.  And that is never allocate memory unless
you have swap space.  Yes, the issue is that you need to have lots of
disk allocated to swap but on a big machine you will have that space.

  This way the offending process that asks for more memory will be
the one that gets killed.  Even if the 1st couple of ones aren't the
misbehaving process eventually it will ask for more memory and suffer
process execution.  

  Of course you don't allocate swap every time somebody asks for
a byte but you do it on some big boundary and do it when somebody
crosses that line.

  Tim

> I agree, I don't see any other solution. btw the thing is not
> simple. The oom killer should be able to comply instructions
> like:
> 
> if (oom)
>   kill netscape if it uses more than 80MB {stdprio 10}
>   //sometimes if start sucking memory endlessly
>   kill make and its childs if overall they use {stdprio 7}
>   more than ...[cpu files memory]
>   //ever tried to make -j bzImage on a 64MB box ?
>   kill httpd if it's swapping too much {stdprio 3}
>   ...
> 
> 
> Well, it's not simple. It must be planned carefully, or it
> will and up being as uneffective as the current killer is.
> 
> 
> Bye.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

