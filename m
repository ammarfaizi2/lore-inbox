Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267699AbTBYG2Z>; Tue, 25 Feb 2003 01:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267708AbTBYG2Z>; Tue, 25 Feb 2003 01:28:25 -0500
Received: from holomorphy.com ([66.224.33.161]:52660 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267699AbTBYG2Y>;
	Tue, 25 Feb 2003 01:28:24 -0500
Date: Mon, 24 Feb 2003 22:37:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WARN_ON noise in 2.5.63's kernel/sched.c:context_switch
Message-ID: <20030225063739.GY10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
References: <buoadgkuatx.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buoadgkuatx.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 03:35:22PM +0900, Miles Bader wrote:
> I'm getting a bunch of stack dumps from the WARN_ON newly added to 
> kernel/sched.c:context_switch:
> 	if (unlikely(!prev->mm)) {
> 		prev->active_mm = NULL;
> 		WARN_ON(rq->prev_mm);
> 		rq->prev_mm = oldmm;
> 	}
> The thing is, I'm hacking on uClinux, so I don't have an MMU, and the mm
> stuff is purely noise.  What's the best way to squash this warning?
> [Of course I'd like to just trash all the MM manipulation -- for me,
> `context_switch' should really _just_ do `switch_to' -- but I'd settle
> for just not having stack dumps litter my console output...]

This means there's some kind of trouble happening, i.e. the rq->prev_mm
pointer is not NULL when it should be.

Tracking down the root cause would better serve you.


-- wli
