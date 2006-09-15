Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWIONi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWIONi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWIONi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:38:59 -0400
Received: from twin.jikos.cz ([213.151.79.26]:42454 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751433AbWIONi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:38:58 -0400
Date: Fri, 15 Sep 2006 15:38:51 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
In-Reply-To: <d120d5000609150620p15b17debo9ace17836d788958@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609151535190.2721@twin.jikos.cz>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz> 
 <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz> 
 <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com> 
 <Pine.LNX.4.64.0609141754480.2721@twin.jikos.cz> 
 <d120d5000609140918j18d68a4dmd9d9e1e72d2fd718@mail.gmail.com> 
 <Pine.LNX.4.64.0609142037110.2721@twin.jikos.cz> 
 <d120d5000609141156h5e06eb68k87a6fe072a701dab@mail.gmail.com> 
 <1158260584.4200.3.camel@laptopd505.fenrus.org> 
 <d120d5000609141211o76432bd3l82582ef3896e3be@mail.gmail.com> 
 <1158298404.4332.18.camel@laptopd505.fenrus.org>
 <d120d5000609150620p15b17debo9ace17836d788958@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006, Dmitry Torokhov wrote:

> I understand what Ingo is saying about detecting deadlocks across the 
> pool of locks of the same class not waiting till they really clash, it 
> is really useful. I also want to make my code as independent of lockdep 
> as possible. Having a speciall marking on the locks themselves (done 
> upon creation) instead of altering call sites is the cleanest way IMHO. 
> Can we have a flag in the lock structure that would tell lockdep that it 
> is OK for the given lock to be taken several times (i.e. the locks are 
> really on the different objects)? This would still allow to detect 
> incorrect locking across different classes.

Yes, but unfortunately marking the lock as 'can-be-taken-multiple-times' 
is weaker than using the nested locking provided by lockdep.

i.e. if you mark a lock this way, it opens door for having deadlock, which 
won't be detected by lockdep. This will happen if the code, by mistake, 
really takes the _very same_ lock twice. lockdep will not be able to 
detect this, when the lock is marked in a way you propose, but is able to 
detect this when using the nested semantics.

-- 
JiKos.
