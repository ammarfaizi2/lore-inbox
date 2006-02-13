Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWBMFv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWBMFv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 00:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWBMFv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 00:51:29 -0500
Received: from mail.gmx.net ([213.165.64.21]:45249 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750807AbWBMFv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 00:51:28 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, gcoady@gmail.com,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200602131637.43335.kernel@kolivas.org>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602131605.17198.kernel@kolivas.org> <1139808766.7642.12.camel@homer>
	 <200602131637.43335.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 06:57:04 +0100
Message-Id: <1139810224.7935.9.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 16:37 +1100, Con Kolivas wrote:
> On Monday 13 February 2006 16:32, MIke Galbraith wrote:
> > On Mon, 2006-02-13 at 16:05 +1100, Con Kolivas wrote:
> > > On Monday 13 February 2006 15:59, MIke Galbraith wrote:
> > > > Now, let's see if we can get your problem fixed with something that can
> > > > possibly go into 2.6.16 as a bugfix.  Can you please try the below?
> > >
> > > These sorts of changes definitely need to pass through -mm first... and
> > > don't forget -mm looks quite different to mainline.
> >
> > I'll leave that up to Ingo of course, and certainly have no problem with
> > them burning in mm.  However, I must say that I personally classify
> > these two changes as being trivial and obviously correct enough to be
> > included in 2.6.16.  
> 
> This part I agree with:
> -               } else
> -                       requeue_task(next, array);
> +               }
> 
> The rest changes behaviour; it's not a "bug" so needs testing, should be a 
> separate patch from this part, and modified to suit -mm.

Well, both change behavior, and I heartily disagree.  Blocking a 700ms
sleep while allowing a 100ms sleep to bypass the same checkpoint only to
then be multiplied by 10 is a bug.

Actually, the point at which a task becomes interactive is the point at
which scheduler semantics change.  Ergo, as far as I'm concerned, this
should be a boundary which must be crossed before proceeding further.
That, I agree, would be a behavioral change which should be baked in mm.

	-Mike

