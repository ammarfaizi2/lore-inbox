Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVCaBcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVCaBcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVCaBcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:32:41 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:60372 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262534AbVCaBc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:32:27 -0500
Subject: Re: 2.6.11, USB: High latency?
From: Lee Revell <rlrevell@joe-job.com>
To: David Brownell <david-b@pacbell.net>
Cc: kus Kusche Klaus <kus@keba.com>, stern@rowland.harvard.edu,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200503301728.09969.david-b@pacbell.net>
References: <200503301457.35464.david-b@pacbell.net>
	 <1112230265.19975.21.camel@mindpipe>
	 <200503301728.09969.david-b@pacbell.net>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 20:32:26 -0500
Message-Id: <1112232746.19975.41.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 17:28 -0800, David Brownell wrote:
> On Wednesday 30 March 2005 4:51 pm, Lee Revell wrote:
> > [cc list restored]
> 
> Thanks, I never had one to start with ... :)
> 
> 

Thank you.  Sorry for the tone of my reply...

> > On Wed, 2005-03-30 at 14:57 -0800, David Brownell wrote:
> > > Quoth rlevell@joe-job.com:
> > > > I think this is connected to a problem people have been reporting on the
> > > > Linux audio lists.  With some USB chipsets, USB audio interfaces just
> > > > don't work.  There are dropouts even at very high latencies.  
> > > 
> > > Well, I'd not yet expect USB audio to work over EHCI quite yet,
> > > though one of the patches Greg just posted should help some of
> > > the issues with full speed iso through USB 2.0 hubs.  (At least
> > > for OUT transfers as to speakers.)
> > > 
> > 
> > This is the exact configuration of one of the users who reported the
> > problem on LAU.  Got a pointer to the patch?  And what's the issue with
> > IN transfers?
> 
> This is what Greg just posted (and Linus merged into BK, so it'll be
> in BK snapshots starting tomorrow):
> 
>   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=111221966815043&w=2
> 
> The issue with IN transfers is that microframe scheduling is ... tricky.
> One must track all kinds of stuff (which TTs are involved, which microframes
> are busy, how busy they are, how much non-TT bandwidth is available).  And
> the relevant EHCI data structures are almost as irregular as the USB trees
> one must cope with.
> 
> Plus one must have the time to spend debugging and fixing the problems, stress
> testing the fixes, and devices that will trigger the problems.  I've had none
> of those, for quite some time now.  (My particular USB speakers have pretty much
> always worked on Linux, even through a USB 2.0 hub.)
> 
> Karsten has some not-ready-for-prime-time patches which he's posted
> recently.  They basically hardwire some of the scheduling outputs well
> enough to get some of his IN transfers to work.  Maybe he'll be nice
> enough to repost them against current BK (they include the patch above).
> 

Thanks for the explanation.  I found this patch, and sent the link to
the LAU posters with the problem.

There are apparently many users affected (some gave up and went back to
2.4), so there's good opportunity for testing.

> I'd like to see all that split ISO stuff working with EHCI, but someone
> else is going to have to do most of the work.  Once it's working we can
> take the CONFIG_EXPERIMENTAL off, which will remove another source of
> errors.  :)

Thanks again for your help, I'll report any interesting results.

Lee

