Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVKUPID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVKUPID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVKUPID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:08:03 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:6763 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932318AbVKUPIC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:08:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JgNXkbYWpjXGMMRAon3vCnfa6xw6w0SoonmFPQs1aOCGDJQIiV43BXIThhVGci/XzUhP7O7ne6O24dbmXYd7yAbnomzRgrOkamJL8sq1BtMiby+63RSUrou3MfTCSwtyZsmD3+ucnKZkX0Gt79wlfmS5ux0VITilTnKZFDchG7o=
Message-ID: <29495f1d0511210708t380b7ff7ic6759d59927c12d1@mail.gmail.com>
Date: Mon, 21 Nov 2005 07:08:01 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
Cc: Con Kolivas <kernel@kolivas.org>,
       =?ISO-8859-1?Q?Daniel_Marjam=E4ki?= <daniel.marjamaki@comhem.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4381A5D7.3020307@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <5aZsv-3CJ-17@gated-at.bofh.it>
	 <200511211919.11429.kernel@kolivas.org> <43818880.8080800@comhem.se>
	 <200511212011.48122.kernel@kolivas.org>
	 <4381A5D7.3020307@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Con Kolivas wrote:
> > On Mon, 21 Nov 2005 19:42, Daniel Marjamäki wrote:
>
> >>Hmm.. The minimum value should be 2, right?
> >>Otherwise the loop could time out after only a few nanoseconds.. since the
> >>loop will then timeout immediately on a clock tick. Or am I wrong?
> >
> >
> >       aztTimeOut =  HZ / 500 ? : 1;
> > Would give you a 2ms timeout on 1000Hz and 500Hz
> > It would give you 5ms on 250Hz and 10ms on 100Hz
> >
> > ie the absolute minimum it would be would be 2ms, but it would always be at
> > least one timer tick which is longer than 2ms at low HZ values.
> >
>
> Not true. From 'now', the next timer interrupt is somewhere
> between epsilon and 1/HZ seconds away.
>
> Luckily, time_after is < rather than <=, so your aztTimeOut would
> actually make Daniel's code wait until a minimum of *two* timer
> ticks have elapsed since reading jiffies. So it would manage to
> scrape by the values of HZ you quoted.
>
> OTOH, if HZ were between 500 and 1000, it would again be too short
> due to truncation.
>
> Better I think would be to use the proper interfaces for converting
> msecs to jiffies:
>
>    aztTimeOut = jiffies + msecs_to_jiffies(2);

That's what I get for sleeping. Yes, Nick is right, don't do this
conversion yourself, please, use the interfaces designed exactly to
avoid any confusion / HZ-issues (and if those interfaces have
limitations, as Willy discovered earlier, please fix them).

Thanks,
Nish
