Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWDJI4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWDJI4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 04:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWDJI4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 04:56:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:63719 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751001AbWDJI4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 04:56:52 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] deinline some functions in aic7xxx drivers, save 80k of text
Date: Mon, 10 Apr 2006 11:56:30 +0300
User-Agent: KMail/1.8.2
Cc: linux-scsi@vger.kernel.org, gibbs@scsiguy.com,
       linux-kernel@vger.kernel.org
References: <200604100844.12151.vda@ilport.com.ua> <443A1AA5.8060707@s5r6.in-berlin.de>
In-Reply-To: <443A1AA5.8060707@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604101156.30717.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 April 2006 11:43, Stefan Richter wrote:
> Denis Vlasenko wrote:
> ...
> > +++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_core.c	Sun Apr  9 21:49:25 2006
> ...
> > +#include "aic79xx_osm_o.c"
> > +#include "aic79xx_inline.c"
> ...
> > +++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_core.c	Sun Apr  9 21:49:25 2006
> ...
> > +#include "aic7xxx_osm_o.c"
> > +#include "aic7xxx_inline.c"
> ...
> 
> Instead of including c files with function definitions, you should add
> function prototypes to header files (it seems you already did so) and
> include only the header files. Include these header files in the c files
> which call the functions as well as in the c files which define the
> functions.

I will do this if maintainer will inform me that he wants it done.
Or maybe he wants it done in some other way, who knows?
I am not lazy, I am just not good at reading other peoples' minds.

> It is obviously necessary to modify the Makefile to have aic7?xx_osm_o.o
> and aic7?xx_inline.o linked to an appropriate .ko file.

I did compile test my changes.

> Furthermore, aic7?xx_inline.c are not very fitting file names since they
> do not contain inline functions. aic7?xx_osm_o.c are somewhat strange
> names either. Can't you move the functions into existing c files? E.g.

I can, but I won't without maintainer's consent.

> into those which contain most of the calls to the now de-inlined
> functions. From the point of view of cross-OS driver maintenance (but
> not necessarily from the point of view of Linux driver maintenance), it
> may be useful to distinguish between functions used across OSs and those
> used only in Linux when deciding where to move the functions.
--
vda
