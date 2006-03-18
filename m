Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWCRVuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWCRVuc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 16:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWCRVuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 16:50:32 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:27947 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751061AbWCRVub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 16:50:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h/954TqW8xvSFfoCqAYLn/cz8kOZ/KDkpS/3i4bIFWAGATdi7GxutgSYul4G7pdrtu7mnbLFLDgxZk8BIZsqODGDLz2XUwbt2gHvpgX6iITYLa+bqtW2DPBEPybXwoqjgpAE/N5z5m3+vacBCHLcDLkf+5dkrnHcJY8waso/+TQ=
Message-ID: <9a8748490603181350i1b89d2a6k6b292f0e8ee11eb5@mail.gmail.com>
Date: Sat, 18 Mar 2006 22:50:30 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       trini@kernel.crashing.org
In-Reply-To: <20060318133351.41baa992.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060318142827.419018000@localhost.localdomain>
	 <20060318142830.607556000@localhost.localdomain>
	 <20060318120728.63cbad54.akpm@osdl.org>
	 <1142712975.17279.131.camel@localhost.localdomain>
	 <20060318123102.7d8c048a.akpm@osdl.org>
	 <1142714332.17279.148.camel@localhost.localdomain>
	 <20060318130925.616d11c5.akpm@osdl.org>
	 <9a8748490603181326p12f35665y4504e77561f3c99@mail.gmail.com>
	 <20060318133351.41baa992.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/06, Andrew Morton <akpm@osdl.org> wrote:
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> >
> > > It would be strange to set an alarm for 0xffffffff seconds in the future
> >  > but yeah, unless we can point at a reason why nobody could have ever been
> >  > doing that, we should turn this into permanent, documented behaviour of
> >  > Linux 2.6 and earlier, I'm afraid.
> >  >
> >
> >  How about 0xffffffff seconds into the future being the same as 136
> >  years (unless I botched the math)... That means that if any Linux
> >  application ever did that it's still waiting for the alarm and will be
> >  for at least another century...
> >  I'd say that makes it pretty certain that noone are doing or have been
> >  doing that without spotting the problem somehow - apps with such a bug
> >  are unlikely to be in production and actually working correctly.
>
> We just don't know.  People do all sorts of things.
>
> How about this?
>
>         $ cat /etc/my-expensive-app.conf
>         #
>         # Interval polling timer.  Set this to -1 to disable
>         #
>         interval_polling_timer=-1
>
> We just don't know.
>
True, someone might be doing something like that, but consider this as well;

an app promts the user to enter a value and passes it on, expecting to
get EINVAL back if the value is wrong and has code in place to handle
that (like, say, prompt the user for a different value).

That app is not buggy, but it will not work correctly because *we* are buggy.

IMO we should cater to the correctly written app and prevent it from
breaking unexpectedly rather than continue to keep the buggy one
working.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
