Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267223AbUIOSaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267223AbUIOSaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUIOSaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:30:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:7326 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267230AbUIOSaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:30:05 -0400
Date: Wed, 15 Sep 2004 11:28:31 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <41488346.1020101@mvista.com>
Message-ID: <Pine.LNX.4.58.0409151127170.10451@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <41381C2D.7080207@mvista.com>  <1094239673.14662.510.camel@cog.beaverton.ibm.com>
  <4138EBE5.2080205@mvista.com>  <1094254342.29408.64.camel@cog.beaverton.ibm.com>
  <41390622.2010602@mvista.com>  <1094666844.29408.67.camel@cog.beaverton.ibm.com>
  <413F9F17.5010904@mvista.com>  <1094691118.29408.102.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com> 
 <1094700768.29408.124.camel@cog.beaverton.ibm.com>  <413FDC9F.1030409@mvista.com>
  <1094756870.29408.157.camel@cog.beaverton.ibm.com>  <4140C1ED.4040505@mvista.com>
  <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0409141045370.6963@schroedinger.engr.sgi.com>
 <41479369.6020506@mvista.com> <Pine.LNX.4.58.0409142024270.10739@schroedinger.engr.sgi.com>
 <4147F774.6000800@mvista.com> <Pine.LNX.4.58.0409150843270.14721@schroedinger.engr.sgi.com>
 <41488346.1020101@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Sep 2004, George Anzinger wrote:
> > I am not following you here. Why does the context switch overhead
> > increase? Because there are multiple interrupts for different tasks done
> > in the tick?
> >
> Each task has several timers, i.e. time slice, time limit, and possibly itimer
> profile.  Granted only one of these needs to be sent to the timer code, but that
> takes a bit of time, not much, but enough to increase the context switch
> overhead such that a system with a modest amount of context switching will incur
> more timer management overhead than the periodic tick generates.

I thought that the timer handling could be separate from the time slice
handling of the scheduler. With the ability schedule events as needed the
scheduler could generate its own independent timing from the necessary
clock adjustments. The tick would be disassembled into its various
components.

