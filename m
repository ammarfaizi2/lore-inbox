Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbULNEPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbULNEPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbULNEOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:14:37 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:38819 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261395AbULNEG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 23:06:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jbInBGD8cNA8BXsTyRQVo2CuhRNmNZv5LAQXPpFW4WzA5YaW4HrVFHlLCaaSuAYTIiuD+zoD3QkZxMDY7kyBiFZEEFq4/I4y896/1v4lg37epYjdIWPEfz+BoAbc9uleZm99ObVp5xOU3ek2GBqK0h/6xuX6131hTwucEa0k3Yw=
Message-ID: <29495f1d04121320061a2a5823@mail.gmail.com>
Date: Mon, 13 Dec 2004 20:06:57 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: dynamic-hz
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Hans Kristian Rosbach <hk@isphuset.no>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041213161207.GA27352@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random>
	 <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org>
	 <1102936790.17227.24.camel@linux.local>
	 <20041213112229.GS6272@elf.ucw.cz>
	 <1102942270.17225.81.camel@linux.local>
	 <Pine.GSO.4.61.0412131605180.16849@waterleaf.sonytel.be>
	 <20041213161207.GA27352@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004 17:12:07 +0100, Pavel Machek <pavel@suse.cz> wrote:
> HI!
> 
> > > I'm not sure what the above "scedule_timeout(HZ/10)" is supposed to
> > > do, but the parameter it gets in 1000hz is "100" so I assume this
> > > is because we want to wait for 100ms, and in 1000hz that equals
> > > 100 cycles. Correct?
> >
> > `schedule_timeout(HZ/x)' lets it wait for 1/x'th second.
> 
> ...small problem is that for HZ lower than x it does not wait at all
> :-(.

Ah ha! Another reason to use msleep() or msleep_interruptible() :).
Or, if you just want to give up the CPU, use schedule(); or if, giving
up the CPU for a long time, use yield() [the current semantic
interpretation of yield()].

-Nish
