Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbVEIGdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbVEIGdg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 02:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbVEIGdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 02:33:36 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:57562 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263062AbVEIGdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 02:33:33 -0400
Date: Mon, 9 May 2005 17:35:09 +0530
From: R Sharada <sharada@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: paulus@samba.org, torvalds@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, miltonm@bga.com, fastboot@lists.osdl.org
Subject: Re: [PATCH] ppc64: kexec support for ppc64
Message-ID: <20050509120509.GA9149@in.ibm.com>
Reply-To: sharada@in.ibm.com
References: <17019.3752.917407.742713@cargo.ozlabs.ibm.com> <20050506124158.GA2741@in.ibm.com> <20050506124409.GB2741@in.ibm.com> <20050506160546.388aeed4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506160546.388aeed4.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Fri, May 06, 2005 at 04:05:46PM -0700, Andrew Morton wrote:
> R Sharada <sharada@in.ibm.com> wrote:
> >
> > This patch implements the kexec support for ppc64
> 
> Well that's pretty neat.   How well does this work?
> 

We have tested the kexec support for ppc64, on the following platforms:                                                                                
- Power4 (p630), in lpar, non-lpar mode
- Power5

The Power4 testing was done on 4-cpu non-lpar and 2-cpu lpar configurations.
                                                                                
        It has been tested to work in both the lpar and non-lpar environments,
on Power4 and we have tested successive kexec reboots as well and found it to
work. The only thing that we found that had to be done was to make sure the
network interface was brought down, prior to reboot, as otherwise it would
sometimes cause EEH errors.
        Milton has tested it on his Power5 environment as well.
        On lpar on Power5, that Haren has been testing, he has been observing
that in 2nd or 3rd successive kexec reboot, the IPR SCSI driver initially comes
up ok but after a while interrupts seem to be getting disabled and while the h/wis sending the interrupts, they do not get serviced and are getting lost. Haren
has been working on debugging this, with assistance from Milton.
                                                                                
We however, do not have the kexec-tools code for ppc64 inside of kexec-tools.
We have been using home-grown code for loading, generating the device-tree data
and assembly trampoline code for the kexec transition to the new kernel. This
tools is currently hosted at the following url:
http://www.kernel.org/pub/linux/kernel/people/suparna/kdump/ppc64-tools-20050331.tar.gz

I am currently working on integrating them into Eric's kexec-tools. 

> I assume you'll be working on kdump-via-kexec for ppc64?
> 
Yes, once the kexec-tools is integrated into Eric's kexec-tools, we will work
on getting the kdump parts in place for ppc64.

Thanks and Regards,
Sharada
