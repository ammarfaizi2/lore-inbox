Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265366AbUEZI7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUEZI7R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 04:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUEZI7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 04:59:16 -0400
Received: from plus.ds14.agh.edu.pl ([149.156.124.14]:63725 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S265366AbUEZI7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 04:59:12 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Don't return void types from void functions.
Date: Wed, 26 May 2004 10:59:10 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405260606.i4Q66dXB023475@hera.kernel.org> <40B43913.7010207@pobox.com> <200405261138.41008.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200405261138.41008.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405261059.10930.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 of May 2004 10:38, Denis Vlasenko wrote:
> On Wednesday 26 May 2004 09:28, Jeff Garzik wrote:
> > Linux Kernel Mailing List wrote:
> > > diff -Nru a/drivers/net/tokenring/olympic.c
> > > b/drivers/net/tokenring/olympic.c ---
> > > a/drivers/net/tokenring/olympic.c	2004-05-25 23:06:49 -07:00 +++
> > > b/drivers/net/tokenring/olympic.c	2004-05-25 23:06:49 -07:00 @@ -1806,7
> > > +1806,7 @@
> > >
> > >  static void __exit olympic_pci_cleanup(void)
> > >  {
> > > -	return pci_unregister_driver(&olympic_driver) ;
> > > +	pci_unregister_driver(&olympic_driver) ;
> > >  }
> >
> > Can we make gcc error out when it finds this?
>
> AFAIK new C++ standard allows this syntax.
>
> typedef int opaque;
>
> opaque f();
> opaque g() { return f(); }
>
> Now imagine we need to change
> -typedef int opaque;
> +typedef void opaque;

strict ISO C++ - yes,
strict ISO C - no.

# g++ -Wall -s -c void_ret.cpp -pedantic-errors

# gcc -Wall -s -c void_ret.c -pedantic-errors
void_ret.c: In function `g':
void_ret.c:4: error: `return' with a value, in function returning void

# gcc --version
gcc (GCC) 3.4.0 SSP (PLD Linux)
(...)

-- 
If you think of MS-DOS as mono, and Windows as stereo,
  then Linux is Dolby Digital and all the music is free...
