Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWCUJGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWCUJGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWCUJGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:06:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24758 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751123AbWCUJGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:06:34 -0500
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is
	default
From: Arjan van de Ven <arjan@infradead.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
In-Reply-To: <20060321085352.GA17642@rhlx01.fht-esslingen.de>
References: <20060320122449.GA29718@outpost.ds9a.nl>
	 <1142901656.441f4b98472e5@vds.kolivas.org>
	 <87acbk33la.fsf@duaron.myhome.or.jp>
	 <200603211409.50331.kernel@kolivas.org>
	 <20060321085352.GA17642@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 10:06:27 +0100
Message-Id: <1142931987.3077.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 09:53 +0100, Andreas Mohr wrote:
> Hi,
> 
> On Tue, Mar 21, 2006 at 02:09:50PM +1100, Con Kolivas wrote:
> > On Tue, 21 Mar 2006 01:59 pm, OGAWA Hirofumi wrote:
> > > Yes. However, if machines uses buggy chip, I guessed TSC/PIT would be
> > > more proper as time source. 
> > 
> > Oh yes but there has been an epidemic of timer problems (fast/slow, lost ticks 
> > etc) lately meaning the pm timer is being relied upon more and more.
> 
> I think it's reasonable to question whether to use unlikely or not,
> but IMHO omitting unlikely here will not reward well-behaving systems and
> not punish buggy systems, and this doesn't seem quite right from an
> evolutionary point of view 

rdtsc is not reliable for any SMP system or any system doing frequency
scaling or C3 state power saving states.

(exception is newest generation processors where that appears to be
changing now)


You can say "but it appears to work on my SMP system".. but are they
still synced after 200 days of uptime? or are they skewed by then by too
much. 

