Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUJRV3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUJRV3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267535AbUJRV3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:29:08 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:57276 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267508AbUJRV1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:27:12 -0400
Subject: Re: [PATCH] add unschedule_delayed_work to the workqueue API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <20041018142524.5b81a09a.akpm@osdl.org>
References: <1098117067.2011.64.camel@mulgrave> 
	<20041018142524.5b81a09a.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Oct 2004 16:26:57 -0500
Message-Id: <1098134824.2011.322.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 16:25, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > I'm in the process of moving some of our scsi timers which do more work
> > than just a few lines of code into schedule_work() instead.  The problem
> > is that the workqueue API lacks the equivalent of del_timer_sync(). 
> 
> The usual way of doing this is:
> 
> 	cancel_delayed_work(...);

That API doesn't seem to be in the vanilla kernel ... is it mm only?

> 	flush_workqueue(...);

Yes, but the flush_workqueue() has you waiting until every piece of work
on the workqueue has completed ... that creates an unacceptable delay in
the routine that wants it either cancelled or run.

James



