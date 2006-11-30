Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759213AbWK3JX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759213AbWK3JX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759214AbWK3JX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:23:58 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:32666 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1759213AbWK3JX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:23:57 -0500
From: Torsten Ertbjerg Rasmussen <tr@newtec.dk>
Reply-To: tr@newtec.dk
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [PATCH] rtc: ds1743 support
Date: Thu, 30 Nov 2006 10:23:55 +0100
User-Agent: KMail/1.5
References: <200611300812.02261.tr@newtec.dk> <20061130094723.6ab9e1d3@inspiron>
In-Reply-To: <20061130094723.6ab9e1d3@inspiron>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301023.55196.tr@newtec.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 November 2006 09:47, you wrote:
> On Thu, 30 Nov 2006 08:12:02 +0100
>
> Torsten Ertbjerg Rasmussen <tr@newtec.dk> wrote:
> > The real time clocks ds1742 and ds1743 differs only in the size of the
> > nvram. This patch changes the existing ds1742 driver to support also
> > ds1743. The main change is that the nvram size is determined from the
> > resource attached to the device.
> >
> >
> > +	pdata->ioaddr_rtc = ioaddr + pdata->size_nvram;
> >
> >  	/* turn RTC on if it was not on */
> > +	ioaddr = pdata->ioaddr_rtc;
> >  	sec = readb(ioaddr + RTC_SECONDS);
>
>  why not
> 	sec = readb(pdata->ioaddr_rtc + RTC_SECONDS);
> ?

ioaddr is used several times below this point, so diff would be larger.

In the original code, ioaddr points to beginning of nvram and RTC_SECONDS 
implicitly adds the nvram size. Now the nvram size is removed from 
RTC_SECONDS (and other RTC_*) so ioaddr must point to start of rtc-data.

Regards,
Torsten Rasmussen

>
>
>  Acked-by: Alessandro Zummo <a.zummo@towertech.it>


