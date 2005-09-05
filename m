Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVIEAQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVIEAQm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 20:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVIEAQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 20:16:42 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:34806 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932227AbVIEAQl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 20:16:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fByfUB5s/jURKAmTZmrkYUAdHvlmZgRIUk2bgZTk1PN2VAUfFxqDATzcUv4RhMQ73PAxoVjWM/3rbBPPwlQXIS6MEGjgCWLtT4BK/nzSfNatwryEBd3ArlD37DGaffKYAcHGnRnvQBHNONoEE18M+CAvMQs6dO1xucjM7xc//tw=
Message-ID: <29495f1d05090417165837a07b@mail.gmail.com>
Date: Sun, 4 Sep 2005 17:16:39 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Johannes Stezenbach <js@linuxtv.org>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Oliver Endriss <o.endriss@gmx.de>, Patrick Boettcher <pb@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [DVB patch 51/54] ttpci: av7110: RC5+ remote control support
In-Reply-To: <20050905001336.GB20663@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904232259.777473000@abc> <20050904232336.080662000@abc>
	 <29495f1d05090416413caf9043@mail.gmail.com>
	 <20050905001336.GB20663@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> On Sun, Sep 04, 2005 Nish Aravamudan wrote:
> > On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > > --- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110_ir.c  2005-09-04 22:03:40.000000000 +0200
> > > +++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110_ir.c       2005-09-04 22:31:00.000000000 +0200
> > > @@ -7,16 +7,16 @@
> > >  #include <asm/bitops.h>
> > >
> > >  #include "av7110.h"
> > > +#include "av7110_hw.h"
> > >
> > > -#define UP_TIMEOUT (HZ/4)
> > > +#define UP_TIMEOUT (HZ*7/25)
> >
> > Should this be
> >
> > #define UP_TIMEOUT msecs_to_jiffies(280)
> >
> > or
> >
> > #define UP_TIMEOUT (7*msecs_to_jiffies(40)
> >
> > ?
> 
> I agree it's nicer to read, but AFAIK not required for correctness?
> If so, then we'll fix those up in linuxtv.org CVS and submit
> cleanup patches later.

Yeah, it's correct with the three current values of HZ (100, 250 and
1000), but if you try a not-so-clean value (like Con did with 864, or
something), you might run into rounding issues. msecs_to_jiffies()
should take care of them (or will be a single point to do so
eventually).

Thanks,
Nish
