Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVIEAeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVIEAeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 20:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVIEAeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 20:34:50 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:52110 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932114AbVIEAet convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 20:34:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LIuTIZ9YJpyVIxIggMwYiBKwykpb6FSBr95BrMcI501PPzU5Kc4AjpG6S9Mcp1BDbn5y7jUQJD5F5qpS7vo7QQ0fWsG3+mlVkoWhPebVdE063m8vb0XQSmedKcdDvoI7eXKRNApTlwsUTS+DYD98JYgtL/1VKbVYBg3UZall6EU=
Message-ID: <29495f1d05090417344abf386b@mail.gmail.com>
Date: Sun, 4 Sep 2005 17:34:45 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Johannes Stezenbach <js@linuxtv.org>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Oliver Endriss <o.endriss@gmx.de>, Patrick Boettcher <pb@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [DVB patch 51/54] ttpci: av7110: RC5+ remote control support
In-Reply-To: <20050905002732.GA20808@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904232259.777473000@abc> <20050904232336.080662000@abc>
	 <29495f1d05090416413caf9043@mail.gmail.com>
	 <20050905001336.GB20663@linuxtv.org>
	 <29495f1d05090417165837a07b@mail.gmail.com>
	 <20050905002732.GA20808@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> On Sun, Sep 04, 2005 Nish Aravamudan wrote:
> > On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > > On Sun, Sep 04, 2005 Nish Aravamudan wrote:
> > > > On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > > > >
> > > > > -#define UP_TIMEOUT (HZ/4)
> > > > > +#define UP_TIMEOUT (HZ*7/25)
> > > >
> > > > #define UP_TIMEOUT msecs_to_jiffies(280)
> > > > #define UP_TIMEOUT (7*msecs_to_jiffies(40)
> > >
> > > I agree it's nicer to read, but AFAIK not required for correctness?
> > > If so, then we'll fix those up in linuxtv.org CVS and submit
> > > cleanup patches later.
> >
> > Yeah, it's correct with the three current values of HZ (100, 250 and
> > 1000), but if you try a not-so-clean value (like Con did with 864, or
> > something), you might run into rounding issues. msecs_to_jiffies()
> > should take care of them (or will be a single point to do so
> > eventually).
> 
> Well, if msecs_to_jiffies() is the new way of specifying timeouts
> we'd have a lot more to fix up in our tree. But something like
> a remote control key-up timeout doesn't need much precision.
> Generally I see nothing wrong with HZ/4, but something like
> HZ*20/1000 could be problematic with small or odd HZ values.

This discussion comes up every time ;) HZ/4 rounds incorrectly
(depends on your perspective, I guess) with HZ=250.

> Agreed? Or is it desired that people generally use msecs_to_jiffies()?

I agree, generally it's ok, as timeouts aren't meant to be precise. I,
personally, am converting code over to msecs_to_jiffies() as I come to
it, just so that the conversions are consistent (a number in the tree
were not, not that yours are) and basically self-commented. And, like
I mentioned, they are automatically rounded correctly with "strange"
values of HZ.

The changes I mentioned in your patchset are generally not critical,
but just comments and my own preferences.

Thanks,
Nish
