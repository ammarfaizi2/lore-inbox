Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVIEA1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVIEA1i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 20:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVIEA1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 20:27:38 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:9346 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932242AbVIEA1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 20:27:37 -0400
Date: Mon, 5 Sep 2005 02:27:32 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Oliver Endriss <o.endriss@gmx.de>, Patrick Boettcher <pb@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Message-ID: <20050905002732.GA20808@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Nish Aravamudan <nish.aravamudan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Oliver Endriss <o.endriss@gmx.de>,
	Patrick Boettcher <pb@linuxtv.org>,
	Andrew de Quincey <adq_dvb@lidskialf.net>
References: <20050904232259.777473000@abc> <20050904232336.080662000@abc> <29495f1d05090416413caf9043@mail.gmail.com> <20050905001336.GB20663@linuxtv.org> <29495f1d05090417165837a07b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d05090417165837a07b@mail.gmail.com>
User-Agent: Mutt/1.5.10i
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: Re: [DVB patch 51/54] ttpci: av7110: RC5+ remote control support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 Nish Aravamudan wrote:
> On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > On Sun, Sep 04, 2005 Nish Aravamudan wrote:
> > > On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > > >
> > > > -#define UP_TIMEOUT (HZ/4)
> > > > +#define UP_TIMEOUT (HZ*7/25)
> > >
> > > #define UP_TIMEOUT msecs_to_jiffies(280)
> > > #define UP_TIMEOUT (7*msecs_to_jiffies(40)
> > 
> > I agree it's nicer to read, but AFAIK not required for correctness?
> > If so, then we'll fix those up in linuxtv.org CVS and submit
> > cleanup patches later.
> 
> Yeah, it's correct with the three current values of HZ (100, 250 and
> 1000), but if you try a not-so-clean value (like Con did with 864, or
> something), you might run into rounding issues. msecs_to_jiffies()
> should take care of them (or will be a single point to do so
> eventually).

Well, if msecs_to_jiffies() is the new way of specifying timeouts
we'd have a lot more to fix up in our tree. But something like
a remote control key-up timeout doesn't need much precision.
Generally I see nothing wrong with HZ/4, but something like
HZ*20/1000 could be problematic with small or odd HZ values.

Agreed? Or is it desired that people generally use msecs_to_jiffies()?

Johannes
