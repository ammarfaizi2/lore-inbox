Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161357AbWASTiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161357AbWASTiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161360AbWASTiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:38:13 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:43973 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161357AbWASTiM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:38:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PL5gFJP9MiwihcqhBgSqtohNxM/AIWqYv+9IrpGAzNdoaSzv4il8olq35xLxItIpxdmVVSwi8KwSKUrVjWYCwvvhAHcGQpTl1u70hPSiJ7uOieeMjRg+/wBaCquBTrJQjEDFfxthTxjPSlyoIV390ykmT35Um3o2PCorVEtYW9g=
Message-ID: <5c49b0ed0601191138g17411d3ene89380a13a7faee9@mail.gmail.com>
Date: Thu, 19 Jan 2006 11:38:12 -0800
From: Nate Diller <nate.diller@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Fall back io scheduler for 2.6.15?
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>
In-Reply-To: <20060116084336.GO3945@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601141113_MC3-1-B5DA-F6EC@compuserve.com>
	 <20060116084336.GO3945@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, Jens Axboe <axboe@suse.de> wrote:
> On Sat, Jan 14 2006, Chuck Ebbert wrote:
> > In-Reply-To: <20060113174914.7907bf2c.akpm@osdl.org>
> >
> > On Fri, 13 Jan 2006, Andrew Morton wrote:
> >
> > > OK.  And I assume that AS wasn't compiled, so that's why it fell back?
> >
> > As of 2.6.15 you need to use "anticipatory" instead of "as".
> >
> > Maybe this patch would help?
> >
> > Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> >
> > --- 2.6.15a.orig/block/elevator.c
> > +++ 2.6.15a/block/elevator.c
> > @@ -150,6 +150,13 @@ static void elevator_setup_default(void)
> >       if (!chosen_elevator[0])
> >               strcpy(chosen_elevator, CONFIG_DEFAULT_IOSCHED);
> >
> > +     /*
> > +      * Be backwards-compatible with previous kernels, so users
> > +      * won't get the wrong elevator.
> > +      */
> > +     if (!strcmp(chosen_elevator, "as"))
> > +             strcpy(chosen_elevator, "anticipatory");
> > +
> >       /*
> >        * If the given scheduler is not available, fall back to no-op.
> >        */
>
> We probably should apply this, since it used to be 'as'.

i agree

NATE
