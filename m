Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272506AbRH3VtR>; Thu, 30 Aug 2001 17:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272498AbRH3VtC>; Thu, 30 Aug 2001 17:49:02 -0400
Received: from t2.redhat.com ([199.183.24.243]:3319 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272505AbRH3VsC>; Thu, 30 Aug 2001 17:48:02 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200108302132.f7ULWt221345@oboe.it.uc3m.es> 
In-Reply-To: <200108302132.f7ULWt221345@oboe.it.uc3m.es> 
To: ptb@it.uc3m.es
Cc: "Herbert Rosmanith" <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org, dhowells@cambridge.redhat.com
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 30 Aug 2001 22:47:49 +0100
Message-ID: <11528.999208069@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ptb@it.uc3m.es said:
> Now I think of it, I suppose
>     unsafe_min_or_max_at_line_##__LINE__()
> will definitely evoke a meaningful link error.

Unfortunately, there's no guarantee that it won't emit a reference to that 
symbol even if the test for mismatching arguments can be proved at compile 
time to always evaluate to false.

Code which relies on "if(0) __call_nonexistent_function();" actually compiling 
is just broken.

You'd have thought we'd have learned by now to stop relying on the observed 
current behaviour of gcc and start trying to get it right, wouldn't you?

The answer in this case is that gcc can't safely do what we require for this
and for other compile-time checks, until something like David's
__builtin_ct_assertion() is added.

--
dwmw2


