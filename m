Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269346AbUIBXsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269346AbUIBXsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269345AbUIBXpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:45:12 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58805 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269320AbUIBXlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:41:32 -0400
Date: Thu, 2 Sep 2004 16:39:44 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <1094166858.14662.367.camel@cog.beaverton.ibm.com>
Message-ID: <B6E8046E1E28D34EB815A11AC8CA312902CF6059@mtv-atc-605e--n.corp.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <1094159379.14662.322.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com> 
 <1094164096.14662.345.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409021536450.28532@schroedinger.engr.sgi.com>
 <1094166858.14662.367.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, john stultz wrote:

> Then you implement a fastcall for fastcall_readcyclonecounter(), which
> in crazy ia64 asm would do something like:
>
> ENTRY(fastcall_readcyclonecounter)
> blip	// magic privledge escalation
> blop	// load cyclone counter into memory
> bloop	// copy cyclone counter back into return register
> ;;
> END(fastcall_readcyclonecounter)
>
>
> This avoids 150+ lines of asm needed to re-implement the gettimeofday
> math.
>
> However, I could be mistaken. Is something like this possible?

Of course but its not a generic way of timer acccess and
requires a fastcall for each timer. You still have the problem of
exporting the frequency and the time offsets to user space (those also
need to be kept current in order for one to be able to calculate a timer
value!). The syscall/fastcall API then needs to be extended to allow for a
system call to access each of the individual timers supported.

And how would this be supported from user space? We link in special
libraries to support for cyclone and any other supported timers into
each program? I thought a kernel would provide hardware abstraction?

The current IA64 fastcall timer interface is generic and is bound into the
clock_gettime interface of glibc.
