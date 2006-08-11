Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWHKOHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWHKOHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 10:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWHKOHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 10:07:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:21964 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751132AbWHKOHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 10:07:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RPyhoch0uubJS3zGJ+GRZsz1r4Xshll6+rYqd06vrvIaRW+4qzzkGIUFhKGZneaqSptaZ+ZU8KnLEgGHiOJKeZOXbyOHqqwWwMNz5PRUclwAJttyChvch1Jnvb2djaYJLcnym+CixTkzan3KMZ+2jfuB2x2xcg1BuHMgfQkDMa8=
Message-ID: <d120d5000608110707o2b758739x20033b000449113f@mail.gmail.com>
Date: Fri, 11 Aug 2006 10:07:28 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Michael Hanselmann" <linux-kernel@hansmi.ch>
Subject: Re: [patch 5/6] Convert to use mutexes instead of semaphores
Cc: "Richard Purdie" <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@pol.net>
In-Reply-To: <20060811134215.GA26017@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060811050310.958962036.dtor@insightbb.com>
	 <20060811050611.530817371.dtor@insightbb.com>
	 <d120d5000608110558l3d3a5720i1781f4e90f40579b@mail.gmail.com>
	 <1155302169.19959.16.camel@localhost.localdomain>
	 <d120d5000608110634n501d33b0yb7702a24cbf064e3@mail.gmail.com>
	 <20060811134215.GA26017@hansmi.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/06, Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
> On Fri, Aug 11, 2006 at 09:34:44AM -0400, Dmitry Torokhov wrote:
> > How about we add backlight_set_power(&bd, power) to the backlight core
> > to take care of proper locking for drivers?
>
> I've tried to add several functions to the backlight core
> ({s,g}et_{brightness,power}) and they were rejected. Thus all the
> locking is spread over the drivers. I agree it's faulty right now.
> It's still easier to move to backlight core functions than to fix all
> the drivers.
>
> Because I am responsible/wrote for the broken code, how should I
> proceed?
>

Well, I was reading some more of the drivers and I am also not sure if
such methods are needed in backlight core. Let's take atyfb_base.c -
it tries to manipulate backlight's power from atyfb_blank. But it is
normally called from fb_blank() which is then calls
fb_notifier_call_chain(FB_EVENT_BLANK, &event);
So on the end backlight device will get that event and will turn off
power anyway. Now, atyfb_blank is also called suring suspend/resume so
we probably should just add handling of FB_EVENT_SUSPEND and
FB_EVENT_RESUME to the backlight core.

Richard?

-- 
Dmitry
