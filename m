Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271399AbTHMGml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271400AbTHMGml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:42:41 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:48542
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271399AbTHMGmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:42:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O14int
Date: Wed, 13 Aug 2003 16:48:18 +1000
User-Agent: KMail/1.5.3
References: <200308090149.25688.kernel@kolivas.org> <200308120033.32391.kernel@kolivas.org> <1060615179.13255.133.camel@workshop.saharacpt.lan>
In-Reply-To: <1060615179.13255.133.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308121545.52042.kernel@kolivas.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resent because the lkml spam filter thought this was spam originally]

Thanks for detailed description.

On Tue, 12 Aug 2003 01:19, Martin Schlemmer wrote:
> Normal run of things there is many times 1-3 'make -j6s' running.
> Yes, sure, for on of them you prob should use -j4, but hey its
> in the head, right =).  No, it is not kernels, it is a variety

Actually in benchmarking I've found no increase in speed with more than one 
job per cpu but it's up to you of course.

> of stuff - goes with the distro i guess.  Yes, I have tested
> runs of 'make -j12' and 'make -j24' (sorry, should have been more
> precise, but -j{6,12,24) was used as testing, with -j6 default)
> running dual makes.
>
> With vanilla the mouse pointer, XMMS, switching desktops or
> windows is smooth.  If I really hammer the system, it does
> 'slow down' the general navigation of X a little, but not
> so that that mouse pointer is jerky, etc.  With the O??int
> patches things starts to 'stutter' under loads that is fairly
> under those that vanilla handles fine.  The mouse gets jerky,
> switching desktops is notably lagging.

Yes what you're describing is the expiring X issue. At this moment in time 
with my patches with very high loads, it is easy for interactive tasks to 
expire if used for sustained periods. This means that they will be smoother 
than vanilla for a burst, then have a nasty blip when falling on the expired 
array. This doesn't happen at lower loads, and is representative of the hard 
to optimise for case - the interactive task that behaves occasionally like a 
cpu hog (ie X). Lots of suggestions for ways around this have been offered, 
but none address the fact that these will cause starvation of other loads. 
Note that I say the vanilla scheduler does cause starvation already in the 
wrong circumstances if you offer that as a solution to go back to it. Suffice 
to say I'm still working on it as my highest priority.

Note that tasks that are never cpu hogs (eg xmms) will never stutter or falter 
under these circumstances; which is why I stopped mentioning audio ages ago: 
audio works without problems under normal and extreme circumstances with my 
patches unless you renice a cpu hog to better priority than your audio app. 
Note that despite all this, since people are so excited by the idea of 
soft RR scheduling, I actually wrote a patch that will work with my tweaks a 
while ago. I've not optimised or improved it at all because that is lower 
priority to me than getting the general interactivity correct. For those 
interested, it's in my experimental directory in kernel.kolivas.org/2.5

> Note that I am not talking about starving XMMS/the make's.
> I am just talking general navigation of X.  Yes, even with
> vanilla things do start a bit slower, but the mouse goes
> where it should, and its not as if the vga struggles to
> redraw the screen on desktop switch.  I do not expect the
> system to behave for 'interactive' processes and xmms/whatever
> as if there is no load - the signs of load is just way more
> than with vanilla.

As discussed above. Thanks for your report.

Con

