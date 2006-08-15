Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWHOSIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWHOSIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWHOSIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:08:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030430AbWHOSHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:07:50 -0400
Date: Tue, 15 Aug 2006 11:07:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: Peter M <peter.mdk@gmail.com>, linux-kernel@vger.kernel.org,
       Francois Romieu <romieu@fr.zoreil.com>, ansla80@yahoo.com
Subject: Re: Oops in 2.6.17.7 running multiple eth bridges [r8169?]
Message-ID: <20060815110743.593047a4@dxpl.pdx.osdl.net>
In-Reply-To: <44E1A93E.8020701@gentoo.org>
References: <31296a430608101034v2ecfbf8an66510427da49af4d@mail.gmail.com>
	<44E1A93E.8020701@gentoo.org>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 12:00:14 +0100
Daniel Drake <dsd@gentoo.org> wrote:

> Peter M wrote:
> > I have built a multi bridge i386 machine with 8 eth devices which
> > keeps crashing on me.
> > 
> > Kernel 2.6.7.17
> > Below crash came when I unplugged a cable on a running bridge. Today I
> > have had two crashes without touching the cables but didn't get any
> > usable syslog.
> 
> There is a similar report of this on the Gentoo bugzilla:
> 
> http://bugs.gentoo.org/143867
> 
> However the situation is somewhat different: this is a 3ghz system with 
> 896mb RAM. Only one network interface, no bridging in use. The failure 
> occurred while the network switch was being restarted (presumably all 
> the buffers filled up during the "downtime"). It seems to me that such a 
> system should be able to cope.
> 
> The page allocation failure seems to stem from r8169, however the system 
> was obviously running low on memory at this point (it was under load), 
> so I'm not sure how well we can avoid this. It is not reproducible either.

If you are using jumbo frames, then most Ethernet driver's are more prone
to allocation failure because they can't get contiguous memory. Some drivers
are being changed to do fragmented receive, but the support is sketchy at this
point.
