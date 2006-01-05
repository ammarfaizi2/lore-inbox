Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751849AbWAERNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWAERNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWAERNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:13:39 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:32947 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751849AbWAERNi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:13:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pKyHd4EOAJFssIA29k+GvDRf3+/wO20m6wQtIJcs5zCbMdBjPKfLm5tv0hSLeplgdWBqBthFV0k1AhftCaPeNj9iRXuOsbX1y+XeHukW426UG0amjsqz0S3vtHKQmxA0epDriy/6L3UAWXfaQP6BOsp95wDEi24HWMT67gREvCY=
Message-ID: <d120d5000601050913n54677e8bib01f4bd70d5f7ee4@mail.gmail.com>
Date: Thu, 5 Jan 2006 12:13:36 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.15-ck1
Cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200601051739.05441.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041200.03593.kernel@kolivas.org>
	 <200601051619.17366.ak@suse.de> <20060105163058.GA9381@corona.suse.cz>
	 <200601051739.05441.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Andi Kleen <ak@suse.de> wrote:
> On Thursday 05 January 2006 17:30, Vojtech Pavlik wrote:
> > On Thu, Jan 05, 2006 at 04:19:16PM +0100, Andi Kleen wrote:
> > > On Thursday 05 January 2006 07:42, Vojtech Pavlik wrote:
> > >
> > > > > I haven't checked recently if keyboard has been fixed by now.
> > > >
> > > > It's not. At this moment it's impossible to remove without significant
> > > > surgery to the driver, because it'd prevent hotplugging and many KVMs
> > > > from working.
> > >
> > > Sorry? You say you can't do hot plugging in the keyboard driver
> > > without a polling timer?
> > >
> > > That sounds quite bogus to me. A zillion other OS do keyboards
> > > fine without polling timers.
> >
> > I can either have the polling timer, or the IRQs acquired all the time.
> > The later needs significant changes to the driver - I currently enable
> > the IRQs only if a device is present.
>
> You mean you run the timer to avoid aquiring the interrupt early?
>

Yes, until some driver claims serio port interrupt is not acquired and
thus available for others.

I would say we could bump the timer as high as 5 seconds for
hotplugging. It may give delay with some KVMs, but only first time you
switch to the box in question.

--
Dmitry
