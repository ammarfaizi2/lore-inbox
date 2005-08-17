Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVHQAXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVHQAXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVHQAXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:23:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:2953 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750774AbVHQAXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:23:40 -0400
To: <Michael_E_Brown@Dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com.suse.lists.linux.kernel>
	<DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com.suse.lists.linux.kernel>
	<1124161828.10755.87.camel@soltek.michaels-house.net.suse.lists.linux.kernel>
	<20050816081622.GA22625@kroah.com.suse.lists.linux.kernel>
	<1124199265.10755.310.camel@soltek.michaels-house.net.suse.lists.linux.kernel>
	<20050816203706.GA27198@kroah.com.suse.lists.linux.kernel>
	<4277B1B44843BA48B0173B5B0A0DED43528192@ausx3mps301.aus.amer.dell.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Aug 2005 02:23:35 +0200
In-Reply-To: <4277B1B44843BA48B0173B5B0A0DED43528192@ausx3mps301.aus.amer.dell.com.suse.lists.linux.kernel>
Message-ID: <p73br3x1ke0.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Michael_E_Brown@Dell.com> writes:
> 2) Dell OpenManage
>     The main use of this driver by openmanage will be to read the System 
> Event Log that BIOS keeps. Here are some other random relevant points:

Are there machine check events from the last boot in that event log? 

If yes it would be extremly cool to feed this data into mcelog 
using the /dev/mcelog device after boot up. It probably would
need a few functions in exported in arch/x86_64/kernel/mce.c,
but I would be fine with that. The advantage would be that
all machine checks would be in a common log and can be easily 
analyzed by higher level infrastructure (like a cluster manager) 

The code used to dump the MCEs from the hardware registers left over
at boot, but so many BIOS keep bogus data in there that this had to be
turned off.

Only tricky part might be to make sure this data is not logged
twice.

I think it would be better to do this in kernel space if it's
simple enough. In theory mcelog could get a write method too
so that user space could inject events, but that would
have the disadvantage that everybody distribution would need
a magic Dell specific program to just do that. In the kernel it would just
work transparently.

/dev/mcelog only exists on x86-64 right now, but will
probably appear on i386 at some point too.

-Andi
