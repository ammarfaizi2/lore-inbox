Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVC1GHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVC1GHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 01:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVC1GHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 01:07:18 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37088 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261194AbVC1GHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 01:07:10 -0500
Message-Id: <200503280120.j2S1KE2j009816@laptop11.inf.utfsm.cl>
To: Dave Jones <davej@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/ 
In-Reply-To: Message from Dave Jones <davej@redhat.com> 
   of "Sun, 27 Mar 2005 12:40:26 EST." <20050327174026.GA708@redhat.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 27 Mar 2005 21:20:14 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> said:
> On Sun, Mar 27, 2005 at 05:12:58PM +0200, Jan Engelhardt wrote:
> 
>  > Well, kfree inlined was already mentioned but forgotten again.
>  > What if this was used:
>  > 
>  > inline static void kfree_WRAP(void *addr) {
>  >     if(likely(addr != NULL)) {
>  >         kfree_real(addr);
>  >     }
>  >     return;
>  > }
>  > 
>  > And remove the NULL-test in kfree_real()? Then we would have:

> Am I the only person who is completely fascinated by the
> effort being spent here micro-optimising something thats
> almost never in a path that needs optimising ?
> I'd be amazed if any of this masturbation showed the tiniest
> blip on a real workload, or even on a benchmark other than
> one crafted specifically to test kfree in a loop.

Right.

> That each occurance of this 'optimisation' also saves a handful
> of bytes in generated code is it's only real benefit afaics.

No. It clears up the calls to kfree() a bit too in the source. Not really
important, sure.
.
> Even then, if a functions cache performance is better off because
> we trimmed a few bytes from the tail of a function, I'd be
> completely amazed.
> 
> I guess April 1st came early this year.

Got (at) you! ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
