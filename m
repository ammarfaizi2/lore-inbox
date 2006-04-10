Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWDJHyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWDJHyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWDJHyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:54:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:26828 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751073AbWDJHyx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:54:53 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH] deinline some functions in aic7xxx drivers, save 80k of text
Date: Mon, 10 Apr 2006 10:54:39 +0300
User-Agent: KMail/1.8.2
Cc: SCSI List <linux-scsi@vger.kernel.org>, linux-kernel@vger.kernel.org,
       gibbs@scsiguy.com
References: <200604100844.12151.vda@ilport.com.ua> <200604101015.36869.vda@ilport.com.ua> <200604100919.23244.eike-kernel@sf-tec.de>
In-Reply-To: <200604100919.23244.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604101054.39154.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 April 2006 10:19, Rolf Eike Beer wrote:
> [Full quote and readded CC adresses. My fault, pressed wrong button]
> 
> Denis Vlasenko wrote:
> > On Monday 10 April 2006 10:03, Rolf Eike Beer wrote:
> > > Am Montag, 10. April 2006 07:49 schrieben Sie:
> > > > On Monday 10 April 2006 08:44, Denis Vlasenko wrote:
> > > > > I also spotted two bugs in the process, patches
> > > > > for those will follow.
> > > >
> > > > ahd_delay(usec) is buggy. Just think how would it work
> > > > with usec == 1024*100 + 1...
> > >
> > > This is unneeded. The biggest argument this function is ever called with
> > > is 1000.
> >
> > I know.
> >
> > > I would suggest to delete this function completely. If one ever has to
> > > wait for a longer period mdelay() is the right function to call.
> >
> > I am leaving it up to maintainer to decide. After all, the driver
> > is for multiple OSes, other OS may lack mdelay().
> 
> The comment says about multiple milliseconds sleeps which just don't happen.

# grep -r ah._delay.[A-Z] .
./aic7xxx_core.c:       ahc_delay(AHC_BUSRESET_DELAY);
./aic79xx_core.c:       ahd_delay(AHD_BUSRESET_DELAY);
./aic79xx_core.c:       ahd_delay(AHD_BUSRESET_DELAY);

I am not sure that this constant won't be redefined to something large.
If maintainer knows better, he can take care of it.
I just fixed an obvious latent bug.
--
vda
