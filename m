Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWEJJ3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWEJJ3E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWEJJ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:29:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:50088 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964874AbWEJJ3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:29:03 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [patch 8/8] Add abilty to enable/disable nmi watchdog from sysfs
Date: Wed, 10 May 2006 11:28:57 +0200
User-Agent: KMail/1.9.1
Cc: dzickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net, perfmon@napali.hpl.hp.com
References: <20060509205035.446349000@drseuss.boston.redhat.com> <20060509205958.578466000@drseuss.boston.redhat.com> <20060510091026.GD21833@frankl.hpl.hp.com>
In-Reply-To: <20060510091026.GD21833@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605101128.57935.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, May 09, 2006 at 04:50:43PM -0400, dzickus wrote:
> > 
> > Adds a new /proc/sys/kernel/nmi call that will enable/disable the nmi
> > watchdog.
> > 
> 
> This means you can at runtime enable/disbale nmi_watchdog, i.e., reserve
> some performance counters on the fly. This gets complicated because now
> the perfmon subsystem 

Right now we don't care about perfmon at all because it's not in (x86) mainline
If you want anybody to care you have to submit and pass review

> (and probably oprofile) cannot check register 
> availability when they are first initialized. Basically each time,
> the /sys entry is modified, they would have to scan the list of available
> performance counters. I don't know exactly when Oprofile does this checking.
> For perfmon, this is done only once, when the PMU description table is loaded.

I think the NMI watchdog will fail if the register is already allocated.
oprofile should check and allocate when it fills in the register. 

-Andi

