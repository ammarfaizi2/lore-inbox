Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVC0Rkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVC0Rkf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 12:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVC0Rkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 12:40:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13719 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261220AbVC0Rk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 12:40:28 -0500
Date: Sun, 27 Mar 2005 12:40:26 -0500
From: Dave Jones <davej@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
Message-ID: <20050327174026.GA708@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost> <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com> <1111825958.6293.28.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com> <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost> <1111881955.957.11.camel@mindpipe> <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost> <20050327065655.6474d5d6.pj@engr.sgi.com> <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 05:12:58PM +0200, Jan Engelhardt wrote:

 > Well, kfree inlined was already mentioned but forgotten again.
 > What if this was used:
 > 
 > inline static void kfree_WRAP(void *addr) {
 >     if(likely(addr != NULL)) {
 >         kfree_real(addr);
 >     }
 >     return;
 > }
 > 
 > And remove the NULL-test in kfree_real()? Then we would have:

Am I the only person who is completely fascinated by the
effort being spent here micro-optimising something thats
almost never in a path that needs optimising ?
I'd be amazed if any of this masturbation showed the tiniest
blip on a real workload, or even on a benchmark other than
one crafted specifically to test kfree in a loop.

That each occurance of this 'optimisation' also saves a handful
of bytes in generated code is it's only real benefit afaics.
Even then, if a functions cache performance is better off because
we trimmed a few bytes from the tail of a function, I'd be
completely amazed.

I guess April 1st came early this year.

		Dave

