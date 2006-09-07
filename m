Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWIGVFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWIGVFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 17:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWIGVFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 17:05:42 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:54709 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422669AbWIGVFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 17:05:40 -0400
Date: Fri, 8 Sep 2006 02:35:19 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ankita@in.ibm.com, linux-kernel@vger.kernel.org, fernando@oss.ntt.co.jp
Subject: Re: [RFC] Linux Kernel Dump Test Module
Message-ID: <20060907210519.GA6770@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20060907135329.GA17937@in.ibm.com> <20060907134850.c05f3be2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907134850.c05f3be2.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 01:48:50PM -0700, Andrew Morton wrote:
> On Thu, 7 Sep 2006 19:23:29 +0530
> Ankita Garg <ankita@in.ibm.com> wrote:
> 
> > Please find below a patch for a simple module to test Linux Kernel Dump 
> > mechanism. This module uses jprobes to install/activate pre-defined crash
> > points. At different crash points, various types of crashing scenarios 
> > are created like a BUG(), panic(), exception, recursive loop and stack 
> > overflow. The user can activate a crash point with specific type by
> > providing parameters at the time of module insertion. Please see the file
> > header for usage information. The module is based on the Linux Kernel
> > Dump Test Tool by Fernando <http://lkdtt.sourceforge.net>.
> > 
> > This module could be merged with mainline. Jprobes is used here so that the 
> > context in which crash point is hit, could be maintained. This implements
> > all the crash points as done by LKDTT except the one in the middle of 
> > tasklet_action(). 
> 
> "could be merged with mainline": why "could"?  What would be the
> disadvantages of doing this?
> 
I don't see disadvantages, probably the usefulness is in doubt.

> I think having test code like this in mainline is a good idea, particularly
> for a subsystem like [kj]probes.
> 
Do you mean using [kj]probes? 

> It's a bit regrettable that the code "knows" about particular not-exported,
> arch-specific core kernel functions, but I guess those don't change very
> often, so we won't be forever patching this module.
> 
Probes at the beginning of the routine instead of at some offset (the
way it is already done), should reduce the rework burdon.

The crashpoints are in core kernel internal routines but I donot see 
any "arch-specific" functions selected. I think the module can be used for 
any architecture with jprobe support.

Thanks
Maneesh
