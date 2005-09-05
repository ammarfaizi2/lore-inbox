Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVIEAOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVIEAOf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 20:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVIEAOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 20:14:35 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:25511 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932236AbVIEAOd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 20:14:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yg2WFKh1EZQU5giTWEU6qveEAN85LcxcgNal4F/TTL5jaItZmliej9EUW0TPZYlPix8UqExJhe2n4mhJv3/B5s1dCYO1djHerfgLyhcIyIjoJZ/WOHajd9p505USfGPrnojsAJxavB6fqWxL34d6DdQPddpsjej3CPeA//rXYxg=
Message-ID: <29495f1d05090417146fa89e54@mail.gmail.com>
Date: Sun, 4 Sep 2005 17:14:33 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Johannes Stezenbach <js@linuxtv.org>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>,
       Domen Puncer <domen@coderock.org>
Subject: Re: [DVB patch 54/54] ttusb-budget: use time_after_eq()
In-Reply-To: <20050905000746.GA20663@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904232259.777473000@abc> <20050904232337.296861000@abc>
	 <29495f1d05090416453841f8d4@mail.gmail.com>
	 <20050905000746.GA20663@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> On Sun, Sep 04, 2005 Nish Aravamudan wrote:
> > On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > >
> > > -static int numpkt = 0, lastj, numts, numstuff, numsec, numinvalid;
> > > +static int numpkt = 0, numts, numstuff, numsec, numinvalid;
> > > +static unsigned long lastj;
> > >
> > >  static void ttusb_process_muxpack(struct ttusb *ttusb, const u8 * muxpack,
> > >                            int len)
> > > @@ -779,7 +781,7 @@ static void ttusb_iso_irq(struct urb *ur
> > >                         u8 *data;
> > >                         int len;
> > >                         numpkt++;
> > > -                       if ((jiffies - lastj) >= HZ) {
> > > +                       if (time_after_eq(jiffies, lastj + HZ)) {
> >
> > I think you actually want:
> >
> > static void ttusb_iso_irq(....)
> > {
> >      unsigned long lastj;
> >
> >      ...
> >
> >      lastj = jiffies + HZ;
> >      if (time_after_eq(jiffies, lastj)) {
> >           ...
> >
> > }
> >
> > The current code doesn't assign jiffies to lastj at any point that I see.
> 
> The code in question is used to print a one-per-second debug output,
> and lastj is assigned after every print.

Ah yes, didn't see that in the current code, sorry for that noise.
Still, lastj is local to ttusb_iso_irq(), right?

> I agree that it's ugly, though.

Fair enough :)

Thanks,
Nish
