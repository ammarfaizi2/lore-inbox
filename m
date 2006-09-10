Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWIJKaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWIJKaM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 06:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWIJKaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 06:30:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61656 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750717AbWIJKaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 06:30:10 -0400
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Laurent Riffard <laurent.riffard@free.fr>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
In-Reply-To: <200609101032.17429.ak@suse.de>
References: <20060908011317.6cb0495a.akpm@osdl.org>
	 <4503DC64.9070007@free.fr>  <200609101032.17429.ak@suse.de>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Sun, 10 Sep 2006 12:29:57 +0200
Message-Id: <1157884197.17849.125.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 10:32 +0200, Andi Kleen wrote:
> On Sunday 10 September 2006 11:35, Laurent Riffard wrote:
> > Le 08.09.2006 10:13, Andrew Morton a écrit :
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/
> > >2.6.18-rc6-mm1/
> >
> > Hello,
> >
> > This kernel won't boot here: it starts a GPFs loop on
> > early boot. I attached a screenshot of the first GPF
> > (pause_on_oops=120 helped).
> 
> 
> It's lockdep's fault. This patch should fix it:
> 
> In general from my experience lockdep seems to be a dependency nightmare.
> It uses far too much infrastructure far too early. Should we always disable
> lockdep very early (before interrupts are turned on) instead? (early 
> everything is single threaded and will never have problems with lock 
> ordering)

lockdep starts somewhere in the middle; I doubt it's the only thing that
assumes that current is valid at that point.
>  /*
> - * Remove the lock to the list of currently held locks in a
> + * Remove the lock to the list of early_current()ly held locks in a
>   * potentially non-nested (out of order) manner. This is a
>   * relatively rare operation, as all the unlock APIs default
>   * to nested mode (which uses lock_release()):
> @@ -2227,7 +2231,7 @@ lock_release_non_nested(struct task_stru
>  	int i;
>  
>  	/*
> -	 * Check whether the lock exists in the current stack
> +	 * Check whether the lock exists in the early_current() stack
>  	 * of held locks:
>  	 */

??


