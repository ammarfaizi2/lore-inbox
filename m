Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265564AbUAZHXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 02:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbUAZHXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 02:23:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:62875 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265564AbUAZHXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 02:23:39 -0500
X-Authenticated: #12437197
Date: Mon, 26 Jan 2004 09:23:37 +0200
From: Dan Aloni <da-x@gmx.net>
To: Karim Yaghmour <karim@opersys.com>
Cc: Nuno Silva <nuno.silva@vgertech.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Cooperative Linux
Message-ID: <20040126072337.GA10355@callisto.yi.org>
References: <20040125193518.GA32013@callisto.yi.org> <40148C1C.5040102@vgertech.com> <20040126042631.GA401@callisto.yi.org> <40149F25.1040209@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40149F25.1040209@opersys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 12:01:25AM -0500, Karim Yaghmour wrote:
> 
> Dan Aloni wrote:
> >I can't say exactly when, but several people volunteered to work on this. 
> 
> BTW, I've been looking at the code. Many of the tricks done for forcing
> NT to share resources with Linux should be unnecessary for a Linux setup.
> Also, the code apparently assumes only two OSes. You probably want to
> check the detailed discussion I had written some time ago about how to
> easily obtain an SMP cluster with Linux (N instances on separate CPUs
> with very few code modifications required):
> http://www.opersys.com/adeos/dox/practical-smp-clusters/practical-smp-clusters.html
> Some of the code you've already written can be used as-is to this end.
> The nanokernel side still needs some extending, but you've brought things
> one step closer to completion.

The code doesn't assume two OS's. It only assumes that the VM monitor 
switches between the host OS and the guest OS alone, but that doesn't 
prevent you from running two or more monitors, which would be scheduled 
by the host OS scheduler.

> On a UP system, instead of running just 2 instances, you can load a
> nanokernel in a fixed RAM region and remap it in every instance's
> virtual memory. You can then use a slightly modified kexec to start
> independent images in different RAM regions. I had discussed this
> with Eric at the last OLS and he was interested. The added
> advantage with Adeos is that you could then share a single interrupt
> pipeline among all OSes, and have different OSes manage different hardware
> components. Of course, if you add the PCI allocation code I cover in the
> above paper, you can then have things like two kernels independently
> managing, for example, two seperate sets of ethernet card and SCSI disk.
> There's some pretty cool stuff to be done here, away from the simple
> virtual devices. You could also have a virtual ethernet layer which is
> shared by all OS images, and then have a private network between all
> OS instances. With Adeos, you can also have one kernel take care of
> all hard-rt operations and another kernel take care of the soft-rt
> operations. All of it is fairly hardware independent.

That's interesting, but allowing Cooperative Linux to directly access 
the hardware is problematic on systems like Windows. coLinux's goal is 
more focused on bringing Linux to other operating systems than resources 
sharing among several operating systems.

However, I have no doubt it can be used to run several virtual Linux's 
on a single SMP Linux machine, with emphasis on the 'virtual'. 

-- 
Dan Aloni
da-x@gmx.net
