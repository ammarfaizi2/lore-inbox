Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSJ1XLU>; Mon, 28 Oct 2002 18:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSJ1XLU>; Mon, 28 Oct 2002 18:11:20 -0500
Received: from unthought.net ([212.97.129.24]:19904 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S261375AbSJ1XLS>;
	Mon, 28 Oct 2002 18:11:18 -0500
Date: Tue, 29 Oct 2002 00:17:38 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] AIM Independent Resource Benchmark  results for kernel-2.5.44
Message-ID: <20021028231738.GC15779@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
References: <fa.d95885v.1d14t8c@ifi.uio.no> <037101c27c84$70015ce0$9865fea9@PCJohn> <20021028182839.GA2030@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021028182839.GA2030@sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 12:28:39PM -0600, Nathan Straz wrote:
> > 
> > The AIM7/AIM9 new_raph is broken code.  The convergence loop termination
> > conditional looks something like:
> >    if (delta == 0) break;
> > for a type "double" delta.  You ought to change that to be something
> > like:
> >    if (delta <= 0.00000001L) break;
> 
> I usually specify the compiler flag -ffloat-store and that fixes the
> issue for me.  

Maybe that will work as a work-around.  But it is nothing but a
work-around. The previous poster was right - the code is broken.

The "==" operator usually doesn't have any reasonable use on floating
point values (yes there are cases where it makes sense, but this is not
one of them).

A result from any computation on double values cannot be assumed to
"equal" anything in particular. Zero included.

The correct way to terminate that loop is, like was already suggested,
doing a comparison to see if the residual is "numerically zero" or
"sufficiently zero-ish for the given purpose". Eg.  "delta < 1E-12" or
eventually "fabs(delta) < 1E-12".

Comparing to zero makes *no* sense.  It's written by someone who has no
understanding of numerics (or perhaps just didn't think clearly at that
moment - /me trying not to insult more people than strictly necessary ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
