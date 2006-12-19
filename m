Return-Path: <linux-kernel-owner+w=401wt.eu-S932923AbWLSTsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923AbWLSTsy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932920AbWLSTsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:48:54 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:48297 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923AbWLSTsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:48:53 -0500
X-Originating-Ip: 24.163.66.209
Date: Tue, 19 Dec 2006 14:44:36 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: David Rientjes <rientjes@cs.washington.edu>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Get rid of most of the remaining k*alloc() casts.
In-Reply-To: <Pine.LNX.4.64N.0612191116170.19395@attu4.cs.washington.edu>
Message-ID: <Pine.LNX.4.64.0612191436340.11231@localhost.localdomain>
References: <Pine.LNX.4.64.0612190627020.22485@localhost.localdomain>
 <Pine.LNX.4.64N.0612191116170.19395@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=2.008, required 5, ALL_TRUSTED -1.80, BAYES_20 -0.74,
	RCVD_IN_NJABL_DUL 1.95, RCVD_IN_SORBS_DUL 2.05,
	SARE_SUB_GETRID 0.56)
X-Net-Direct-Inc-MailScanner-SpamScore: ss
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006, David Rientjes wrote:

> On Tue, 19 Dec 2006, Robert P. J. Day wrote:
>
> > diff --git a/include/asm-um/thread_info.h b/include/asm-um/thread_info.h
> > index 261e2f4..e43c2dd 100644
> > --- a/include/asm-um/thread_info.h
> > +++ b/include/asm-um/thread_info.h
> > @@ -51,8 +51,7 @@ static inline struct thread_info *current_thread_info(void)
> >  }
> >
> >  /* thread information allocation */
> > -#define alloc_thread_info(tsk) \
> > -	((struct thread_info *) kmalloc(THREAD_SIZE, GFP_KERNEL))
> > +#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL))
> >  #define free_thread_info(ti) kfree(ti)
> >
> >  #endif
>
> This patch breaks all of usermode from the change above.

whoops, you're right, i didn't notice that.  duh.  i can resubmit that
patch with that part whacked out, or someone higher up the food chain
can do that.  either way works for me.  sorry about that.

> There's also no reason to avoid other cleanups in the area you're
> changing (and testing) such as moving the asterisk for pointers to
> the variable name, deleting extraneous whitespace, or changing the
> several instances in this patch where kzalloc conversion is
> appropriate.  If it's not done now, it will either be forgotten or
> another patch on the same elaborate scale as this one will need to
> fix it incrementally.  Given the high chance of typos such as the
> one above in broad patches like this, all the changes should be
> rolled together into one patch that is at least inspected before
> submission by the author.

that sounds reasonable but, as i've mentioned before, many of the
sizable cleanups i've submitted are produced by a simple script, which
is written to process *one* kind of cleanup.  if i tried to fix
everything else in the same area at the same time, *that* would
involve far more manual labour, not to mention that the patch would be
less well-defined, and the probability of a fatal typo would actually
increase.

it's also possible that the stuff that isn't getting fixed in *this*
cleanup will be done in a future submission.  like i said, it's a
tradeoff.  i'm certainly open to suggestions but there's not much
chance that, when i attack one issue, i'm then going to manually
inspect every line that was changed to see what *else* could be done
at the same time.

life's just too short for that.

rday
