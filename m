Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWHAEMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWHAEMf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWHAEMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:12:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:22147 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932288AbWHAEMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:12:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=poGBAOqebrc7BSOatGU0w4EfGexMaOIq49sJF1dmSD9gCZ/CXav5Vh5kJfJefce/mJ9DKzmyF2ctIdndy+hDMbbleiDUM4dJI8P6x+j3v3XxyeMUqJilqopK+pQzfM4tYpzBRED/ZH6L01ncd7AadaJXWUoUaUsqxICTPycxs6I=
Date: Tue, 1 Aug 2006 08:12:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jay Lan <jlan@engr.sgi.com>
Subject: Re: [PATCH] task_struct: remove writeonly counters
Message-ID: <20060801041225.GE7006@martell.zuzino.mipt.ru>
References: <20060801022951.GB7006@martell.zuzino.mipt.ru> <20060731210107.89cab506.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731210107.89cab506.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 09:01:07PM -0700, Andrew Morton wrote:
> On Tue, 1 Aug 2006 06:29:51 +0400
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > ...
> >
> > +++ b/include/linux/sched.h
> > @@ -962,8 +962,6 @@ #endif
> >   * to a stack based synchronous wait) if its doing sync IO.
> >   */
> >  	wait_queue_t *io_wait;
> > -/* i/o counters(bytes read/written, #syscalls */
> > -	u64 rchar, wchar, syscr, syscw;
> 
> This is kinda funny.  These fields were added a year and a half ago, with
> the intention that the info be made available to userspace.  But then
> things got horridly stuck.  It's only in the past couple of weeks that we've
> gained appropriate reporting-to-userspace infrastructure to be able to use
> these fields.
> 
> And lo, on the very day when you propose removing these fields, Jay posts a
> new patchset ("add CSA accounting to taskstats") which finally gets around to
> using them.

[checks archives]
*cough* That was a coincidence, I assure you.

> So..  we should keep these fields for now - we can perhaps remove them (in
> less than 1.5 years) if for some reason the CSA patches crash and burn (I
> don't think they will).

Perhaps, Jay can properly ifdef them with CONFIG_CSA_ACCT or something?
And remove in-file changelogs 'cause there is git?

