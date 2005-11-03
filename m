Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbVKCERP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVKCERP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbVKCERP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:17:15 -0500
Received: from sneakemail.com ([38.113.6.61]:64698 "HELO monkey.sneakemail.com")
	by vger.kernel.org with SMTP id S1030299AbVKCERO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:17:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lWlGdmL052q4Tk2rtZl3ImlfGYUzf9074nynSvpqPRG7HLc5OZkQbTyV9+WmYSY+AsmqtkB4/X3ZOKaM1Hwy8eI7bMKc/XJucPg9LNCZ20jaS665GwsZMXKr4+suWW2ZNlawFJGfkYBXlgkbpNQpFjg3A9bvzzueEyc82JeNFOo=
Message-ID: <20172-97280@sneakemail.com>
Date: Wed, 2 Nov 2005 20:17:10 -0800
From: "NooneImportant" <nxhxzi702@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/37] dvb: let other frontends support FE_DISHNETWORK_SEND_LEGACY_CMD
In-Reply-To: <20051103135210.21cdcf77.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436723DB.2000300@m1k.net> <20051103135210.21cdcf77.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, Andrew Morton wrote:
> Michael Krufky <mkrufky@m1k.net> wrote:
> >
> > +s32 timeval_usec_diff(struct timeval lasttime, struct timeval curtime)
> >  +{
> >  +    return ((curtime.tv_usec < lasttime.tv_usec) ?
> >  +            1000000 - lasttime.tv_usec + curtime.tv_usec :
> >  +            curtime.tv_usec - lasttime.tv_usec);
> >  +}
> >  +EXPORT_SYMBOL(timeval_usec_diff);
> >  +
> >  +static inline void timeval_usec_add(struct timeval *curtime, u32 add_usec)
> >  +{
> >  +    curtime->tv_usec += add_usec;
> >  +    if (curtime->tv_usec >= 1000000) {
> >  +            curtime->tv_usec -= 1000000;
> >  +            curtime->tv_sec++;
> >  +    }
> >  +}
>
> timeval arithmetic like this really shouldn't be hidden in a dvb driver -
> it's generic code.
> However I don't believe that the driver should be using timevals and
> do_gettimeofday() at all.  Why not use jiffies-based timing like so
> many other parts of the kernel?
>
To be honest, I don't like this solution very much either.  It only
works when HZ is ~1000, and even then isn't reliable for everyone who
uses this code.  All this is attempting to be is a high precision 8ms
timer.  Accuracy needs to be +/- 500us for the code to work.  I am not
a (very good) kernel programmer, and didn't find anything that would
really fit the bill when trying to figure out how to ensure a routine
gets called every 8ms (9 times).  The ktimers stuff I saw recently on
lwn would seem to work well here, but if there is a way to do it with
what is in the kernel today, I'm just not aware of how to do it.  So
if someone will show me the right way (or point me in the irght
direction even), I'll be happy to rework the patch.

Thanks,
Noone
