Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVGOS3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVGOS3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVGOS3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 14:29:42 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:14200 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261648AbVGOS3m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 14:29:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ORizV63OPP11hMFFNzHePxkY7ot+WvGhj/UAA5bd0MqLyxUKLxLZlFQTcc/iBRkJpNNR6N014jsp/C1I6Q9rjqGVcXOw29xFEbe3KYEO3zlTiA1irMQC7EIK+mndIWeBuIDU43vp2zfHi8WPb+vJgNDDqREbr5cDdd7S1LanERw=
Message-ID: <9cde8bff05071511293bef5908@mail.gmail.com>
Date: Sat, 16 Jul 2005 03:29:39 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] memparse bugfix
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050715181250.GO9153@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9cde8bff05071510307c7beb4@mail.gmail.com>
	 <20050715181250.GO9153@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/05, Chris Wright <chrisw@osdl.org> wrote:
> * aq (aquynh@gmail.com) wrote:
> > Function lib/cmdline.c:memparse() wrongly calculates the memory if the
> > given string has K/M/G suffix. This patch (against 2.6.13-rc3) fixes
> > the problem. Please apply.
> 
> Patch looks incorrect.
> 
> > --- 2.6.13-rc3/lib/cmdline.c  2005-04-30 10:31:37.000000000 +0900
> > +++ 2.6.13-rc3/lib/cmdline-aq.c       2005-07-16 02:25:26.000000000 +0900
> > @@ -100,10 +100,10 @@ unsigned long long memparse (char *ptr,
> >       switch (**retptr) {
> >       case 'G':
> >       case 'g':
> > -             ret <<= 10;
> > +             ret <<= 30;
> >       case 'M':
> >       case 'm':
> > -             ret <<= 10;
> > +             ret <<= 20;
> >       case 'K':
> >       case 'k':
> >               ret <<= 10;
> 
> Now, G == ret << 80, M == ret << 30...  Notice the fall-thru cases.
> 

oops, this code doesnt use "break" like normally. what a trap!

sorry for the noise :-)

regards,
aq
