Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVEBGHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVEBGHW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 02:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVEBGHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 02:07:22 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:53422 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261786AbVEBGHR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 02:07:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EQLNB3HimmE4s9WLJDpWD3EEQ2tAgC+vXz0IQSgR4VXBbl8ssHXyivKqQOe7g1O+2tfi8/hCRqKDIS4X2GgOfCylED91XGiIzI3+1Cl9bjDyJnGpTTs4mWAgpuHerOw4F2Is4D6j0PUtHUbiK7uV9SZxL1LACNBr7NyQ3cFqf0g=
Message-ID: <29495f1d0505012307912d6b2@mail.gmail.com>
Date: Sun, 1 May 2005 23:07:16 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Olivier Croquette <ocroquette@free.fr>
Subject: Re: setitimer timer expires too early
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4273A51E.6080503@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42726DDD.1010204@free.fr> <427285CC.9090300@grupopie.com>
	 <29495f1d050429142515f7e2c4@mail.gmail.com> <4273A51E.6080503@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/05, Olivier Croquette <ocroquette@free.fr> wrote:
> Nish Aravamudan wrote:
> 
> > Perhaps not discussed before, but definitely a known issue. Check out
> > sys_nanosleep(), which adds an extra jiffy to the delay if there is
> > going to be one. My patch, which uses human-time (or at least more so
> > than currently), should not have issues like this.
> 
> What would be then the most precise and reliable delaying possibility in
> the present kernel?

With Paulo's patch, everything should be ok with itimers again. The
best you can get with HZ=1000 and sleeping is 1 millisecond (ideally).
If you are ok with busy-waiting, then you get pretty arbitrary delays
(usleep(), etc.).

If you are willing to up HZ (10000 would give you 500 us resolution),
things may get better. You could also try the HRT patches (not in
mainline): http://sourceforge.net/projects/high-res-timers/

Finally, I posted my RFC for a new soft-timer subsystem based on John
Stultz's timeofday rework last week.

Good luck,
Nish
