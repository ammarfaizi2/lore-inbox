Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTHZGrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 02:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTHZGrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 02:47:42 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:60640 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S262718AbTHZGrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 02:47:40 -0400
Date: Tue, 26 Aug 2003 00:15:58 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Werner Almesberger <wa@almesberger.net>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
In-Reply-To: <20030826024808.B3448@almesberger.net>
Message-ID: <Pine.LNX.4.44.0308260010480.31955-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	

On Tue, 26 Aug 2003, Werner Almesberger wrote:

> Nagendra Singh Tomar wrote:
> > 	While going thru the code for tasklet_kill(), I cannot figure
> out 
> > how recursive tasklets (tasklets that schedule themselves from within 
> > their tasklet handler) can be killed by this function. To me it looks
> that 
> > tasklet_kill will never complete for such tasklets.
> 
> That's also what I found when looking at it a while ago. This isn't
> necessarily a bug of tasklet_kill, just some behaviour that needs
> to be documented.

I fail to understand this. How can we say that its not a bug. If we 
support recursive tasklets, we should support killing them also. If we can 
do it why not do it. Is there any reason for that.


> 
> You can always introduce a flag that tells the tasklet if it should
> reschedule itself, and clear that flag before calling tasklet_kill.
> 
> When I looked at it (I think this was in some 2.4 kernel), it also
> seemed that tasklet_kill could loop forever if the tasklet is
> scheduled but disabled.

You r right. Its a similar problem. TASKLET_STATE_SCHED will never get 
reset for disabled tasklets.
I feel that these issues can be addresses easily by adding a couple of 
checks.

> 
> - Werner
> 
> 

Thanx
tomar

