Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWCUDJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWCUDJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 22:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWCUDJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 22:09:28 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:14556 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751463AbWCUDJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 22:09:27 -0500
From: Con Kolivas <kernel@kolivas.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
Date: Tue, 21 Mar 2006 14:09:50 +1100
User-Agent: KMail/1.8.3
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
References: <20060320122449.GA29718@outpost.ds9a.nl> <1142901656.441f4b98472e5@vds.kolivas.org> <87acbk33la.fsf@duaron.myhome.or.jp>
In-Reply-To: <87acbk33la.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603211409.50331.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006 01:59 pm, OGAWA Hirofumi wrote:
> Yes. However, if machines uses buggy chip, I guessed TSC/PIT would be
> more proper as time source. 

Oh yes but there has been an epidemic of timer problems (fast/slow, lost ticks 
etc) lately meaning the pm timer is being relied upon more and more.

> But probably you are right, timer_pit.c 
> seems more slow usually (it uses many I/O port).
>
> I'll remove unlikely(), and also will remove "Use other timer source"
> from warning.

Suggesting another timer source is ok in the warning I believe given massive 
amounts of wasted cpu.

> BTW, this patch is still quick hack.

Understood. Perhaps having an indirect function call set to either 
good_pmtmr() or bad_pmtmr() after checking would be preferable to a variable 
that is checked on each function call despite never changing.

> At least, we would need to check the ICH4 which says in comment.
> However, I couldn't find the PM-Timer Errata in ICH4 spec update.
>
> Do you/anyone know about a ICH4 error?

Not personally but my ICH4 pm timer seems to work very well whereas Andi's 
apparently similar chipset exhibits terrible problems.

Cheers,
Con
