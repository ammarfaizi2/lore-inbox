Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVFUI7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVFUI7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVFUIz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:55:57 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:18557 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262085AbVFUIxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 04:53:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aVlY0NaqqBsJ/O/G0YW8y51nxUo4mCx4qIFYzLM6xD+sNIUVujkp76E2bmvZ4Ww1IlTVLfaEQy4nyxJjXNN1y17i6Eqw/pewEblrLf+g2HgLQ1qoTi5tPdanfATyWWHpQtAQSdh5aOsA2ldogf3GUzqaP4CpQtI9crxoOF44gWg=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 12:59:22 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, Domen Puncer <domen@coderock.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506211259.22650.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 02:46, Jesper Juhl wrote:
> The patches all make the same change, there's just a lot of files the 
> change needs to be made in.  The change they make is to change strings 
> from the form
> 	[const] char *foo = "blah";
> to
> 	[const] char foo[] = "blah";

> Below I've just picked 5 of my patches at random to show you what they 
> look like. These should not be merged yet.

> --- linux-2.6.12-orig/drivers/isdn/hardware/avm/b1.c
> +++ linux-2.6.12/drivers/isdn/hardware/avm/b1.c

> -static char *revision = "$Revision: 1.1.2.2 $";
> +static char revision[] = "$Revision: 1.1.2.2 $";

Looks good:
  16323	    104	      0	  16427	   402b	drivers/isdn/hardware/avm/b1.o	2.95.3-before
  16291	    104	      0	  16395	   400b	drivers/isdn/hardware/avm/b1.o	2.95.3-after
  14643	    104	      0	  14747	   399b	drivers/isdn/hardware/avm/b1.o	3.3.5-20050130-before
  14621	    104	      0	  14725	   3985	drivers/isdn/hardware/avm/b1.o	3.3.5-20050130-after
  15352	    104	      0	  15456	   3c60	drivers/isdn/hardware/avm/b1.o	4.1-20050604-before
  15330	    104	      0	  15434	   3c4a	drivers/isdn/hardware/avm/b1.o	4.1-20050604-after

> --- linux-2.6.12-orig/drivers/net/wireless/wavelan_cs.p.h
> +++ linux-2.6.12/drivers/net/wireless/wavelan_cs.p.h

> -static const char *version = "wavelan_cs.c : v24 (SMP + wireless extensions) 11/1/02\n";
> +static const char version[] = "wavelan_cs.c : v24 (SMP + wireless extensions) 11/1/02\n";

  21018	    456	      0	  21474	   53e2	drivers/net/wireless/wavelan_cs.o	2.95.3-before
  21018	    424	      0	  21442	   53c2	drivers/net/wireless/wavelan_cs.o	2.95.3-after
  19707	    424	     12	  20143	   4eaf	drivers/net/wireless/wavelan_cs.o	3.3.5-20050130-before
  19707	    392	     12	  20111	   4e8f	drivers/net/wireless/wavelan_cs.o	3.3.5-20050130-after
  17950	    424	     12  => 18386 <=   47d2	drivers/net/wireless/wavelan_cs.o	4.1-20050604-before
  17989	    392	     12  => 18393 <=   47d9	drivers/net/wireless/wavelan_cs.o	4.1-20050604-after

> --- linux-2.6.12-orig/drivers/net/appletalk/cops.c
> +++ linux-2.6.12/drivers/net/appletalk/cops.c

> -static const char *cardname = "cops";
> +static const char cardname[] = "cops";

Looks good:
  14005	    100	     72	  14177	   3761	drivers/net/appletalk/cops.o	2.95.3-before
  13989	     96	     72	  14157	   374d	drivers/net/appletalk/cops.o	2.95.3-after
  13308	    112	     72	  13492	   34b4	drivers/net/appletalk/cops.o	3.3.5-20050130-before
  13305	    112	     72	  13489	   34b1	drivers/net/appletalk/cops.o	3.3.5-20050130-after
  12948	    112	     72	  13132	   334c	drivers/net/appletalk/cops.o	4.1-20050604-before
  12945	    112	     72	  13129	   3349	drivers/net/appletalk/cops.o	4.1-20050604-after

> --- linux-2.6.12-orig/drivers/net/sun3lance.c
> +++ linux-2.6.12/drivers/net/sun3lance.c

> -static char *version = "sun3lance.c: v1.2 1/12/2001  Sam Creasey (sammy@sammy.net)\n";
> +static char version[] = "sun3lance.c: v1.2 1/12/2001  Sam Creasey (sammy@sammy.net)\n";

Be sure to have m68k cross-compiler handy.

> --- linux-2.6.12-orig/drivers/net/ibmlana.c
> +++ linux-2.6.12/drivers/net/ibmlana.c

> -		char *fill = "NetBSD is a nice OS too! ";
> +		char fill[] = "NetBSD is a nice OS too! ";

Don't:
   5721	     16	      4	   5741	   166d	drivers/net/ibmlana.o	2.95.3-before
   5737	     16	      4	   5757	   167d	drivers/net/ibmlana.o	2.95.3-after
   5163	     16	      4	   5183	   143f	drivers/net/ibmlana.o	3.3.5-20050130-before
   5169	     16	      4	   5189	   1445	drivers/net/ibmlana.o	3.3.5-20050130-after
   4993	     16	      4	   5013	   1395	drivers/net/ibmlana.o	4.1-20050604-before
   5028	     16	      4	   5048	   13b8	drivers/net/ibmlana.o	4.1-20050604-after
