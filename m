Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbTIQSgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 14:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbTIQSgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 14:36:05 -0400
Received: from [65.198.37.67] ([65.198.37.67]:30383 "EHLO gghcwest.com")
	by vger.kernel.org with ESMTP id S262615AbTIQSgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 14:36:03 -0400
Subject: Re: 2.4.23-pre4 compile failure in hw_random.c and aic7xxx on amd64
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1063823338.7731.9.camel@heat>
References: <1063823338.7731.9.camel@heat>
Content-Type: text/plain
Message-Id: <1063823762.8912.3.camel@heat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 17 Sep 2003 11:36:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-17 at 11:28, Jeffrey W. Baker wrote:
> hw_random.c: In function `via_init':
> hw_random.c:433: error: `MSR_VIA_RNG' undeclared (first use in this function)
> hw_random.c:433: error: (Each undeclared identifier is reported only once
> hw_random.c:433: error: for each function it appears in.)
> hw_random.c: In function `via_cleanup':
> hw_random.c:459: error: `MSR_VIA_RNG' undeclared (first use in this function)
> 
> The strange bit is that I didn't even have Intel/AMD/VIA hardware rng
> configured, only AMD 768/8??? rng support.  So it seems like some sort
> of bug in oldconfig.  After removing CONFIG_HW_RANDOM I can build again.
> 
> I also still have compile failures in drivers/scsi/aic7xxx due to
> Werror.

Follow-up:

fs/fs.o(.text+0x23ed7): In function `interrupts_open':
: undefined reference to `show_interrupts'

This appears to be defined on ppc64 and i386, but not x86_64.  Possibly
#ifndef CONFIG_X86 confusion because x86_64 sets CONFIG_X86_64 and
CONFIG_X86.  Not sure how to fix.

-jwb


