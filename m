Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319596AbSIMKu0>; Fri, 13 Sep 2002 06:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319597AbSIMKu0>; Fri, 13 Sep 2002 06:50:26 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:27399 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319596AbSIMKuZ>; Fri, 13 Sep 2002 06:50:25 -0400
Message-ID: <3D81C3EF.9509A4D0@aitel.hist.no>
Date: Fri, 13 Sep 2002 12:54:39 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
Subject: Re: Killing/balancing processes when overcommited
References: <XFMail.20020913100519.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:
> 
> > I still favor an installation file in /etc specifying the order in which
> > things are to be killed. Any alogrithmic assumptions are bound to fail at
> > some point to the dissatisfaction of the installation.
> 
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

This is hard to setup, and has the some weaknesses:
1. You worry only about apps you _know_.  But the guy who got
his netscape or make -j killed will rename his
copies of these apps to something else so your carefully
set up oom killer won't know what is running.  
(How much memory is the "mybrowser" app supposed to use?)
Or he'll get another software package that you haven't heard of.

2. Lots and lots of people running netscapes using
only 70M each will still be too much.  Think of
a university with xterms and then they all
goes to cnn.com or something for the latest news
about some large event.  

Even nice well-behaved apps
is bad when there is unusually many of them.  
There may be no particular "offender" to point
a finger at, even for a clueful administrator.
The perfect OOM killer cannot be written  - even
a human can't do that job well under all circumstances.

Helge Hafting
