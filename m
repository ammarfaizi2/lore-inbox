Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVCaB2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVCaB2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVCaB2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:28:36 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:1974 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262512AbVCaB20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:28:26 -0500
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.11, USB: High latency?
Date: Wed, 30 Mar 2005 17:28:09 -0800
User-Agent: KMail/1.7.1
Cc: kus Kusche Klaus <kus@keba.com>, stern@rowland.harvard.edu,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200503301457.35464.david-b@pacbell.net> <1112230265.19975.21.camel@mindpipe>
In-Reply-To: <1112230265.19975.21.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301728.09969.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 4:51 pm, Lee Revell wrote:
> [cc list restored]

Thanks, I never had one to start with ... :)


> On Wed, 2005-03-30 at 14:57 -0800, David Brownell wrote:
> > Quoth rlevell@joe-job.com:
> > > I think this is connected to a problem people have been reporting on the
> > > Linux audio lists.  With some USB chipsets, USB audio interfaces just
> > > don't work.  There are dropouts even at very high latencies.  
> > 
> > Well, I'd not yet expect USB audio to work over EHCI quite yet,
> > though one of the patches Greg just posted should help some of
> > the issues with full speed iso through USB 2.0 hubs.  (At least
> > for OUT transfers as to speakers.)
> > 
> 
> This is the exact configuration of one of the users who reported the
> problem on LAU.  Got a pointer to the patch?  And what's the issue with
> IN transfers?

This is what Greg just posted (and Linus merged into BK, so it'll be
in BK snapshots starting tomorrow):

  http://marc.theaimsgroup.com/?l=linux-usb-devel&m=111221966815043&w=2

The issue with IN transfers is that microframe scheduling is ... tricky.
One must track all kinds of stuff (which TTs are involved, which microframes
are busy, how busy they are, how much non-TT bandwidth is available).  And
the relevant EHCI data structures are almost as irregular as the USB trees
one must cope with.

Plus one must have the time to spend debugging and fixing the problems, stress
testing the fixes, and devices that will trigger the problems.  I've had none
of those, for quite some time now.  (My particular USB speakers have pretty much
always worked on Linux, even through a USB 2.0 hub.)

Karsten has some not-ready-for-prime-time patches which he's posted
recently.  They basically hardwire some of the scheduling outputs well
enough to get some of his IN transfers to work.  Maybe he'll be nice
enough to repost them against current BK (they include the patch above).

I'd like to see all that split ISO stuff working with EHCI, but someone
else is going to have to do most of the work.  Once it's working we can
take the CONFIG_EXPERIMENTAL off, which will remove another source of
errors.  :)

- Dave

