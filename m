Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWBZSMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWBZSMW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWBZSMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:12:22 -0500
Received: from natsluvver.rzone.de ([81.169.145.176]:3308 "EHLO
	natsluvver.rzone.de") by vger.kernel.org with ESMTP
	id S1751380AbWBZSMV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:12:21 -0500
From: Wolfgang Hoffmann <woho@woho.de>
Reply-To: woho@woho.de
To: pomac@vapor.com
Subject: Re: [PATCH] Revert sky2 to 0.13a
Date: Sun, 26 Feb 2006 19:13:36 +0100
User-Agent: KMail/1.8
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4400FC28.1060705@gmx.net> <200602260957.04305.woho@woho.de> <1140966011.22812.2.camel@localhost>
In-Reply-To: <1140966011.22812.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602261913.36308.woho@woho.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 February 2006 16:00, Ian Kumlien wrote:
> On Sun, 2006-02-26 at 09:57 +0100, Wolfgang Hoffmann wrote:
> > Stephen, if you want me (as suggested off-list) to bisect the individual
> > patches leading from 0.13a to current head, please give me a series of
> > patches to incrementally apply, eighter via mail/ftp/git, and I'll test.
> > I don't want to hack the patches together myself, because results would
> > be worthless if I screw up, and given that I have no networking
> > background chances are high ...
>
> There is a git bisect for that, and a link for it somewhere =)

Ok, I did some reading and just started a git bisect. I didn't find hints on 
how to bisect if I'm only interested in changes to sky2.[ch], so I'm taking 
the full kernel tree and skip testing those bisect steps that didn't change 
sky2.[ch].

Looking at Carl-Danies 0.13a and Stephens patch against 0.15 in this thread, 
I'll patch each bisect step such that sky2_poll() has

       sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
       if (sky2_read8(hw, STAT_LEV_TIMER_CTRL) == TIM_START) {
               sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_STOP);
               sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_START);
        }

after exit_loop. Is that ok?

I'll report as soon as I have results.
