Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUJRVrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUJRVrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUJRVrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:47:39 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:53211 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267385AbUJRVrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:47:37 -0400
Subject: Re: [PATCH] add unschedule_delayed_work to the workqueue API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <20041018144354.2118138f.akpm@osdl.org>
References: <1098117067.2011.64.camel@mulgrave>
	<20041018142524.5b81a09a.akpm@osdl.org>
	<1098134824.2011.322.camel@mulgrave> <1098134994.2792.325.camel@mulgrave> 
	<20041018144354.2118138f.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Oct 2004 16:47:22 -0500
Message-Id: <1098136049.2792.329.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 16:43, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > On Mon, 2004-10-18 at 16:26, James Bottomley wrote:
> > > On Mon, 2004-10-18 at 16:25, Andrew Morton wrote:
> > > > The usual way of doing this is:
> > > > 
> > > > 	cancel_delayed_work(...);
> > 
> > OK, found it in the headers, sorry .. it's not synchronous, so it can't
> > really be used in most of the cases where we use del_timer_sync().
> 
> cancel_delayed_work() will tell you whether it successfully cancelled the
> timer.  If it didn't, you should run flush_workqueue() to wait on the final
> handler.  The combination of the two is synchronous.

Right, but it potentially does too much work for my purposes.  I want to
cancel the work if it's cancellable or wait for it if it's already
executing.  I don't want to have to wait for all the work in the queue
just because the timer fired and it got added to the workqueue schedule.

> The missing link is cancellation of a delayed work which re-adds itself and
> where the calling code has no way of telling the handler to not re-arm
> itself.  There's a patch in -mm to add that function, but I don't like it.
> That's cancel_rearming_delayed_work.patch.

James


