Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVBBATn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVBBATn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 19:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVBBATn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 19:19:43 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:54171 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262191AbVBBATj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 19:19:39 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4200166A.6050309@am.sony.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <41FFFD4F.9050900@am.sony.com>
	 <1107298089.2040.184.camel@cog.beaverton.ibm.com>
	 <4200166A.6050309@am.sony.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 16:19:08 -0800
Message-Id: <1107303548.2040.204.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 15:53 -0800, Tim Bird wrote:
> john stultz wrote:
> > I believe you're right. Although we don't call read_persistent_clock()
> > very frequently, nor do we call it in ways we don't already call
> > get_cmos_time(). So I'm not sure exactly what the concern is.
> 
> Sorry - I should have given more context.  I am worried about
> suspend and resume times.  An extra (up-to-a) second delay on
> suspend it pretty painful for CE devices.  (See my SIG for
> my other hat in the forum.)

Ok, Nigel clarified it pretty well. Thanks. 

> >
> > Since we call read_persistent_clock(), it should return right as the
> > second changes, thus we will be marking the new second as closely as
> > possible with the timesource value. If the order was reversed, I think
> > it would be a concern.
> >
> 
> It sounds like for your code, this synchronization is a valuable.

Well, it just affects how much time error we gain on suspend/resume. We
can't be perfect (well, unless our active timesource is persistent
clock), and the comment points that we're just trying to minimize the
error. 

> For many CE products, the synchronization is not needed.  I have a
> patch that removes the synchronization for i386 and ppc, but
> I haven't submitted it because I didn't want to mess up
> non-boot-context callers of get_cmos_time which have valid
> synchronization needs.

Interesting patch. Indeed, the trade off is just how quickly you want to
boot vs how much drift you gain each suspend/resume cycle. Assuming all
of the clocks are good, your patch could introduce up to 2 seconds of
drift each suspend/resume cycle. 

> As you can see below, the patch is pretty braindead.
> I was wondering if this conflicted with your new timer system or
> not.

Not really. The issue is present with or without my code.

thanks
-john

