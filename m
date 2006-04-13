Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWDMVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWDMVSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWDMVSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:18:47 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:37029 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964976AbWDMVSq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:18:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q7Nes0hL6fKYaU8vy/QVLEkpaAZIzz/v0V6FWYUllV04Eb79yM35PMVzNvdDlR1foefMT5fUug8CkAOyzmpjFn+orSZahcE+ceW6Zs1ZG6ux0aocfurnEscpqqu5rl3tEW6ynOUu1HaGHckqFN+ACqkQLK4X+GYr90j4HgWO3UA=
Message-ID: <29495f1d0604131418q42e00093ma72d27fbabd33cc9@mail.gmail.com>
Date: Thu, 13 Apr 2006 14:18:45 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: select takes too much time
Cc: "Ram Gupta" <ram.gupta5@gmail.com>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "linux mailing-list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0604131701030.7732@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
	 <443E9A17.4070805@stud.feec.vutbr.cz>
	 <728201270604131251h5296dd41o7d0e0dd8f2f1ac63@mail.gmail.com>
	 <Pine.LNX.4.61.0604131701030.7732@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/06, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Thu, 13 Apr 2006, Ram Gupta wrote:
>
> > On 4/13/06, Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
> >> Ram Gupta wrote:
> >>> I am using 2.5.45 kernel but I believe the same would  be the true
> >>> for the latest kernel too.
> >>
> >> Are you just assuming this, or did you actually try a recent kernel?
> >>
> >> Michal
> >>
> >
> > I didn't get a chance to try it on a recent kernel yet but I believe
> > it to be so though I may be  wrong
> >
> > Ram
> > -
>
> Simple program here shows that you may be right! In principle,
> I should be able to multiply the loop-count by 10 and divide
> the sleep time by 10, still resulting in 1-second total time
> through the loop. Not so! Changing the value, marked "Change this" to
> a smaller value doesn't affect the time very much. It is as though
> the sleep time is always at least 1000 microseconds. If this is
> correct, then there should be some kind of warning that the time
> can't be less than the HZ value, or whatever is limiting it.

Doesn't sys_select() just use schedule_timeout() eventually? <checks>
yes, sys_select() -> core_sys_select() -> do_select() ->
schedule_timeout(). Presuming there is any value stored in the timeout
parameter, you're going to sleep at least a jiffy which is 1/HZ. If
HZ=1000 (or 1024), I'd guess that 1000 us as a minimum would be
expected.

Thanks,
Nish
