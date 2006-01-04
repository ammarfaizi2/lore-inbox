Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWADXBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWADXBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWADXBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:01:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751142AbWADXA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:00:59 -0500
Date: Wed, 4 Jan 2006 15:01:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [patch 2.6.15] i386: Optimize local APIC timer interrupt code
Message-Id: <20060104150139.34829833.akpm@osdl.org>
In-Reply-To: <200601041352_MC3-1-B550-4606@compuserve.com>
References: <200601041352_MC3-1-B550-4606@compuserve.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> Local APIC timer interrupt happens HZ times per second on each CPU.
> 
> Optimize it for the case where profile multiplier equals one and does
> not change (99+% of cases); this saves about 20 CPU cycles on Pentium II.
> 
> Also update the old multiplier immediately after noticing it changed,
> while values are register-hot, saving eight bytes of stack depth.

The code which you're patching is cheerfully nuked by a patch in Andi's
tree:
ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/no-subjiffy-profile

I don't immediately understand that patch and I don't recall seeing it
discussed - maybe I was asleep.

It removes the profile multiplier (readprofile -M).  I've used that
occasionally, but can't say that I noticed much benefit from it.

What's the thinking here?
