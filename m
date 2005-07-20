Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVGTOa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVGTOa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVGTOa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:30:26 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:328 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261234AbVGTOaX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:30:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p6NUu5HFTT4Yi9f+TSZJthshe7d18gmYa34pVOuPrjF86eyeRSeUhBax8qeZ4BQO6wazsemntFIeEwCURXKmE9TkBZ51okPqo0HEHUpbRORW1WwOLudyDqNvfdXUSGEOrIcJ6Lduu0Y9nhjjmG13pknJ3H96l+clrkCqcJHauxo=
Message-ID: <161717d505072007293830074a@mail.gmail.com>
Date: Wed, 20 Jul 2005 10:29:52 -0400
From: Dave Neuer <mr.fred.smoothie@gmail.com>
Reply-To: mr.fred.smoothie@pobox.com
To: Simon Strandman <simon.strandman@telia.com>
Subject: Re: Noob question. Why is the for-pentium4 kernel built with -march=i686 ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42DE3890.2040501@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1121792852.11857.6.camel@home.yosifov.net>
	 <1121852642.18129.39.camel@localhost>
	 <1121851507.10454.3.camel@home.yosifov.net>
	 <200507201338.08179.vda@ilport.com.ua> <42DE3890.2040501@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/05, Simon Strandman <simon.strandman@telia.com> wrote:
> Denis Vlasenko skrev:
> 
> >
> >Why do you care? I bet that differences between i686 code and pentium4 code
> >are well below noise level.
> >--
> >vda
> >
> For x86_64 the flags -mno-sse -mno-mmx -mno-sse2 -mno-3dnow are always
> used for compilation. Why is'nt the same thing done for x86 instead of
> using -march=i686 -mtune=?.
> 
> -march=athlon and -march=k6 includes -m3dnow and -mmmx, are those ok for
> the kernel but -msse isn't?
> 

As Kerin pointed out, gcc 4.0 supports auto-vectorization, so in
theory, these options might provide better performance on some
compilers. Apparently SSE is not enabled by default any more for P4
because of a known bug w/ some compilers. People using gcc > 4.0 can
obviously override it.

Really, w/out the presence of auto-vectorization support in the
compiler none of the vector extensions are necessary. The only things
that really matter are -mcpu and -mtune: what instruction set your CPU
supports and the optimum instruction scheduling characteristics for
your CPU, respectively.

Dave
