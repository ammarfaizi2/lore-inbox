Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUDCBKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 20:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUDCBKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 20:10:49 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:51605 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261498AbUDCBKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 20:10:48 -0500
Subject: Re: [Patch 6/23] mask v2 - Replace cpumask_t with one using mask
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040402153518.706d8464.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
	 <20040401131136.792495fa.pj@sgi.com> <1080944675.9787.113.camel@arrakis>
	 <20040402153518.706d8464.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080954588.9787.152.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 02 Apr 2004 17:09:48 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-02 at 15:35, Paul Jackson wrote:
> > What do you think about this?
> 
> Check out my patch 24 of 23, sent last night, which should make
> cpumask_of_cpu() efficient for UP systems.

Yep, I was just reading through that patch.  It's an interesting
solution, but I'm not quite sure how I feel about it.  It's definitely
not the way I would have solved the problem, but it looks like it will
work fine.  My only problem with it is that it seems to preclude the
possibility of having two different sized masks in a single file.  At
least without making a .h file for each different mask, and then
including each those files in the .c file that needs the multiple
masks.  This behavior is fine for cpumasks & nodemasks, but makes it
difficult for arbitrary masks.  I don't foresee this happening a lot
(multiple different size masks excluding cpumasks and nodemasks), so it
shouldn't be a big deal.

My first impression would be to just define both MASK_ALL1 & MASK_ALL2,
and less importantly mask_of_bit1 & mask_of_bit2, in mask.h, and let
whatever is using the macros choose the appropriate one to use.  For
example, moving the cpumask_of_bit() & CPU_MASK_ALL defines into the
#ifdef CONFIG_SMP part.  This alleviates the (albeit unlikely) problem
of multiple masks.

-Matt

