Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVJNB2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVJNB2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 21:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVJNB2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 21:28:35 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:31270 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932195AbVJNB2e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 21:28:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sOzsURGXYQWnX8/05l4CPggbjDFP1BvHw7WCNmeMpQI2TBWzTyMpkE+Ak/ZJ5Ie7u1y4Pe/JzDwuy7PXd+vcGfrLytJyXEY7vjm/3D1qQMBcHxPRHNG54BbsyffLfvKA1DKg5poiSO31UIq9Ijpbcf+fy4IliJ0DIPrXuv7ZaXw=
Message-ID: <9a8748490510131828l6440994lf9587df44f7c0d78@mail.gmail.com>
Date: Fri, 14 Oct 2005 03:28:32 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Fwd: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Cc: LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051014001547.GA4647@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510060803.21470.mgross@linux.intel.com>
	 <200510121636.29821.mgross@linux.intel.com>
	 <20051013011451.GA28844@kroah.com>
	 <200510131436.06718.mgross@linux.intel.com>
	 <9a8748490510131508r49a048cau7e08d77ef1d614ad@mail.gmail.com>
	 <20051013224042.GB3266@kroah.com>
	 <9a8748490510131547s127f3167j6c9427ff3d97f878@mail.gmail.com>
	 <20051014001547.GA4647@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/05, Greg KH <greg@kroah.com> wrote:
> On Fri, Oct 14, 2005 at 12:47:21AM +0200, Jesper Juhl wrote:
> > Ick, no, that's a mess.  Stick with the original version.
> >
> >Don't call functions within a if() statement, it's harder to read.
> direct to me only?  What about everyone on the list?
>
Whoops, wrong button - sorry.  Let's copy LKML.


> > I guess you are right - it /would/ save a variable though ;)
>
> Not worth it.  Ease of maintainability, which means being able to read
> the code better, trumps a single variable on a slow path.
>

Hmm, yeah, I can see the sense in that - if it's not performance
critical, better make it readable.


> > > > +     unsigned long tmp;
> > > > +     unsigned char val;
> > > > +     unsigned long flags;
> > > > +
> > > > +     sscanf(buf, "%lX", &tmp);
> > > > +     dev_dbg(d, "tmp = 0x%lX\n", tmp);
> > > > +
> > > > +     val = (unsigned char)tmp;
> > > >
> > > > You do this a lot, I'm wondering why you don't read directly into
> > > > "val" and then get rid of the "tmp" variable?
> > >
> > > Because you want to cast it.
> > >
> > Ok, I'm feeling a little dense tonight, so bear with me please, but
> > wouldn't the effect of reading into the unsigned char (and potentially
> > getting the value truncated) result in the same thing as casting it
> > later?
>
> I don't think it would be the same if you put a large value in the
> string.  Try it out and see.
>
Ok, I must admit I haven't actually tested it, perhaps I will tomorrow
after I get some sleep.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
