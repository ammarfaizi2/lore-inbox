Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWIDXED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWIDXED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWIDXEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:04:02 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:44942 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932233AbWIDXD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:03:59 -0400
Date: Tue, 5 Sep 2006 01:03:58 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Dmitry Torokhov <dtor@insightbb.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH-mm] i8042: activate panic blink only in X
Message-ID: <20060904230358.GC1614@rhlx01.fht-esslingen.de>
References: <200609022320.36754.dtor@insightbb.com> <p738xkz65ly.fsf@verdi.suse.de> <ri9pf258l1q51kgsjs4u90sjp9581djjgs@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ri9pf258l1q51kgsjs4u90sjp9581djjgs@4ax.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 05, 2006 at 08:29:09AM +1000, Grant Coady wrote:
> If possible, kill the console blank timer too?  (dunno if you have).
> 
> Example: Oops screen on 2.4 recently I paged up to where the fault 
> started, the screen blanker kicked in while I was hand copying info 
> and wiped previous screens :(  Caused significant delay in working 
> out what the issue was (slackware-10.2 2.4.33.1 glibc nptl boo-boo).
> 
> Is it safe / easy to do on oops/panic?

It should be as easy as e.g. doing a

int system_oopsed __read_mostly = 0;

if (!system_oopsed)
    blank();

in the timer handler as opposed to painfully deregistering the whole handler
in the critical system state after an OOPS.
A funny side effect is that this way even improves system stability
after OOPS, since the blanking (which doesn't happen then)
might bomb, too ;)

Andreas Mohr
