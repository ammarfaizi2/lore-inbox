Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbSKUStI>; Thu, 21 Nov 2002 13:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbSKUStI>; Thu, 21 Nov 2002 13:49:08 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:1249 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266965AbSKUStH>;
	Thu, 21 Nov 2002 13:49:07 -0500
Subject: Re: [RFC] [PATCH] subarch cleanup
From: john stultz <johnstul@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20021121183304.GA1144@mars.ravnborg.org>
References: <1037750429.4463.71.camel@w-jstultz2.beaverton.ibm.com>
	 <20021121183304.GA1144@mars.ravnborg.org>
Content-Type: text/plain
Organization: 
Message-Id: <1037904954.7576.62.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 21 Nov 2002 10:55:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 10:33, Sam Ravnborg wrote:
> >  ifdef CONFIG_VISWS
> > -MACHINE	:= mach-visws
> > +MACHINE_C	:= mach-visws
> > +MACHINE_H	:= mach-visws
> >  else
> > -MACHINE	:= mach-generic
> > +MACHINE_C	:= mach-generic
> > +MACHINE_H	:= mach-generic
> 
> No reason to have two different variables assigned the same value.

Actually, in some cases, such as summit, we only have one header file
that is different from generic. We don't want to replicate all the
generic .c files, So in that case MACHINE_C := mach-generic and
MACHINE_H := mach-summit. 

There very well could be a better way to do this, but splitting up the
.h files which fall back to generic nicely, and the .c files which don't
seemed to make the most sense. 

> If you are modifying this anyway consider something like:
> machine-y               := mach-generic
> machine-$(CONFIG_VISWS) := mach-visws
> 
> And then replace $(MACHINE) with $(machine-y).
> This makes it much cleaner to add summit for example.

I agree, it could be cleaned up. I'll see if I can't clean it up
further.

thanks for the feedback
-john


