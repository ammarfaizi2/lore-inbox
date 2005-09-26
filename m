Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVIZI6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVIZI6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 04:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVIZI6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 04:58:05 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:52707 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932435AbVIZI6E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 04:58:04 -0400
Subject: Re: AIO Support and related package information??
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <20050926073220.55509.qmail@web8405.mail.in.yahoo.com>
References: <20050926073220.55509.qmail@web8405.mail.in.yahoo.com>
Date: Mon, 26 Sep 2005 10:59:51 +0200
Message-Id: <1127725191.2069.17.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 26/09/2005 11:11:15,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 26/09/2005 11:11:17,
	Serialize complete at 26/09/2005 11:11:17
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 08:32 +0100, vikas gupta wrote:
> hi Sebastien ,
> 
> I am having yet another query related to AIO Support
> 
> 1)As you mentioned that aio posix support is provided
> by glibc also so can you tell me on the performance
> basis which one is better (glibc implementation or
> libposix implementation ) and how do we measure the
> performance

  Have a look at:
http://www.bullopensource.org/posix/Bench/sysbench-oltp/sysbench.html
for benchmarks using Sysbench and MySQL.

> 
> I have compiled glibc with following command 
> 
> gcc -g $1.c -o $1 -lrt -lpthread 

  Then you're using glibc AIO implementation based on helper threads
and without taking advantage of kernel support.

> 
> 
> 2)What posix features is supported by bare kernel and
> libposix implementation, without applying the
> patches.I have broken down my  query in following
> parts

  Without any of the patches:

> 
> 2.1) aio_read/aio_write  is supported but what
> limitation are there

  Supported but without notification (SIGEV_NONE only).

> 
> 2.2) aio_fsync is supported or not

  Supported only if the underlying fs implements it

> 
> 2.3) what are the limitation with lio_listio

  Not supported wihtout the patches.

> 
> 2.4) what are the additional feature it provides for
> aio_cancel implementation
> 

  Needs support from the underlying fs.

> 
> 3) Is glibc implementation is providing all the above
> mentioned fetures

  Yes, I think so.

> 
> 4) Is there any test program that can measure
> efficiency for both glibc and libposix implementation

  I personally use Sysbench and have compiled 3 MySQL servers,
one with librt AIO, one with libposix-aio and one with MySQL
native simulated AIO.

  You may also try iozone.

> 
> 
> With Thanks in advance 
> Vikas 


  Hope this helps,

  Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

