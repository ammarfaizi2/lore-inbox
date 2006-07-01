Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWGAB07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWGAB07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 21:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbWGAB07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 21:26:59 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:11133 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932637AbWGAB06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 21:26:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=rGDh2uibC1A/yFlOziTQ90klaTNlmem1MDCt6St0uiu3s9QXKUZEM+Y14t8Q2/9AK+wpNk2HV1fqtdj0ActTsVXuR90ca/pokQ8RmEWp1UFuM92lBQXUKv6tvcuopHzP1w6rL736cNHG5uMZQRkyze7i6zBiXWAHsSQ32SNtBLU=  ;
Message-ID: <20060701012658.14951.qmail@web31803.mail.mud.yahoo.com>
Date: Fri, 30 Jun 2006 18:26:58 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060630181915.638166c2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> Luben Tuikov <ltuikov@yahoo.com> wrote:
> >
> > It is 4 byte aligned anyway.
> 
> That's a 64-bitism.  And 32-bit machines are more space-sensitive.

I see.
 
> >  This way we can use
> > up to 19+1 chars.
> > 
> > Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> > ---
> >  include/linux/sched.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 18f12cb..3fc11bc 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -154,7 +154,7 @@ #define set_current_state(state_value)		
> >  	set_mb(current->state, (state_value))
> >  
> >  /* Task command name length */
> > -#define TASK_COMM_LEN 16
> > +#define TASK_COMM_LEN 20
> 
> So this is basically "increase size of comm[] by 4 bytes, happens to be
> zero-cost on 64-bit machines".

Yes.

> We do occasionally hit task_struct.comm[] truncation, when people use
> "too-long-a-name%d" for their kernel thread names.  But we seem to manage.

It would be especially helpful if you want to name a task thread
the NAA IEEE Registered name format (16 chars, globally unique), for things
like FC, SAS, etc.  This way you can identify the task thread with
the device bearing the NAA IEEE name.

Currently just last character is cut off, since TASK_COMM_LEN is 15+1.

I think incrementing it would be a good thing, plus other things
may want to represent 8 bytes as a character array to be the name
of a task thread.

    Luben
 
