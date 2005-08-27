Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751608AbVH0NKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbVH0NKw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 09:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbVH0NKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 09:10:52 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:19638 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751600AbVH0NKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 09:10:51 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Linux 2.6 context switching and posix threads performance question
Date: Sat, 27 Aug 2005 23:09:47 +1000
User-Agent: KMail/1.8.2
Cc: Mateusz Berezecki <mateuszb@gmail.com>, linux-kernel@vger.kernel.org
References: <20050827121158.GA18406@oepkgtn.mshome.net> <1125147489.7756.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1125147489.7756.10.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508272309.48320.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2005 22:58, Arjan van de Ven wrote:
> >  I'm asking for some kind of an authoritative answer
> > quite urgently. What is the optimum thread amount on 2 CPU SMP system
> > running Linux ?
>
> context switching in linux isn't THAT expensive compared to some other
> operating systems, but it's not free either.
> The optimum is obviously 2 threads, one for each cpu that processes your
> network service in a state machine like way. This is why thttpd beats
> apache by 10x if not more.

On a current model processor (P4 3Ghz) the current 2.6 kernel can do about 
700,000 context switches per second with processes if they do nothing but 
switch, and perhaps slightly faster with threads. Each context switch, 
therefore, is quite cheap to perform. However you're unlikely to perform more 
than 10,000 context switches per second with real workloads and the switch 
itself contributes a measurable, but not performance limiting, impact. The 
more cpu bound your threads are the less context switches you'll perform. 
Fork is quite a bit more expensive. I don't have current figures on fork, but 
if you only fork once it shouldn't be a problem.

Cheers,
Con
