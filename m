Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSJ2GKf>; Tue, 29 Oct 2002 01:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbSJ2GKf>; Tue, 29 Oct 2002 01:10:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20208 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261615AbSJ2GKe>;
	Tue, 29 Oct 2002 01:10:34 -0500
Message-ID: <3DBE27BB.E1A99E6@mvista.com>
Date: Mon, 28 Oct 2002 22:16:27 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: "landley@trommello.org" <landley@trommello.org>,
       Jim Houston <jim.houston@ccur.com>, "ak@suse.de" <ak@suse.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 7
References: <3DB9A311.9B0D832D@mvista.com> <1035849209.1157.242.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> 
> This patch does not apply cleanly against 2.5.44.
> 
>   ------------------------------------------------------------
>                   Name: timer.c.rej
>    timer.c.rej    Type: application/x-reject
>               Encoding: base64

I suspect that you did not apply the posix patch first.  Did
you see:
"This patch depends on the
POSIX clocks & timers patch in that it assumes the changes
that patch made to timer.c to remove timer_t.  This
dependency can be removed if needed."

in the referenced posting?  

The POSIX patch needed to remove timer_t as it is the type
the standard uses for a timer id where as timer.c was/is
using it to refer to a timer_struct.  I had to choose an
application order (or make yet another patch that would need
to preceed application of either of them :(.

I choose this order, but it can be changed if that is what
is desired.  My choice was made because I think the POSIX
clocks & timers API is more important than high-res.  It is
usable without high-res, however, high-res is of little use
with out the POSIX API patch.

If you did apply the posix patch prior to this one and still
have this failure, please do let me know.


-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
